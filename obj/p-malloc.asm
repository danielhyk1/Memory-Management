
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 2f 20 10 00       	mov    $0x10202f,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 0f 00 00 	mov    %rax,0xfe9(%rip)        # 101008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 0f 00 00 	mov    %rax,0xfcd(%rip)        # 101000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 00 02 00 00       	callq  10023c <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 a4 0a 00 00       	callq  100b08 <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100071:	48 89 f9             	mov    %rdi,%rcx
  100074:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100076:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  10007d:	00 
  10007e:	72 08                	jb     100088 <console_putc+0x17>
        cp->cursor = console;
  100080:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  100087:	00 
    }
    if (c == '\n') {
  100088:	40 80 fe 0a          	cmp    $0xa,%sil
  10008c:	74 16                	je     1000a4 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  10008e:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100092:	48 8d 50 02          	lea    0x2(%rax),%rdx
  100096:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10009a:	40 0f b6 f6          	movzbl %sil,%esi
  10009e:	09 fe                	or     %edi,%esi
  1000a0:	66 89 30             	mov    %si,(%rax)
    }
}
  1000a3:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  1000a4:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  1000a8:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  1000af:	4c 89 c6             	mov    %r8,%rsi
  1000b2:	48 d1 fe             	sar    %rsi
  1000b5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1000bc:	66 66 66 
  1000bf:	48 89 f0             	mov    %rsi,%rax
  1000c2:	48 f7 ea             	imul   %rdx
  1000c5:	48 c1 fa 05          	sar    $0x5,%rdx
  1000c9:	49 c1 f8 3f          	sar    $0x3f,%r8
  1000cd:	4c 29 c2             	sub    %r8,%rdx
  1000d0:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  1000d4:	48 c1 e2 04          	shl    $0x4,%rdx
  1000d8:	89 f0                	mov    %esi,%eax
  1000da:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1000dc:	83 cf 20             	or     $0x20,%edi
  1000df:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1000e3:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1000e7:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1000eb:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1000ee:	83 c0 01             	add    $0x1,%eax
  1000f1:	83 f8 50             	cmp    $0x50,%eax
  1000f4:	75 e9                	jne    1000df <console_putc+0x6e>
  1000f6:	c3                   	retq   

00000000001000f7 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1000f7:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1000fb:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1000ff:	73 0b                	jae    10010c <string_putc+0x15>
        *sp->s++ = c;
  100101:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100105:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  100109:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  10010c:	c3                   	retq   

000000000010010d <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  10010d:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100110:	48 85 d2             	test   %rdx,%rdx
  100113:	74 17                	je     10012c <memcpy+0x1f>
  100115:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  10011a:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  10011f:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100123:	48 83 c1 01          	add    $0x1,%rcx
  100127:	48 39 d1             	cmp    %rdx,%rcx
  10012a:	75 ee                	jne    10011a <memcpy+0xd>
}
  10012c:	c3                   	retq   

000000000010012d <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  10012d:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100130:	48 39 fe             	cmp    %rdi,%rsi
  100133:	72 1d                	jb     100152 <memmove+0x25>
        while (n-- > 0) {
  100135:	b9 00 00 00 00       	mov    $0x0,%ecx
  10013a:	48 85 d2             	test   %rdx,%rdx
  10013d:	74 12                	je     100151 <memmove+0x24>
            *d++ = *s++;
  10013f:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100143:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  100147:	48 83 c1 01          	add    $0x1,%rcx
  10014b:	48 39 ca             	cmp    %rcx,%rdx
  10014e:	75 ef                	jne    10013f <memmove+0x12>
}
  100150:	c3                   	retq   
  100151:	c3                   	retq   
    if (s < d && s + n > d) {
  100152:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  100156:	48 39 cf             	cmp    %rcx,%rdi
  100159:	73 da                	jae    100135 <memmove+0x8>
        while (n-- > 0) {
  10015b:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  10015f:	48 85 d2             	test   %rdx,%rdx
  100162:	74 ec                	je     100150 <memmove+0x23>
            *--d = *--s;
  100164:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  100168:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10016b:	48 83 e9 01          	sub    $0x1,%rcx
  10016f:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100173:	75 ef                	jne    100164 <memmove+0x37>
  100175:	c3                   	retq   

0000000000100176 <memset>:
void* memset(void* v, int c, size_t n) {
  100176:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100179:	48 85 d2             	test   %rdx,%rdx
  10017c:	74 12                	je     100190 <memset+0x1a>
  10017e:	48 01 fa             	add    %rdi,%rdx
  100181:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100184:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100187:	48 83 c1 01          	add    $0x1,%rcx
  10018b:	48 39 ca             	cmp    %rcx,%rdx
  10018e:	75 f4                	jne    100184 <memset+0xe>
}
  100190:	c3                   	retq   

0000000000100191 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100191:	80 3f 00             	cmpb   $0x0,(%rdi)
  100194:	74 10                	je     1001a6 <strlen+0x15>
  100196:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  10019b:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  10019f:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1001a3:	75 f6                	jne    10019b <strlen+0xa>
  1001a5:	c3                   	retq   
  1001a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1001ab:	c3                   	retq   

00000000001001ac <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  1001ac:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001af:	ba 00 00 00 00       	mov    $0x0,%edx
  1001b4:	48 85 f6             	test   %rsi,%rsi
  1001b7:	74 11                	je     1001ca <strnlen+0x1e>
  1001b9:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1001bd:	74 0c                	je     1001cb <strnlen+0x1f>
        ++n;
  1001bf:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001c3:	48 39 d0             	cmp    %rdx,%rax
  1001c6:	75 f1                	jne    1001b9 <strnlen+0xd>
  1001c8:	eb 04                	jmp    1001ce <strnlen+0x22>
  1001ca:	c3                   	retq   
  1001cb:	48 89 d0             	mov    %rdx,%rax
}
  1001ce:	c3                   	retq   

00000000001001cf <strcpy>:
char* strcpy(char* dst, const char* src) {
  1001cf:	48 89 f8             	mov    %rdi,%rax
  1001d2:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1001d7:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1001db:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1001de:	48 83 c2 01          	add    $0x1,%rdx
  1001e2:	84 c9                	test   %cl,%cl
  1001e4:	75 f1                	jne    1001d7 <strcpy+0x8>
}
  1001e6:	c3                   	retq   

00000000001001e7 <strcmp>:
    while (*a && *b && *a == *b) {
  1001e7:	0f b6 07             	movzbl (%rdi),%eax
  1001ea:	84 c0                	test   %al,%al
  1001ec:	74 1a                	je     100208 <strcmp+0x21>
  1001ee:	0f b6 16             	movzbl (%rsi),%edx
  1001f1:	38 c2                	cmp    %al,%dl
  1001f3:	75 13                	jne    100208 <strcmp+0x21>
  1001f5:	84 d2                	test   %dl,%dl
  1001f7:	74 0f                	je     100208 <strcmp+0x21>
        ++a, ++b;
  1001f9:	48 83 c7 01          	add    $0x1,%rdi
  1001fd:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  100201:	0f b6 07             	movzbl (%rdi),%eax
  100204:	84 c0                	test   %al,%al
  100206:	75 e6                	jne    1001ee <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  100208:	3a 06                	cmp    (%rsi),%al
  10020a:	0f 97 c0             	seta   %al
  10020d:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100210:	83 d8 00             	sbb    $0x0,%eax
}
  100213:	c3                   	retq   

0000000000100214 <strchr>:
    while (*s && *s != (char) c) {
  100214:	0f b6 07             	movzbl (%rdi),%eax
  100217:	84 c0                	test   %al,%al
  100219:	74 10                	je     10022b <strchr+0x17>
  10021b:	40 38 f0             	cmp    %sil,%al
  10021e:	74 18                	je     100238 <strchr+0x24>
        ++s;
  100220:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100224:	0f b6 07             	movzbl (%rdi),%eax
  100227:	84 c0                	test   %al,%al
  100229:	75 f0                	jne    10021b <strchr+0x7>
        return NULL;
  10022b:	40 84 f6             	test   %sil,%sil
  10022e:	b8 00 00 00 00       	mov    $0x0,%eax
  100233:	48 0f 44 c7          	cmove  %rdi,%rax
}
  100237:	c3                   	retq   
  100238:	48 89 f8             	mov    %rdi,%rax
  10023b:	c3                   	retq   

000000000010023c <rand>:
    if (!rand_seed_set) {
  10023c:	83 3d d1 0d 00 00 00 	cmpl   $0x0,0xdd1(%rip)        # 101014 <rand_seed_set>
  100243:	74 1b                	je     100260 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100245:	69 05 c1 0d 00 00 0d 	imul   $0x19660d,0xdc1(%rip),%eax        # 101010 <rand_seed>
  10024c:	66 19 00 
  10024f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100254:	89 05 b6 0d 00 00    	mov    %eax,0xdb6(%rip)        # 101010 <rand_seed>
    return rand_seed & RAND_MAX;
  10025a:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10025f:	c3                   	retq   
    rand_seed = seed;
  100260:	c7 05 a6 0d 00 00 9e 	movl   $0x30d4879e,0xda6(%rip)        # 101010 <rand_seed>
  100267:	87 d4 30 
    rand_seed_set = 1;
  10026a:	c7 05 a0 0d 00 00 01 	movl   $0x1,0xda0(%rip)        # 101014 <rand_seed_set>
  100271:	00 00 00 
}
  100274:	eb cf                	jmp    100245 <rand+0x9>

0000000000100276 <srand>:
    rand_seed = seed;
  100276:	89 3d 94 0d 00 00    	mov    %edi,0xd94(%rip)        # 101010 <rand_seed>
    rand_seed_set = 1;
  10027c:	c7 05 8e 0d 00 00 01 	movl   $0x1,0xd8e(%rip)        # 101014 <rand_seed_set>
  100283:	00 00 00 
}
  100286:	c3                   	retq   

0000000000100287 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100287:	55                   	push   %rbp
  100288:	48 89 e5             	mov    %rsp,%rbp
  10028b:	41 57                	push   %r15
  10028d:	41 56                	push   %r14
  10028f:	41 55                	push   %r13
  100291:	41 54                	push   %r12
  100293:	53                   	push   %rbx
  100294:	48 83 ec 58          	sub    $0x58,%rsp
  100298:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  10029c:	0f b6 02             	movzbl (%rdx),%eax
  10029f:	84 c0                	test   %al,%al
  1002a1:	0f 84 b0 06 00 00    	je     100957 <printer_vprintf+0x6d0>
  1002a7:	49 89 fe             	mov    %rdi,%r14
  1002aa:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1002ad:	41 89 f7             	mov    %esi,%r15d
  1002b0:	e9 a4 04 00 00       	jmpq   100759 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  1002b5:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1002ba:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1002c0:	45 84 e4             	test   %r12b,%r12b
  1002c3:	0f 84 82 06 00 00    	je     10094b <printer_vprintf+0x6c4>
        int flags = 0;
  1002c9:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1002cf:	41 0f be f4          	movsbl %r12b,%esi
  1002d3:	bf 51 0f 10 00       	mov    $0x100f51,%edi
  1002d8:	e8 37 ff ff ff       	callq  100214 <strchr>
  1002dd:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1002e0:	48 85 c0             	test   %rax,%rax
  1002e3:	74 55                	je     10033a <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1002e5:	48 81 e9 51 0f 10 00 	sub    $0x100f51,%rcx
  1002ec:	b8 01 00 00 00       	mov    $0x1,%eax
  1002f1:	d3 e0                	shl    %cl,%eax
  1002f3:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1002f6:	48 83 c3 01          	add    $0x1,%rbx
  1002fa:	44 0f b6 23          	movzbl (%rbx),%r12d
  1002fe:	45 84 e4             	test   %r12b,%r12b
  100301:	75 cc                	jne    1002cf <printer_vprintf+0x48>
  100303:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  100307:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  10030d:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  100314:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  100317:	0f 84 a9 00 00 00    	je     1003c6 <printer_vprintf+0x13f>
        int length = 0;
  10031d:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  100322:	0f b6 13             	movzbl (%rbx),%edx
  100325:	8d 42 bd             	lea    -0x43(%rdx),%eax
  100328:	3c 37                	cmp    $0x37,%al
  10032a:	0f 87 c4 04 00 00    	ja     1007f4 <printer_vprintf+0x56d>
  100330:	0f b6 c0             	movzbl %al,%eax
  100333:	ff 24 c5 60 0d 10 00 	jmpq   *0x100d60(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  10033a:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  10033e:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  100343:	3c 08                	cmp    $0x8,%al
  100345:	77 2f                	ja     100376 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100347:	0f b6 03             	movzbl (%rbx),%eax
  10034a:	8d 50 d0             	lea    -0x30(%rax),%edx
  10034d:	80 fa 09             	cmp    $0x9,%dl
  100350:	77 5e                	ja     1003b0 <printer_vprintf+0x129>
  100352:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  100358:	48 83 c3 01          	add    $0x1,%rbx
  10035c:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100361:	0f be c0             	movsbl %al,%eax
  100364:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100369:	0f b6 03             	movzbl (%rbx),%eax
  10036c:	8d 50 d0             	lea    -0x30(%rax),%edx
  10036f:	80 fa 09             	cmp    $0x9,%dl
  100372:	76 e4                	jbe    100358 <printer_vprintf+0xd1>
  100374:	eb 97                	jmp    10030d <printer_vprintf+0x86>
        } else if (*format == '*') {
  100376:	41 80 fc 2a          	cmp    $0x2a,%r12b
  10037a:	75 3f                	jne    1003bb <printer_vprintf+0x134>
            width = va_arg(val, int);
  10037c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100380:	8b 07                	mov    (%rdi),%eax
  100382:	83 f8 2f             	cmp    $0x2f,%eax
  100385:	77 17                	ja     10039e <printer_vprintf+0x117>
  100387:	89 c2                	mov    %eax,%edx
  100389:	48 03 57 10          	add    0x10(%rdi),%rdx
  10038d:	83 c0 08             	add    $0x8,%eax
  100390:	89 07                	mov    %eax,(%rdi)
  100392:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100395:	48 83 c3 01          	add    $0x1,%rbx
  100399:	e9 6f ff ff ff       	jmpq   10030d <printer_vprintf+0x86>
            width = va_arg(val, int);
  10039e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1003a2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1003a6:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1003aa:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1003ae:	eb e2                	jmp    100392 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003b0:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1003b6:	e9 52 ff ff ff       	jmpq   10030d <printer_vprintf+0x86>
        int width = -1;
  1003bb:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1003c1:	e9 47 ff ff ff       	jmpq   10030d <printer_vprintf+0x86>
            ++format;
  1003c6:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1003ca:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1003ce:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1003d1:	80 f9 09             	cmp    $0x9,%cl
  1003d4:	76 13                	jbe    1003e9 <printer_vprintf+0x162>
            } else if (*format == '*') {
  1003d6:	3c 2a                	cmp    $0x2a,%al
  1003d8:	74 33                	je     10040d <printer_vprintf+0x186>
            ++format;
  1003da:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1003dd:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1003e4:	e9 34 ff ff ff       	jmpq   10031d <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1003e9:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1003ee:	48 83 c2 01          	add    $0x1,%rdx
  1003f2:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1003f5:	0f be c0             	movsbl %al,%eax
  1003f8:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1003fc:	0f b6 02             	movzbl (%rdx),%eax
  1003ff:	8d 70 d0             	lea    -0x30(%rax),%esi
  100402:	40 80 fe 09          	cmp    $0x9,%sil
  100406:	76 e6                	jbe    1003ee <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  100408:	48 89 d3             	mov    %rdx,%rbx
  10040b:	eb 1c                	jmp    100429 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  10040d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100411:	8b 07                	mov    (%rdi),%eax
  100413:	83 f8 2f             	cmp    $0x2f,%eax
  100416:	77 23                	ja     10043b <printer_vprintf+0x1b4>
  100418:	89 c2                	mov    %eax,%edx
  10041a:	48 03 57 10          	add    0x10(%rdi),%rdx
  10041e:	83 c0 08             	add    $0x8,%eax
  100421:	89 07                	mov    %eax,(%rdi)
  100423:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  100425:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  100429:	85 c9                	test   %ecx,%ecx
  10042b:	b8 00 00 00 00       	mov    $0x0,%eax
  100430:	0f 49 c1             	cmovns %ecx,%eax
  100433:	89 45 9c             	mov    %eax,-0x64(%rbp)
  100436:	e9 e2 fe ff ff       	jmpq   10031d <printer_vprintf+0x96>
                precision = va_arg(val, int);
  10043b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10043f:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100443:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100447:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10044b:	eb d6                	jmp    100423 <printer_vprintf+0x19c>
        switch (*format) {
  10044d:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100452:	e9 f3 00 00 00       	jmpq   10054a <printer_vprintf+0x2c3>
            ++format;
  100457:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  10045b:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100460:	e9 bd fe ff ff       	jmpq   100322 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100465:	85 c9                	test   %ecx,%ecx
  100467:	74 55                	je     1004be <printer_vprintf+0x237>
  100469:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10046d:	8b 07                	mov    (%rdi),%eax
  10046f:	83 f8 2f             	cmp    $0x2f,%eax
  100472:	77 38                	ja     1004ac <printer_vprintf+0x225>
  100474:	89 c2                	mov    %eax,%edx
  100476:	48 03 57 10          	add    0x10(%rdi),%rdx
  10047a:	83 c0 08             	add    $0x8,%eax
  10047d:	89 07                	mov    %eax,(%rdi)
  10047f:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100482:	48 89 d0             	mov    %rdx,%rax
  100485:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  100489:	49 89 d0             	mov    %rdx,%r8
  10048c:	49 f7 d8             	neg    %r8
  10048f:	25 80 00 00 00       	and    $0x80,%eax
  100494:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100498:	0b 45 a8             	or     -0x58(%rbp),%eax
  10049b:	83 c8 60             	or     $0x60,%eax
  10049e:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1004a1:	41 bc 58 0d 10 00    	mov    $0x100d58,%r12d
            break;
  1004a7:	e9 35 01 00 00       	jmpq   1005e1 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1004ac:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004b0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004b4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004b8:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1004bc:	eb c1                	jmp    10047f <printer_vprintf+0x1f8>
  1004be:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004c2:	8b 07                	mov    (%rdi),%eax
  1004c4:	83 f8 2f             	cmp    $0x2f,%eax
  1004c7:	77 10                	ja     1004d9 <printer_vprintf+0x252>
  1004c9:	89 c2                	mov    %eax,%edx
  1004cb:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004cf:	83 c0 08             	add    $0x8,%eax
  1004d2:	89 07                	mov    %eax,(%rdi)
  1004d4:	48 63 12             	movslq (%rdx),%rdx
  1004d7:	eb a9                	jmp    100482 <printer_vprintf+0x1fb>
  1004d9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004dd:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1004e1:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004e5:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1004e9:	eb e9                	jmp    1004d4 <printer_vprintf+0x24d>
        int base = 10;
  1004eb:	be 0a 00 00 00       	mov    $0xa,%esi
  1004f0:	eb 58                	jmp    10054a <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1004f2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004f6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004fa:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004fe:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100502:	eb 60                	jmp    100564 <printer_vprintf+0x2dd>
  100504:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100508:	8b 07                	mov    (%rdi),%eax
  10050a:	83 f8 2f             	cmp    $0x2f,%eax
  10050d:	77 10                	ja     10051f <printer_vprintf+0x298>
  10050f:	89 c2                	mov    %eax,%edx
  100511:	48 03 57 10          	add    0x10(%rdi),%rdx
  100515:	83 c0 08             	add    $0x8,%eax
  100518:	89 07                	mov    %eax,(%rdi)
  10051a:	44 8b 02             	mov    (%rdx),%r8d
  10051d:	eb 48                	jmp    100567 <printer_vprintf+0x2e0>
  10051f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100523:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100527:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10052b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10052f:	eb e9                	jmp    10051a <printer_vprintf+0x293>
  100531:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100534:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10053b:	bf 40 0f 10 00       	mov    $0x100f40,%edi
  100540:	e9 e2 02 00 00       	jmpq   100827 <printer_vprintf+0x5a0>
            base = 16;
  100545:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10054a:	85 c9                	test   %ecx,%ecx
  10054c:	74 b6                	je     100504 <printer_vprintf+0x27d>
  10054e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100552:	8b 01                	mov    (%rcx),%eax
  100554:	83 f8 2f             	cmp    $0x2f,%eax
  100557:	77 99                	ja     1004f2 <printer_vprintf+0x26b>
  100559:	89 c2                	mov    %eax,%edx
  10055b:	48 03 51 10          	add    0x10(%rcx),%rdx
  10055f:	83 c0 08             	add    $0x8,%eax
  100562:	89 01                	mov    %eax,(%rcx)
  100564:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  100567:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10056b:	85 f6                	test   %esi,%esi
  10056d:	79 c2                	jns    100531 <printer_vprintf+0x2aa>
        base = -base;
  10056f:	41 89 f1             	mov    %esi,%r9d
  100572:	f7 de                	neg    %esi
  100574:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  10057b:	bf 20 0f 10 00       	mov    $0x100f20,%edi
  100580:	e9 a2 02 00 00       	jmpq   100827 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  100585:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100589:	8b 07                	mov    (%rdi),%eax
  10058b:	83 f8 2f             	cmp    $0x2f,%eax
  10058e:	77 1c                	ja     1005ac <printer_vprintf+0x325>
  100590:	89 c2                	mov    %eax,%edx
  100592:	48 03 57 10          	add    0x10(%rdi),%rdx
  100596:	83 c0 08             	add    $0x8,%eax
  100599:	89 07                	mov    %eax,(%rdi)
  10059b:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  10059e:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1005a5:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1005aa:	eb c3                	jmp    10056f <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  1005ac:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005b0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005b4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005b8:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005bc:	eb dd                	jmp    10059b <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1005be:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005c2:	8b 01                	mov    (%rcx),%eax
  1005c4:	83 f8 2f             	cmp    $0x2f,%eax
  1005c7:	0f 87 a5 01 00 00    	ja     100772 <printer_vprintf+0x4eb>
  1005cd:	89 c2                	mov    %eax,%edx
  1005cf:	48 03 51 10          	add    0x10(%rcx),%rdx
  1005d3:	83 c0 08             	add    $0x8,%eax
  1005d6:	89 01                	mov    %eax,(%rcx)
  1005d8:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1005db:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1005e1:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1005e4:	83 e0 20             	and    $0x20,%eax
  1005e7:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1005ea:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1005f0:	0f 85 21 02 00 00    	jne    100817 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1005f6:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1005f9:	89 45 88             	mov    %eax,-0x78(%rbp)
  1005fc:	83 e0 60             	and    $0x60,%eax
  1005ff:	83 f8 60             	cmp    $0x60,%eax
  100602:	0f 84 54 02 00 00    	je     10085c <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100608:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10060b:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  10060e:	48 c7 45 a0 58 0d 10 	movq   $0x100d58,-0x60(%rbp)
  100615:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100616:	83 f8 21             	cmp    $0x21,%eax
  100619:	0f 84 79 02 00 00    	je     100898 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10061f:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100622:	89 f8                	mov    %edi,%eax
  100624:	f7 d0                	not    %eax
  100626:	c1 e8 1f             	shr    $0x1f,%eax
  100629:	89 45 84             	mov    %eax,-0x7c(%rbp)
  10062c:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100630:	0f 85 9e 02 00 00    	jne    1008d4 <printer_vprintf+0x64d>
  100636:	84 c0                	test   %al,%al
  100638:	0f 84 96 02 00 00    	je     1008d4 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  10063e:	48 63 f7             	movslq %edi,%rsi
  100641:	4c 89 e7             	mov    %r12,%rdi
  100644:	e8 63 fb ff ff       	callq  1001ac <strnlen>
  100649:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  10064c:	8b 45 88             	mov    -0x78(%rbp),%eax
  10064f:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100652:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100659:	83 f8 22             	cmp    $0x22,%eax
  10065c:	0f 84 aa 02 00 00    	je     10090c <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100662:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100666:	e8 26 fb ff ff       	callq  100191 <strlen>
  10066b:	8b 55 9c             	mov    -0x64(%rbp),%edx
  10066e:	03 55 98             	add    -0x68(%rbp),%edx
  100671:	44 89 e9             	mov    %r13d,%ecx
  100674:	29 d1                	sub    %edx,%ecx
  100676:	29 c1                	sub    %eax,%ecx
  100678:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  10067b:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10067e:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100682:	75 2d                	jne    1006b1 <printer_vprintf+0x42a>
  100684:	85 c9                	test   %ecx,%ecx
  100686:	7e 29                	jle    1006b1 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  100688:	44 89 fa             	mov    %r15d,%edx
  10068b:	be 20 00 00 00       	mov    $0x20,%esi
  100690:	4c 89 f7             	mov    %r14,%rdi
  100693:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100696:	41 83 ed 01          	sub    $0x1,%r13d
  10069a:	45 85 ed             	test   %r13d,%r13d
  10069d:	7f e9                	jg     100688 <printer_vprintf+0x401>
  10069f:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1006a2:	85 ff                	test   %edi,%edi
  1006a4:	b8 01 00 00 00       	mov    $0x1,%eax
  1006a9:	0f 4f c7             	cmovg  %edi,%eax
  1006ac:	29 c7                	sub    %eax,%edi
  1006ae:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1006b1:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1006b5:	0f b6 07             	movzbl (%rdi),%eax
  1006b8:	84 c0                	test   %al,%al
  1006ba:	74 22                	je     1006de <printer_vprintf+0x457>
  1006bc:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006c0:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1006c3:	0f b6 f0             	movzbl %al,%esi
  1006c6:	44 89 fa             	mov    %r15d,%edx
  1006c9:	4c 89 f7             	mov    %r14,%rdi
  1006cc:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  1006cf:	48 83 c3 01          	add    $0x1,%rbx
  1006d3:	0f b6 03             	movzbl (%rbx),%eax
  1006d6:	84 c0                	test   %al,%al
  1006d8:	75 e9                	jne    1006c3 <printer_vprintf+0x43c>
  1006da:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1006de:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1006e1:	85 c0                	test   %eax,%eax
  1006e3:	7e 1d                	jle    100702 <printer_vprintf+0x47b>
  1006e5:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006e9:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1006eb:	44 89 fa             	mov    %r15d,%edx
  1006ee:	be 30 00 00 00       	mov    $0x30,%esi
  1006f3:	4c 89 f7             	mov    %r14,%rdi
  1006f6:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  1006f9:	83 eb 01             	sub    $0x1,%ebx
  1006fc:	75 ed                	jne    1006eb <printer_vprintf+0x464>
  1006fe:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  100702:	8b 45 98             	mov    -0x68(%rbp),%eax
  100705:	85 c0                	test   %eax,%eax
  100707:	7e 27                	jle    100730 <printer_vprintf+0x4a9>
  100709:	89 c0                	mov    %eax,%eax
  10070b:	4c 01 e0             	add    %r12,%rax
  10070e:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100712:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  100715:	41 0f b6 34 24       	movzbl (%r12),%esi
  10071a:	44 89 fa             	mov    %r15d,%edx
  10071d:	4c 89 f7             	mov    %r14,%rdi
  100720:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  100723:	49 83 c4 01          	add    $0x1,%r12
  100727:	49 39 dc             	cmp    %rbx,%r12
  10072a:	75 e9                	jne    100715 <printer_vprintf+0x48e>
  10072c:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100730:	45 85 ed             	test   %r13d,%r13d
  100733:	7e 14                	jle    100749 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  100735:	44 89 fa             	mov    %r15d,%edx
  100738:	be 20 00 00 00       	mov    $0x20,%esi
  10073d:	4c 89 f7             	mov    %r14,%rdi
  100740:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  100743:	41 83 ed 01          	sub    $0x1,%r13d
  100747:	75 ec                	jne    100735 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  100749:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  10074d:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100751:	84 c0                	test   %al,%al
  100753:	0f 84 fe 01 00 00    	je     100957 <printer_vprintf+0x6d0>
        if (*format != '%') {
  100759:	3c 25                	cmp    $0x25,%al
  10075b:	0f 84 54 fb ff ff    	je     1002b5 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100761:	0f b6 f0             	movzbl %al,%esi
  100764:	44 89 fa             	mov    %r15d,%edx
  100767:	4c 89 f7             	mov    %r14,%rdi
  10076a:	41 ff 16             	callq  *(%r14)
            continue;
  10076d:	4c 89 e3             	mov    %r12,%rbx
  100770:	eb d7                	jmp    100749 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100772:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100776:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10077a:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10077e:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100782:	e9 51 fe ff ff       	jmpq   1005d8 <printer_vprintf+0x351>
            color = va_arg(val, int);
  100787:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10078b:	8b 07                	mov    (%rdi),%eax
  10078d:	83 f8 2f             	cmp    $0x2f,%eax
  100790:	77 10                	ja     1007a2 <printer_vprintf+0x51b>
  100792:	89 c2                	mov    %eax,%edx
  100794:	48 03 57 10          	add    0x10(%rdi),%rdx
  100798:	83 c0 08             	add    $0x8,%eax
  10079b:	89 07                	mov    %eax,(%rdi)
  10079d:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1007a0:	eb a7                	jmp    100749 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  1007a2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007a6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1007aa:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ae:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1007b2:	eb e9                	jmp    10079d <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  1007b4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007b8:	8b 01                	mov    (%rcx),%eax
  1007ba:	83 f8 2f             	cmp    $0x2f,%eax
  1007bd:	77 23                	ja     1007e2 <printer_vprintf+0x55b>
  1007bf:	89 c2                	mov    %eax,%edx
  1007c1:	48 03 51 10          	add    0x10(%rcx),%rdx
  1007c5:	83 c0 08             	add    $0x8,%eax
  1007c8:	89 01                	mov    %eax,(%rcx)
  1007ca:	8b 02                	mov    (%rdx),%eax
  1007cc:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1007cf:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1007d3:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1007d7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1007dd:	e9 ff fd ff ff       	jmpq   1005e1 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1007e2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1007e6:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1007ea:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ee:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1007f2:	eb d6                	jmp    1007ca <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1007f4:	84 d2                	test   %dl,%dl
  1007f6:	0f 85 39 01 00 00    	jne    100935 <printer_vprintf+0x6ae>
  1007fc:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  100800:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  100804:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  100808:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10080c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100812:	e9 ca fd ff ff       	jmpq   1005e1 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  100817:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  10081d:	bf 40 0f 10 00       	mov    $0x100f40,%edi
        if (flags & FLAG_NUMERIC) {
  100822:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  100827:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  10082b:	4c 89 c1             	mov    %r8,%rcx
  10082e:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  100832:	48 63 f6             	movslq %esi,%rsi
  100835:	49 83 ec 01          	sub    $0x1,%r12
  100839:	48 89 c8             	mov    %rcx,%rax
  10083c:	ba 00 00 00 00       	mov    $0x0,%edx
  100841:	48 f7 f6             	div    %rsi
  100844:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  100848:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  10084c:	48 89 ca             	mov    %rcx,%rdx
  10084f:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100852:	48 39 d6             	cmp    %rdx,%rsi
  100855:	76 de                	jbe    100835 <printer_vprintf+0x5ae>
  100857:	e9 9a fd ff ff       	jmpq   1005f6 <printer_vprintf+0x36f>
                prefix = "-";
  10085c:	48 c7 45 a0 55 0d 10 	movq   $0x100d55,-0x60(%rbp)
  100863:	00 
            if (flags & FLAG_NEGATIVE) {
  100864:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100867:	a8 80                	test   $0x80,%al
  100869:	0f 85 b0 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                prefix = "+";
  10086f:	48 c7 45 a0 50 0d 10 	movq   $0x100d50,-0x60(%rbp)
  100876:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100877:	a8 10                	test   $0x10,%al
  100879:	0f 85 a0 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                prefix = " ";
  10087f:	a8 08                	test   $0x8,%al
  100881:	ba 58 0d 10 00       	mov    $0x100d58,%edx
  100886:	b8 57 0d 10 00       	mov    $0x100d57,%eax
  10088b:	48 0f 44 c2          	cmove  %rdx,%rax
  10088f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100893:	e9 87 fd ff ff       	jmpq   10061f <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  100898:	41 8d 41 10          	lea    0x10(%r9),%eax
  10089c:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1008a1:	0f 85 78 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  1008a7:	4d 85 c0             	test   %r8,%r8
  1008aa:	75 0d                	jne    1008b9 <printer_vprintf+0x632>
  1008ac:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1008b3:	0f 84 66 fd ff ff    	je     10061f <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  1008b9:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1008bd:	ba 59 0d 10 00       	mov    $0x100d59,%edx
  1008c2:	b8 52 0d 10 00       	mov    $0x100d52,%eax
  1008c7:	48 0f 44 c2          	cmove  %rdx,%rax
  1008cb:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1008cf:	e9 4b fd ff ff       	jmpq   10061f <printer_vprintf+0x398>
            len = strlen(data);
  1008d4:	4c 89 e7             	mov    %r12,%rdi
  1008d7:	e8 b5 f8 ff ff       	callq  100191 <strlen>
  1008dc:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1008df:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1008e3:	0f 84 63 fd ff ff    	je     10064c <printer_vprintf+0x3c5>
  1008e9:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1008ed:	0f 84 59 fd ff ff    	je     10064c <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1008f3:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1008f6:	89 ca                	mov    %ecx,%edx
  1008f8:	29 c2                	sub    %eax,%edx
  1008fa:	39 c1                	cmp    %eax,%ecx
  1008fc:	b8 00 00 00 00       	mov    $0x0,%eax
  100901:	0f 4e d0             	cmovle %eax,%edx
  100904:	89 55 9c             	mov    %edx,-0x64(%rbp)
  100907:	e9 56 fd ff ff       	jmpq   100662 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  10090c:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100910:	e8 7c f8 ff ff       	callq  100191 <strlen>
  100915:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100918:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  10091b:	44 89 e9             	mov    %r13d,%ecx
  10091e:	29 f9                	sub    %edi,%ecx
  100920:	29 c1                	sub    %eax,%ecx
  100922:	44 39 ea             	cmp    %r13d,%edx
  100925:	b8 00 00 00 00       	mov    $0x0,%eax
  10092a:	0f 4d c8             	cmovge %eax,%ecx
  10092d:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100930:	e9 2d fd ff ff       	jmpq   100662 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100935:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100938:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  10093c:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100940:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100946:	e9 96 fc ff ff       	jmpq   1005e1 <printer_vprintf+0x35a>
        int flags = 0;
  10094b:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100952:	e9 b0 f9 ff ff       	jmpq   100307 <printer_vprintf+0x80>
}
  100957:	48 83 c4 58          	add    $0x58,%rsp
  10095b:	5b                   	pop    %rbx
  10095c:	41 5c                	pop    %r12
  10095e:	41 5d                	pop    %r13
  100960:	41 5e                	pop    %r14
  100962:	41 5f                	pop    %r15
  100964:	5d                   	pop    %rbp
  100965:	c3                   	retq   

0000000000100966 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100966:	55                   	push   %rbp
  100967:	48 89 e5             	mov    %rsp,%rbp
  10096a:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  10096e:	48 c7 45 f0 71 00 10 	movq   $0x100071,-0x10(%rbp)
  100975:	00 
        cpos = 0;
  100976:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  10097c:	b8 00 00 00 00       	mov    $0x0,%eax
  100981:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100984:	48 63 ff             	movslq %edi,%rdi
  100987:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  10098e:	00 
  10098f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100993:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100997:	e8 eb f8 ff ff       	callq  100287 <printer_vprintf>
    return cp.cursor - console;
  10099c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009a0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1009a6:	48 d1 f8             	sar    %rax
}
  1009a9:	c9                   	leaveq 
  1009aa:	c3                   	retq   

00000000001009ab <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1009ab:	55                   	push   %rbp
  1009ac:	48 89 e5             	mov    %rsp,%rbp
  1009af:	48 83 ec 50          	sub    $0x50,%rsp
  1009b3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1009b7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1009bb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1009bf:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1009c6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1009ca:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1009ce:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1009d2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1009d6:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1009da:	e8 87 ff ff ff       	callq  100966 <console_vprintf>
}
  1009df:	c9                   	leaveq 
  1009e0:	c3                   	retq   

00000000001009e1 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1009e1:	55                   	push   %rbp
  1009e2:	48 89 e5             	mov    %rsp,%rbp
  1009e5:	53                   	push   %rbx
  1009e6:	48 83 ec 28          	sub    $0x28,%rsp
  1009ea:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  1009ed:	48 c7 45 d8 f7 00 10 	movq   $0x1000f7,-0x28(%rbp)
  1009f4:	00 
    sp.s = s;
  1009f5:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  1009f9:	48 85 f6             	test   %rsi,%rsi
  1009fc:	75 0b                	jne    100a09 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  1009fe:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100a01:	29 d8                	sub    %ebx,%eax
}
  100a03:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100a07:	c9                   	leaveq 
  100a08:	c3                   	retq   
        sp.end = s + size - 1;
  100a09:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100a0e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100a12:	be 00 00 00 00       	mov    $0x0,%esi
  100a17:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100a1b:	e8 67 f8 ff ff       	callq  100287 <printer_vprintf>
        *sp.s = 0;
  100a20:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a24:	c6 00 00             	movb   $0x0,(%rax)
  100a27:	eb d5                	jmp    1009fe <vsnprintf+0x1d>

0000000000100a29 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100a29:	55                   	push   %rbp
  100a2a:	48 89 e5             	mov    %rsp,%rbp
  100a2d:	48 83 ec 50          	sub    $0x50,%rsp
  100a31:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a35:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a39:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100a3d:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a44:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a48:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a4c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a50:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100a54:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a58:	e8 84 ff ff ff       	callq  1009e1 <vsnprintf>
    va_end(val);
    return n;
}
  100a5d:	c9                   	leaveq 
  100a5e:	c3                   	retq   

0000000000100a5f <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a5f:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100a64:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100a69:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a6e:	48 83 c0 02          	add    $0x2,%rax
  100a72:	48 39 d0             	cmp    %rdx,%rax
  100a75:	75 f2                	jne    100a69 <console_clear+0xa>
    }
    cursorpos = 0;
  100a77:	c7 05 7b 85 fb ff 00 	movl   $0x0,-0x47a85(%rip)        # b8ffc <cursorpos>
  100a7e:	00 00 00 
}
  100a81:	c3                   	retq   

0000000000100a82 <free>:

//head list ptr
linked *head = NULL;

void free(void *firstbyte) {
    if (firstbyte == NULL)
  100a82:	48 85 ff             	test   %rdi,%rdi
  100a85:	74 0c                	je     100a93 <free+0x11>
        return;
    linked *curr = head;
  100a87:	48 8b 05 8a 05 00 00 	mov    0x58a(%rip),%rax        # 101018 <head>
    while (curr){
  100a8e:	48 85 c0             	test   %rax,%rax
  100a91:	75 0a                	jne    100a9d <free+0x1b>
                break;
            }
        curr = curr->next;
    }
    return;
}
  100a93:	c3                   	retq   
        curr = curr->next;
  100a94:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (curr){
  100a98:	48 85 c0             	test   %rax,%rax
  100a9b:	74 f6                	je     100a93 <free+0x11>
        if (curr->addr == firstbyte) 
  100a9d:	48 39 78 10          	cmp    %rdi,0x10(%rax)
  100aa1:	75 f1                	jne    100a94 <free+0x12>
            if(curr->free == 1){
  100aa3:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  100aa7:	75 eb                	jne    100a94 <free+0x12>
                curr->free = 0;
  100aa9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
                break;
  100ab0:	c3                   	retq   

0000000000100ab1 <add_block>:


void add_block(void *b) {
    linked *temp = (linked *)b;
    temp->next = NULL;
  100ab1:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  100ab8:	00 
    temp->prev = NULL;
  100ab9:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  100ac0:	00 
    temp->free = 0;
  100ac1:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%rdi)
    if ((uintptr_t)temp <= (uintptr_t)head || head == NULL ){
  100ac8:	48 8b 05 49 05 00 00 	mov    0x549(%rip),%rax        # 101018 <head>
  100acf:	48 85 c0             	test   %rax,%rax
  100ad2:	74 1f                	je     100af3 <add_block+0x42>
  100ad4:	48 39 f8             	cmp    %rdi,%rax
  100ad7:	73 1a                	jae    100af3 <add_block+0x42>
        temp->next = head;
        head = temp;
    }
    else{
        linked *curr = head;
        while ((uintptr_t)temp >= (uintptr_t) curr->next && curr->next != NULL){
  100ad9:	48 89 c2             	mov    %rax,%rdx
  100adc:	48 8b 40 18          	mov    0x18(%rax),%rax
  100ae0:	48 85 c0             	test   %rax,%rax
  100ae3:	74 05                	je     100aea <add_block+0x39>
  100ae5:	48 39 f8             	cmp    %rdi,%rax
  100ae8:	76 ef                	jbe    100ad9 <add_block+0x28>
            curr = curr->next;
        }
        temp->next = curr->next;
  100aea:	48 89 47 18          	mov    %rax,0x18(%rdi)
        curr->next = temp;
  100aee:	48 89 7a 18          	mov    %rdi,0x18(%rdx)
    }
}
  100af2:	c3                   	retq   
        if (head != NULL)
  100af3:	48 85 c0             	test   %rax,%rax
  100af6:	74 04                	je     100afc <add_block+0x4b>
            head->prev = temp;
  100af8:	48 89 78 20          	mov    %rdi,0x20(%rax)
        temp->next = head;
  100afc:	48 89 47 18          	mov    %rax,0x18(%rdi)
        head = temp;
  100b00:	48 89 3d 11 05 00 00 	mov    %rdi,0x511(%rip)        # 101018 <head>
  100b07:	c3                   	retq   

0000000000100b08 <malloc>:

void *malloc(uint64_t numbytes) { 
  100b08:	55                   	push   %rbp
  100b09:	48 89 e5             	mov    %rsp,%rbp
  100b0c:	41 56                	push   %r14
  100b0e:	41 55                	push   %r13
  100b10:	41 54                	push   %r12
  100b12:	53                   	push   %rbx
    if(numbytes < 1)
  100b13:	48 85 ff             	test   %rdi,%rdi
  100b16:	0f 84 f0 00 00 00    	je     100c0c <malloc+0x104>
        return NULL;    
    uint64_t meta_sz = (((numbytes + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))) + (8 - 1)) & ~(8 - 1));
  100b1c:	48 8d 5f 2f          	lea    0x2f(%rdi),%rbx
  100b20:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx
    linked *sized_block = NULL;
    //assign block and search
    linked *curr = head;
  100b24:	48 8b 05 ed 04 00 00 	mov    0x4ed(%rip),%rax        # 101018 <head>
    while (curr != NULL){
  100b2b:	48 85 c0             	test   %rax,%rax
  100b2e:	74 54                	je     100b84 <malloc+0x7c>
    linked *sized_block = NULL;
  100b30:	ba 00 00 00 00       	mov    $0x0,%edx
  100b35:	eb 09                	jmp    100b40 <malloc+0x38>
        if (curr->free == 0)
            if(curr->sz >= numbytes)
                sized_block = curr;
        curr = curr->next;
  100b37:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (curr != NULL){
  100b3b:	48 85 c0             	test   %rax,%rax
  100b3e:	74 0f                	je     100b4f <malloc+0x47>
        if (curr->free == 0)
  100b40:	83 78 08 00          	cmpl   $0x0,0x8(%rax)
  100b44:	75 f1                	jne    100b37 <malloc+0x2f>
            if(curr->sz >= numbytes)
  100b46:	48 39 38             	cmp    %rdi,(%rax)
  100b49:	48 0f 43 d0          	cmovae %rax,%rdx
  100b4d:	eb e8                	jmp    100b37 <malloc+0x2f>
    }
    if (sized_block == NULL){
  100b4f:	48 85 d2             	test   %rdx,%rdx
  100b52:	74 30                	je     100b84 <malloc+0x7c>
        }
        //split end

        return (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
    }
    if (heap_flag == 0){
  100b54:	83 3d c5 04 00 00 00 	cmpl   $0x0,0x4c5(%rip)        # 101020 <heap_flag>
  100b5b:	75 07                	jne    100b64 <malloc+0x5c>
        sized_block->free = 1;
  100b5d:	c7 42 08 01 00 00 00 	movl   $0x1,0x8(%rdx)
    }
    sized_block->addr = (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
  100b64:	4c 8d 62 28          	lea    0x28(%rdx),%r12
  100b68:	4c 89 62 10          	mov    %r12,0x10(%rdx)
    
    //splitting
    linked *temp = (linked *) sized_block;
    void *new_ptr = (void *) ((uintptr_t) sized_block + meta_sz);
    if ((sized_block->sz - meta_sz) < (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))){
  100b6c:	48 8b 02             	mov    (%rdx),%rax
  100b6f:	48 29 d8             	sub    %rbx,%rax
  100b72:	48 83 f8 27          	cmp    $0x27,%rax
  100b76:	77 79                	ja     100bf1 <malloc+0xe9>
        add_block(new_linked);
    } 
    //splitting end

    return (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
}
  100b78:	4c 89 e0             	mov    %r12,%rax
  100b7b:	5b                   	pop    %rbx
  100b7c:	41 5c                	pop    %r12
  100b7e:	41 5d                	pop    %r13
  100b80:	41 5e                	pop    %r14
  100b82:	5d                   	pop    %rbp
  100b83:	c3                   	retq   
        if (meta_sz > PAGESIZE){
  100b84:	41 bd 00 10 00 00    	mov    $0x1000,%r13d
  100b8a:	4c 39 eb             	cmp    %r13,%rbx
  100b8d:	4c 0f 43 eb          	cmovae %rbx,%r13
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100b91:	4c 89 ef             	mov    %r13,%rdi
  100b94:	cd 3a                	int    $0x3a
  100b96:	49 89 c6             	mov    %rax,%r14
  100b99:	48 89 05 88 04 00 00 	mov    %rax,0x488(%rip)        # 101028 <result.0>
            return NULL;
  100ba0:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        if (temp_block == (void *)-1){
  100ba6:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100baa:	74 cc                	je     100b78 <malloc+0x70>
        add_block(sized_block);
  100bac:	48 89 c7             	mov    %rax,%rdi
  100baf:	e8 fd fe ff ff       	callq  100ab1 <add_block>
        sized_block->sz = ex_sz;
  100bb4:	4d 89 2e             	mov    %r13,(%r14)
        if (heap_flag == 0){
  100bb7:	83 3d 62 04 00 00 00 	cmpl   $0x0,0x462(%rip)        # 101020 <heap_flag>
  100bbe:	75 08                	jne    100bc8 <malloc+0xc0>
            sized_block->free = 1; //for debugging
  100bc0:	41 c7 46 08 01 00 00 	movl   $0x1,0x8(%r14)
  100bc7:	00 
        sized_block->addr = (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
  100bc8:	4d 8d 66 28          	lea    0x28(%r14),%r12
  100bcc:	4d 89 66 10          	mov    %r12,0x10(%r14)
        if ((sized_block->sz - meta_sz) < (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))){
  100bd0:	49 29 dd             	sub    %rbx,%r13
  100bd3:	49 83 fd 27          	cmp    $0x27,%r13
  100bd7:	76 9f                	jbe    100b78 <malloc+0x70>
        void *new_ptr = (void *) ((uintptr_t) sized_block + meta_sz);
  100bd9:	49 8d 3c 1e          	lea    (%r14,%rbx,1),%rdi
            new_linked->sz = sized_block->sz - meta_sz;
  100bdd:	4c 89 2f             	mov    %r13,(%rdi)
            temp->sz = meta_sz;
  100be0:	49 89 1e             	mov    %rbx,(%r14)
            new_linked->free = 0; //flag
  100be3:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%rdi)
            add_block(new_linked);
  100bea:	e8 c2 fe ff ff       	callq  100ab1 <add_block>
  100bef:	eb 87                	jmp    100b78 <malloc+0x70>
    void *new_ptr = (void *) ((uintptr_t) sized_block + meta_sz);
  100bf1:	48 8d 3c 1a          	lea    (%rdx,%rbx,1),%rdi
        new_linked->sz = sized_block->sz - meta_sz;
  100bf5:	48 89 07             	mov    %rax,(%rdi)
        temp->sz = meta_sz;
  100bf8:	48 89 1a             	mov    %rbx,(%rdx)
        new_linked->free = 0;
  100bfb:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%rdi)
        add_block(new_linked);
  100c02:	e8 aa fe ff ff       	callq  100ab1 <add_block>
  100c07:	e9 6c ff ff ff       	jmpq   100b78 <malloc+0x70>
        return NULL;    
  100c0c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100c12:	e9 61 ff ff ff       	jmpq   100b78 <malloc+0x70>

0000000000100c17 <calloc>:


void * calloc(uint64_t num, uint64_t sz) { //done
  100c17:	55                   	push   %rbp
  100c18:	48 89 e5             	mov    %rsp,%rbp
  100c1b:	41 54                	push   %r12
  100c1d:	53                   	push   %rbx
    void* ptr = NULL;
    //edge case
    if(num == 0)
        return NULL;
    if(sz == 0)
  100c1e:	48 85 f6             	test   %rsi,%rsi
  100c21:	74 46                	je     100c69 <calloc+0x52>
  100c23:	48 85 ff             	test   %rdi,%rdi
  100c26:	74 41                	je     100c69 <calloc+0x52>
        return NULL;

    if(sz > 0 && num > (4294967294/sz)){
  100c28:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  100c2d:	ba 00 00 00 00       	mov    $0x0,%edx
  100c32:	48 f7 f6             	div    %rsi
        ptr = NULL;
  100c35:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if(sz > 0 && num > (4294967294/sz)){
  100c3b:	48 39 f8             	cmp    %rdi,%rax
  100c3e:	72 2f                	jb     100c6f <calloc+0x58>
    }
    else
        ptr = malloc(num * sz);
  100c40:	48 89 fb             	mov    %rdi,%rbx
  100c43:	48 0f af de          	imul   %rsi,%rbx
  100c47:	48 89 df             	mov    %rbx,%rdi
  100c4a:	e8 b9 fe ff ff       	callq  100b08 <malloc>
  100c4f:	49 89 c4             	mov    %rax,%r12
    
    if (!ptr){
  100c52:	48 85 c0             	test   %rax,%rax
  100c55:	74 18                	je     100c6f <calloc+0x58>
        //nothing
    }
    else
        memset(ptr, 0, num * sz);
  100c57:	48 89 da             	mov    %rbx,%rdx
  100c5a:	be 00 00 00 00       	mov    $0x0,%esi
  100c5f:	48 89 c7             	mov    %rax,%rdi
  100c62:	e8 0f f5 ff ff       	callq  100176 <memset>
  100c67:	eb 06                	jmp    100c6f <calloc+0x58>
        return NULL;
  100c69:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    return ptr;
}
  100c6f:	4c 89 e0             	mov    %r12,%rax
  100c72:	5b                   	pop    %rbx
  100c73:	41 5c                	pop    %r12
  100c75:	5d                   	pop    %rbp
  100c76:	c3                   	retq   

0000000000100c77 <realloc>:

void * realloc(void * ptr, uint64_t sz) { //done
  100c77:	55                   	push   %rbp
  100c78:	48 89 e5             	mov    %rsp,%rbp
  100c7b:	41 54                	push   %r12
  100c7d:	53                   	push   %rbx
  100c7e:	48 89 fb             	mov    %rdi,%rbx
    //for it to equal free
    if (sz == 0){ //size must be 0
        if(ptr != NULL){ //ptr cannot be null
  100c81:	48 85 ff             	test   %rdi,%rdi
  100c84:	74 05                	je     100c8b <realloc+0x14>
  100c86:	48 85 f6             	test   %rsi,%rsi
  100c89:	74 53                	je     100cde <realloc+0x67>
            free(ptr); 
            return NULL;
        }
    }
    // for it to be malloc of the sz
    if (ptr == NULL){
  100c8b:	48 85 db             	test   %rbx,%rbx
  100c8e:	74 5b                	je     100ceb <realloc+0x74>
        return temp_ptr;
    }
    
    linked *head_ptr = (linked *)(uintptr_t)ptr - (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
    if (sz < head_ptr->sz)
        return ptr;
  100c90:	49 89 dc             	mov    %rbx,%r12
    if (sz < head_ptr->sz)
  100c93:	48 39 b3 c0 f9 ff ff 	cmp    %rsi,-0x640(%rbx)
  100c9a:	77 3a                	ja     100cd6 <realloc+0x5f>
    uint64_t new_sz = (((sz + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))) + (8 - 1)) & ~(8 - 1));
    linked *new_loc;
    //overflows?
    if ((((sizeof(linked)) + (8 - 1)) & ~(8 - 1)) > 0)
        if(sz > (4294967294) - (((sizeof(linked)) + (8 - 1)) & ~(8 - 1)))
            return NULL;
  100c9c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        if(sz > (4294967294) - (((sizeof(linked)) + (8 - 1)) & ~(8 - 1)))
  100ca2:	b8 d6 ff ff ff       	mov    $0xffffffd6,%eax
  100ca7:	48 39 c6             	cmp    %rax,%rsi
  100caa:	77 2a                	ja     100cd6 <realloc+0x5f>
    new_loc = malloc(sz);
  100cac:	48 89 f7             	mov    %rsi,%rdi
  100caf:	e8 54 fe ff ff       	callq  100b08 <malloc>
  100cb4:	49 89 c4             	mov    %rax,%r12
    if (new_loc == NULL)
  100cb7:	48 85 c0             	test   %rax,%rax
  100cba:	74 1a                	je     100cd6 <realloc+0x5f>
        return NULL;
    memcpy(new_loc, ptr, head_ptr->sz);
  100cbc:	48 8b 93 c0 f9 ff ff 	mov    -0x640(%rbx),%rdx
  100cc3:	48 89 de             	mov    %rbx,%rsi
  100cc6:	48 89 c7             	mov    %rax,%rdi
  100cc9:	e8 3f f4 ff ff       	callq  10010d <memcpy>
    free(ptr);
  100cce:	48 89 df             	mov    %rbx,%rdi
  100cd1:	e8 ac fd ff ff       	callq  100a82 <free>
    return new_loc;
}
  100cd6:	4c 89 e0             	mov    %r12,%rax
  100cd9:	5b                   	pop    %rbx
  100cda:	41 5c                	pop    %r12
  100cdc:	5d                   	pop    %rbp
  100cdd:	c3                   	retq   
            free(ptr); 
  100cde:	e8 9f fd ff ff       	callq  100a82 <free>
            return NULL;
  100ce3:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100ce9:	eb eb                	jmp    100cd6 <realloc+0x5f>
        void *temp_ptr = malloc(sz);
  100ceb:	48 89 f7             	mov    %rsi,%rdi
  100cee:	e8 15 fe ff ff       	callq  100b08 <malloc>
  100cf3:	49 89 c4             	mov    %rax,%r12
        return temp_ptr;
  100cf6:	eb de                	jmp    100cd6 <realloc+0x5f>

0000000000100cf8 <defrag>:

void defrag(){ //done
    linked *curr = head;
  100cf8:	48 8b 05 19 03 00 00 	mov    0x319(%rip),%rax        # 101018 <head>
    while(curr != NULL){
  100cff:	48 85 c0             	test   %rax,%rax
  100d02:	75 15                	jne    100d19 <defrag+0x21>
                //end curr ==
            }
        }
        curr = curr->next;
    }
}
  100d04:	c3                   	retq   
                        curr->sz += av_sz;
  100d05:	48 8b 0a             	mov    (%rdx),%rcx
  100d08:	48 01 08             	add    %rcx,(%rax)
        curr = curr->next;
  100d0b:	48 89 d0             	mov    %rdx,%rax
  100d0e:	eb 09                	jmp    100d19 <defrag+0x21>
  100d10:	48 8b 40 18          	mov    0x18(%rax),%rax
    while(curr != NULL){
  100d14:	48 85 c0             	test   %rax,%rax
  100d17:	74 2c                	je     100d45 <defrag+0x4d>
        if (curr->free == 0){
  100d19:	83 78 08 00          	cmpl   $0x0,0x8(%rax)
  100d1d:	75 f1                	jne    100d10 <defrag+0x18>
            if(curr->next){
  100d1f:	48 8b 50 18          	mov    0x18(%rax),%rdx
  100d23:	48 85 d2             	test   %rdx,%rdx
  100d26:	74 dc                	je     100d04 <defrag+0xc>
                if(curr->next->free == 0){
  100d28:	83 7a 08 00          	cmpl   $0x0,0x8(%rdx)
  100d2c:	75 dd                	jne    100d0b <defrag+0x13>
                    if (curr->prev != NULL && curr->prev->free == 0){
  100d2e:	48 8b 48 20          	mov    0x20(%rax),%rcx
  100d32:	48 85 c9             	test   %rcx,%rcx
  100d35:	74 ce                	je     100d05 <defrag+0xd>
  100d37:	83 79 08 00          	cmpl   $0x0,0x8(%rcx)
  100d3b:	75 c8                	jne    100d05 <defrag+0xd>
                        curr->prev->sz += curr->sz; 
  100d3d:	48 8b 10             	mov    (%rax),%rdx
  100d40:	48 01 11             	add    %rdx,(%rcx)
  100d43:	eb cb                	jmp    100d10 <defrag+0x18>
  100d45:	c3                   	retq   

0000000000100d46 <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  100d46:	b8 00 00 00 00       	mov    $0x0,%eax
  100d4b:	c3                   	retq   
