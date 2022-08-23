
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 55                	push   %r13
  100006:	41 54                	push   %r12
  100008:	53                   	push   %rbx
  100009:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000d:	cd 31                	int    $0x31
  10000f:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  100011:	e8 03 03 00 00       	callq  100319 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100016:	b8 3f 30 10 00       	mov    $0x10303f,%eax
  10001b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100021:	48 89 05 e8 1f 00 00 	mov    %rax,0x1fe8(%rip)        # 102010 <heap_top>
  100028:	48 89 05 d9 1f 00 00 	mov    %rax,0x1fd9(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10002f:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100032:	48 83 e8 01          	sub    $0x1,%rax
  100036:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10003c:	48 89 05 bd 1f 00 00 	mov    %rax,0x1fbd(%rip)        # 102000 <stack_bottom>

    void *ptr = malloc(7);
  100043:	bf 07 00 00 00       	mov    $0x7,%edi
  100048:	e8 5e 0b 00 00       	callq  100bab <malloc>
    assert(ptr != NULL);
  10004d:	48 85 c0             	test   %rax,%rax
  100050:	0f 84 82 00 00 00    	je     1000d8 <process_main+0xd8>
  100056:	48 89 c2             	mov    %rax,%rdx
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100059:	bf 00 00 00 00       	mov    $0x0,%edi
  10005e:	cd 3a                	int    $0x3a
  100060:	48 89 05 b1 1f 00 00 	mov    %rax,0x1fb1(%rip)        # 102018 <result.0>
    heap_top = sbrk(0);
  100067:	48 89 05 a2 1f 00 00 	mov    %rax,0x1fa2(%rip)        # 102010 <heap_top>
    free(ptr);
  10006e:	48 89 d7             	mov    %rdx,%rdi
  100071:	e8 af 0a 00 00       	callq  100b25 <free>
  100076:	41 bc 9f 86 01 00    	mov    $0x1869f,%r12d
  10007c:	41 bd 00 00 00 00    	mov    $0x0,%r13d

    /* free block reuse */
    for(int i = 1; i < 100000; ++i) {
        ptr = malloc(7);
  100082:	bf 07 00 00 00       	mov    $0x7,%edi
  100087:	e8 1f 0b 00 00       	callq  100bab <malloc>
  10008c:	48 89 c3             	mov    %rax,%rbx
        assert(ptr != NULL);
  10008f:	48 85 c0             	test   %rax,%rax
  100092:	74 58                	je     1000ec <process_main+0xec>
  100094:	4c 89 ef             	mov    %r13,%rdi
  100097:	cd 3a                	int    $0x3a
  100099:	48 89 05 78 1f 00 00 	mov    %rax,0x1f78(%rip)        # 102018 <result.0>

        /* Check that we reuse a free block */
        assert(sbrk(0) == heap_top);
  1000a0:	48 39 05 69 1f 00 00 	cmp    %rax,0x1f69(%rip)        # 102010 <heap_top>
  1000a7:	75 57                	jne    100100 <process_main+0x100>

        /* Check that we can write */
        memset(ptr, 'A', 7);
  1000a9:	ba 07 00 00 00       	mov    $0x7,%edx
  1000ae:	be 41 00 00 00       	mov    $0x41,%esi
  1000b3:	48 89 df             	mov    %rbx,%rdi
  1000b6:	e8 5e 01 00 00       	callq  100219 <memset>
        free(ptr);
  1000bb:	48 89 df             	mov    %rbx,%rdi
  1000be:	e8 62 0a 00 00       	callq  100b25 <free>
    for(int i = 1; i < 100000; ++i) {
  1000c3:	41 83 ec 01          	sub    $0x1,%r12d
  1000c7:	75 b9                	jne    100082 <process_main+0x82>
    }

    TEST_PASS();
  1000c9:	bf a9 0f 10 00       	mov    $0x100fa9,%edi
  1000ce:	b8 00 00 00 00       	mov    $0x0,%eax
  1000d3:	e8 a7 0d 00 00       	callq  100e7f <kernel_panic>
    assert(ptr != NULL);
  1000d8:	ba 80 0f 10 00       	mov    $0x100f80,%edx
  1000dd:	be 17 00 00 00       	mov    $0x17,%esi
  1000e2:	bf 8c 0f 10 00       	mov    $0x100f8c,%edi
  1000e7:	e8 61 0e 00 00       	callq  100f4d <assert_fail>
        assert(ptr != NULL);
  1000ec:	ba 80 0f 10 00       	mov    $0x100f80,%edx
  1000f1:	be 1e 00 00 00       	mov    $0x1e,%esi
  1000f6:	bf 8c 0f 10 00       	mov    $0x100f8c,%edi
  1000fb:	e8 4d 0e 00 00       	callq  100f4d <assert_fail>
        assert(sbrk(0) == heap_top);
  100100:	ba 95 0f 10 00       	mov    $0x100f95,%edx
  100105:	be 21 00 00 00       	mov    $0x21,%esi
  10010a:	bf 8c 0f 10 00       	mov    $0x100f8c,%edi
  10010f:	e8 39 0e 00 00       	callq  100f4d <assert_fail>

0000000000100114 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100114:	48 89 f9             	mov    %rdi,%rcx
  100117:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100119:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  100120:	00 
  100121:	72 08                	jb     10012b <console_putc+0x17>
        cp->cursor = console;
  100123:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  10012a:	00 
    }
    if (c == '\n') {
  10012b:	40 80 fe 0a          	cmp    $0xa,%sil
  10012f:	74 16                	je     100147 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  100131:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100135:	48 8d 50 02          	lea    0x2(%rax),%rdx
  100139:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10013d:	40 0f b6 f6          	movzbl %sil,%esi
  100141:	09 fe                	or     %edi,%esi
  100143:	66 89 30             	mov    %si,(%rax)
    }
}
  100146:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  100147:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  10014b:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  100152:	4c 89 c6             	mov    %r8,%rsi
  100155:	48 d1 fe             	sar    %rsi
  100158:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10015f:	66 66 66 
  100162:	48 89 f0             	mov    %rsi,%rax
  100165:	48 f7 ea             	imul   %rdx
  100168:	48 c1 fa 05          	sar    $0x5,%rdx
  10016c:	49 c1 f8 3f          	sar    $0x3f,%r8
  100170:	4c 29 c2             	sub    %r8,%rdx
  100173:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  100177:	48 c1 e2 04          	shl    $0x4,%rdx
  10017b:	89 f0                	mov    %esi,%eax
  10017d:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  10017f:	83 cf 20             	or     $0x20,%edi
  100182:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100186:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  10018a:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  10018e:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  100191:	83 c0 01             	add    $0x1,%eax
  100194:	83 f8 50             	cmp    $0x50,%eax
  100197:	75 e9                	jne    100182 <console_putc+0x6e>
  100199:	c3                   	retq   

000000000010019a <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  10019a:	48 8b 47 08          	mov    0x8(%rdi),%rax
  10019e:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1001a2:	73 0b                	jae    1001af <string_putc+0x15>
        *sp->s++ = c;
  1001a4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1001a8:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1001ac:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  1001af:	c3                   	retq   

00000000001001b0 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  1001b0:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001b3:	48 85 d2             	test   %rdx,%rdx
  1001b6:	74 17                	je     1001cf <memcpy+0x1f>
  1001b8:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  1001bd:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  1001c2:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001c6:	48 83 c1 01          	add    $0x1,%rcx
  1001ca:	48 39 d1             	cmp    %rdx,%rcx
  1001cd:	75 ee                	jne    1001bd <memcpy+0xd>
}
  1001cf:	c3                   	retq   

00000000001001d0 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1001d0:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  1001d3:	48 39 fe             	cmp    %rdi,%rsi
  1001d6:	72 1d                	jb     1001f5 <memmove+0x25>
        while (n-- > 0) {
  1001d8:	b9 00 00 00 00       	mov    $0x0,%ecx
  1001dd:	48 85 d2             	test   %rdx,%rdx
  1001e0:	74 12                	je     1001f4 <memmove+0x24>
            *d++ = *s++;
  1001e2:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  1001e6:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  1001ea:	48 83 c1 01          	add    $0x1,%rcx
  1001ee:	48 39 ca             	cmp    %rcx,%rdx
  1001f1:	75 ef                	jne    1001e2 <memmove+0x12>
}
  1001f3:	c3                   	retq   
  1001f4:	c3                   	retq   
    if (s < d && s + n > d) {
  1001f5:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  1001f9:	48 39 cf             	cmp    %rcx,%rdi
  1001fc:	73 da                	jae    1001d8 <memmove+0x8>
        while (n-- > 0) {
  1001fe:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  100202:	48 85 d2             	test   %rdx,%rdx
  100205:	74 ec                	je     1001f3 <memmove+0x23>
            *--d = *--s;
  100207:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  10020b:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10020e:	48 83 e9 01          	sub    $0x1,%rcx
  100212:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100216:	75 ef                	jne    100207 <memmove+0x37>
  100218:	c3                   	retq   

0000000000100219 <memset>:
void* memset(void* v, int c, size_t n) {
  100219:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10021c:	48 85 d2             	test   %rdx,%rdx
  10021f:	74 12                	je     100233 <memset+0x1a>
  100221:	48 01 fa             	add    %rdi,%rdx
  100224:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100227:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10022a:	48 83 c1 01          	add    $0x1,%rcx
  10022e:	48 39 ca             	cmp    %rcx,%rdx
  100231:	75 f4                	jne    100227 <memset+0xe>
}
  100233:	c3                   	retq   

0000000000100234 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100234:	80 3f 00             	cmpb   $0x0,(%rdi)
  100237:	74 10                	je     100249 <strlen+0x15>
  100239:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  10023e:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  100242:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  100246:	75 f6                	jne    10023e <strlen+0xa>
  100248:	c3                   	retq   
  100249:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10024e:	c3                   	retq   

000000000010024f <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  10024f:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100252:	ba 00 00 00 00       	mov    $0x0,%edx
  100257:	48 85 f6             	test   %rsi,%rsi
  10025a:	74 11                	je     10026d <strnlen+0x1e>
  10025c:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  100260:	74 0c                	je     10026e <strnlen+0x1f>
        ++n;
  100262:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100266:	48 39 d0             	cmp    %rdx,%rax
  100269:	75 f1                	jne    10025c <strnlen+0xd>
  10026b:	eb 04                	jmp    100271 <strnlen+0x22>
  10026d:	c3                   	retq   
  10026e:	48 89 d0             	mov    %rdx,%rax
}
  100271:	c3                   	retq   

0000000000100272 <strcpy>:
char* strcpy(char* dst, const char* src) {
  100272:	48 89 f8             	mov    %rdi,%rax
  100275:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  10027a:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  10027e:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  100281:	48 83 c2 01          	add    $0x1,%rdx
  100285:	84 c9                	test   %cl,%cl
  100287:	75 f1                	jne    10027a <strcpy+0x8>
}
  100289:	c3                   	retq   

000000000010028a <strcmp>:
    while (*a && *b && *a == *b) {
  10028a:	0f b6 07             	movzbl (%rdi),%eax
  10028d:	84 c0                	test   %al,%al
  10028f:	74 1a                	je     1002ab <strcmp+0x21>
  100291:	0f b6 16             	movzbl (%rsi),%edx
  100294:	38 c2                	cmp    %al,%dl
  100296:	75 13                	jne    1002ab <strcmp+0x21>
  100298:	84 d2                	test   %dl,%dl
  10029a:	74 0f                	je     1002ab <strcmp+0x21>
        ++a, ++b;
  10029c:	48 83 c7 01          	add    $0x1,%rdi
  1002a0:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  1002a4:	0f b6 07             	movzbl (%rdi),%eax
  1002a7:	84 c0                	test   %al,%al
  1002a9:	75 e6                	jne    100291 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  1002ab:	3a 06                	cmp    (%rsi),%al
  1002ad:	0f 97 c0             	seta   %al
  1002b0:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  1002b3:	83 d8 00             	sbb    $0x0,%eax
}
  1002b6:	c3                   	retq   

00000000001002b7 <strchr>:
    while (*s && *s != (char) c) {
  1002b7:	0f b6 07             	movzbl (%rdi),%eax
  1002ba:	84 c0                	test   %al,%al
  1002bc:	74 10                	je     1002ce <strchr+0x17>
  1002be:	40 38 f0             	cmp    %sil,%al
  1002c1:	74 18                	je     1002db <strchr+0x24>
        ++s;
  1002c3:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  1002c7:	0f b6 07             	movzbl (%rdi),%eax
  1002ca:	84 c0                	test   %al,%al
  1002cc:	75 f0                	jne    1002be <strchr+0x7>
        return NULL;
  1002ce:	40 84 f6             	test   %sil,%sil
  1002d1:	b8 00 00 00 00       	mov    $0x0,%eax
  1002d6:	48 0f 44 c7          	cmove  %rdi,%rax
}
  1002da:	c3                   	retq   
  1002db:	48 89 f8             	mov    %rdi,%rax
  1002de:	c3                   	retq   

00000000001002df <rand>:
    if (!rand_seed_set) {
  1002df:	83 3d 3e 1d 00 00 00 	cmpl   $0x0,0x1d3e(%rip)        # 102024 <rand_seed_set>
  1002e6:	74 1b                	je     100303 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1002e8:	69 05 2e 1d 00 00 0d 	imul   $0x19660d,0x1d2e(%rip),%eax        # 102020 <rand_seed>
  1002ef:	66 19 00 
  1002f2:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1002f7:	89 05 23 1d 00 00    	mov    %eax,0x1d23(%rip)        # 102020 <rand_seed>
    return rand_seed & RAND_MAX;
  1002fd:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100302:	c3                   	retq   
    rand_seed = seed;
  100303:	c7 05 13 1d 00 00 9e 	movl   $0x30d4879e,0x1d13(%rip)        # 102020 <rand_seed>
  10030a:	87 d4 30 
    rand_seed_set = 1;
  10030d:	c7 05 0d 1d 00 00 01 	movl   $0x1,0x1d0d(%rip)        # 102024 <rand_seed_set>
  100314:	00 00 00 
}
  100317:	eb cf                	jmp    1002e8 <rand+0x9>

0000000000100319 <srand>:
    rand_seed = seed;
  100319:	89 3d 01 1d 00 00    	mov    %edi,0x1d01(%rip)        # 102020 <rand_seed>
    rand_seed_set = 1;
  10031f:	c7 05 fb 1c 00 00 01 	movl   $0x1,0x1cfb(%rip)        # 102024 <rand_seed_set>
  100326:	00 00 00 
}
  100329:	c3                   	retq   

000000000010032a <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10032a:	55                   	push   %rbp
  10032b:	48 89 e5             	mov    %rsp,%rbp
  10032e:	41 57                	push   %r15
  100330:	41 56                	push   %r14
  100332:	41 55                	push   %r13
  100334:	41 54                	push   %r12
  100336:	53                   	push   %rbx
  100337:	48 83 ec 58          	sub    $0x58,%rsp
  10033b:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  10033f:	0f b6 02             	movzbl (%rdx),%eax
  100342:	84 c0                	test   %al,%al
  100344:	0f 84 b0 06 00 00    	je     1009fa <printer_vprintf+0x6d0>
  10034a:	49 89 fe             	mov    %rdi,%r14
  10034d:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  100350:	41 89 f7             	mov    %esi,%r15d
  100353:	e9 a4 04 00 00       	jmpq   1007fc <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  100358:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  10035d:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  100363:	45 84 e4             	test   %r12b,%r12b
  100366:	0f 84 82 06 00 00    	je     1009ee <printer_vprintf+0x6c4>
        int flags = 0;
  10036c:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  100372:	41 0f be f4          	movsbl %r12b,%esi
  100376:	bf c1 11 10 00       	mov    $0x1011c1,%edi
  10037b:	e8 37 ff ff ff       	callq  1002b7 <strchr>
  100380:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  100383:	48 85 c0             	test   %rax,%rax
  100386:	74 55                	je     1003dd <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  100388:	48 81 e9 c1 11 10 00 	sub    $0x1011c1,%rcx
  10038f:	b8 01 00 00 00       	mov    $0x1,%eax
  100394:	d3 e0                	shl    %cl,%eax
  100396:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  100399:	48 83 c3 01          	add    $0x1,%rbx
  10039d:	44 0f b6 23          	movzbl (%rbx),%r12d
  1003a1:	45 84 e4             	test   %r12b,%r12b
  1003a4:	75 cc                	jne    100372 <printer_vprintf+0x48>
  1003a6:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  1003aa:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  1003b0:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  1003b7:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  1003ba:	0f 84 a9 00 00 00    	je     100469 <printer_vprintf+0x13f>
        int length = 0;
  1003c0:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1003c5:	0f b6 13             	movzbl (%rbx),%edx
  1003c8:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1003cb:	3c 37                	cmp    $0x37,%al
  1003cd:	0f 87 c4 04 00 00    	ja     100897 <printer_vprintf+0x56d>
  1003d3:	0f b6 c0             	movzbl %al,%eax
  1003d6:	ff 24 c5 d0 0f 10 00 	jmpq   *0x100fd0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  1003dd:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  1003e1:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  1003e6:	3c 08                	cmp    $0x8,%al
  1003e8:	77 2f                	ja     100419 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003ea:	0f b6 03             	movzbl (%rbx),%eax
  1003ed:	8d 50 d0             	lea    -0x30(%rax),%edx
  1003f0:	80 fa 09             	cmp    $0x9,%dl
  1003f3:	77 5e                	ja     100453 <printer_vprintf+0x129>
  1003f5:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  1003fb:	48 83 c3 01          	add    $0x1,%rbx
  1003ff:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100404:	0f be c0             	movsbl %al,%eax
  100407:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10040c:	0f b6 03             	movzbl (%rbx),%eax
  10040f:	8d 50 d0             	lea    -0x30(%rax),%edx
  100412:	80 fa 09             	cmp    $0x9,%dl
  100415:	76 e4                	jbe    1003fb <printer_vprintf+0xd1>
  100417:	eb 97                	jmp    1003b0 <printer_vprintf+0x86>
        } else if (*format == '*') {
  100419:	41 80 fc 2a          	cmp    $0x2a,%r12b
  10041d:	75 3f                	jne    10045e <printer_vprintf+0x134>
            width = va_arg(val, int);
  10041f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100423:	8b 07                	mov    (%rdi),%eax
  100425:	83 f8 2f             	cmp    $0x2f,%eax
  100428:	77 17                	ja     100441 <printer_vprintf+0x117>
  10042a:	89 c2                	mov    %eax,%edx
  10042c:	48 03 57 10          	add    0x10(%rdi),%rdx
  100430:	83 c0 08             	add    $0x8,%eax
  100433:	89 07                	mov    %eax,(%rdi)
  100435:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100438:	48 83 c3 01          	add    $0x1,%rbx
  10043c:	e9 6f ff ff ff       	jmpq   1003b0 <printer_vprintf+0x86>
            width = va_arg(val, int);
  100441:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100445:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100449:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10044d:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100451:	eb e2                	jmp    100435 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100453:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  100459:	e9 52 ff ff ff       	jmpq   1003b0 <printer_vprintf+0x86>
        int width = -1;
  10045e:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  100464:	e9 47 ff ff ff       	jmpq   1003b0 <printer_vprintf+0x86>
            ++format;
  100469:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  10046d:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100471:	8d 48 d0             	lea    -0x30(%rax),%ecx
  100474:	80 f9 09             	cmp    $0x9,%cl
  100477:	76 13                	jbe    10048c <printer_vprintf+0x162>
            } else if (*format == '*') {
  100479:	3c 2a                	cmp    $0x2a,%al
  10047b:	74 33                	je     1004b0 <printer_vprintf+0x186>
            ++format;
  10047d:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  100480:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  100487:	e9 34 ff ff ff       	jmpq   1003c0 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10048c:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  100491:	48 83 c2 01          	add    $0x1,%rdx
  100495:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  100498:	0f be c0             	movsbl %al,%eax
  10049b:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10049f:	0f b6 02             	movzbl (%rdx),%eax
  1004a2:	8d 70 d0             	lea    -0x30(%rax),%esi
  1004a5:	40 80 fe 09          	cmp    $0x9,%sil
  1004a9:	76 e6                	jbe    100491 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  1004ab:	48 89 d3             	mov    %rdx,%rbx
  1004ae:	eb 1c                	jmp    1004cc <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  1004b0:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004b4:	8b 07                	mov    (%rdi),%eax
  1004b6:	83 f8 2f             	cmp    $0x2f,%eax
  1004b9:	77 23                	ja     1004de <printer_vprintf+0x1b4>
  1004bb:	89 c2                	mov    %eax,%edx
  1004bd:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004c1:	83 c0 08             	add    $0x8,%eax
  1004c4:	89 07                	mov    %eax,(%rdi)
  1004c6:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  1004c8:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1004cc:	85 c9                	test   %ecx,%ecx
  1004ce:	b8 00 00 00 00       	mov    $0x0,%eax
  1004d3:	0f 49 c1             	cmovns %ecx,%eax
  1004d6:	89 45 9c             	mov    %eax,-0x64(%rbp)
  1004d9:	e9 e2 fe ff ff       	jmpq   1003c0 <printer_vprintf+0x96>
                precision = va_arg(val, int);
  1004de:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004e2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004e6:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004ea:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1004ee:	eb d6                	jmp    1004c6 <printer_vprintf+0x19c>
        switch (*format) {
  1004f0:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1004f5:	e9 f3 00 00 00       	jmpq   1005ed <printer_vprintf+0x2c3>
            ++format;
  1004fa:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  1004fe:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100503:	e9 bd fe ff ff       	jmpq   1003c5 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100508:	85 c9                	test   %ecx,%ecx
  10050a:	74 55                	je     100561 <printer_vprintf+0x237>
  10050c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100510:	8b 07                	mov    (%rdi),%eax
  100512:	83 f8 2f             	cmp    $0x2f,%eax
  100515:	77 38                	ja     10054f <printer_vprintf+0x225>
  100517:	89 c2                	mov    %eax,%edx
  100519:	48 03 57 10          	add    0x10(%rdi),%rdx
  10051d:	83 c0 08             	add    $0x8,%eax
  100520:	89 07                	mov    %eax,(%rdi)
  100522:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100525:	48 89 d0             	mov    %rdx,%rax
  100528:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  10052c:	49 89 d0             	mov    %rdx,%r8
  10052f:	49 f7 d8             	neg    %r8
  100532:	25 80 00 00 00       	and    $0x80,%eax
  100537:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10053b:	0b 45 a8             	or     -0x58(%rbp),%eax
  10053e:	83 c8 60             	or     $0x60,%eax
  100541:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  100544:	41 bc d0 11 10 00    	mov    $0x1011d0,%r12d
            break;
  10054a:	e9 35 01 00 00       	jmpq   100684 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10054f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100553:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100557:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10055b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10055f:	eb c1                	jmp    100522 <printer_vprintf+0x1f8>
  100561:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100565:	8b 07                	mov    (%rdi),%eax
  100567:	83 f8 2f             	cmp    $0x2f,%eax
  10056a:	77 10                	ja     10057c <printer_vprintf+0x252>
  10056c:	89 c2                	mov    %eax,%edx
  10056e:	48 03 57 10          	add    0x10(%rdi),%rdx
  100572:	83 c0 08             	add    $0x8,%eax
  100575:	89 07                	mov    %eax,(%rdi)
  100577:	48 63 12             	movslq (%rdx),%rdx
  10057a:	eb a9                	jmp    100525 <printer_vprintf+0x1fb>
  10057c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100580:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100584:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100588:	48 89 47 08          	mov    %rax,0x8(%rdi)
  10058c:	eb e9                	jmp    100577 <printer_vprintf+0x24d>
        int base = 10;
  10058e:	be 0a 00 00 00       	mov    $0xa,%esi
  100593:	eb 58                	jmp    1005ed <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100595:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100599:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10059d:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005a1:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005a5:	eb 60                	jmp    100607 <printer_vprintf+0x2dd>
  1005a7:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005ab:	8b 07                	mov    (%rdi),%eax
  1005ad:	83 f8 2f             	cmp    $0x2f,%eax
  1005b0:	77 10                	ja     1005c2 <printer_vprintf+0x298>
  1005b2:	89 c2                	mov    %eax,%edx
  1005b4:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005b8:	83 c0 08             	add    $0x8,%eax
  1005bb:	89 07                	mov    %eax,(%rdi)
  1005bd:	44 8b 02             	mov    (%rdx),%r8d
  1005c0:	eb 48                	jmp    10060a <printer_vprintf+0x2e0>
  1005c2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005c6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005ca:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005ce:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005d2:	eb e9                	jmp    1005bd <printer_vprintf+0x293>
  1005d4:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  1005d7:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  1005de:	bf b0 11 10 00       	mov    $0x1011b0,%edi
  1005e3:	e9 e2 02 00 00       	jmpq   1008ca <printer_vprintf+0x5a0>
            base = 16;
  1005e8:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1005ed:	85 c9                	test   %ecx,%ecx
  1005ef:	74 b6                	je     1005a7 <printer_vprintf+0x27d>
  1005f1:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005f5:	8b 01                	mov    (%rcx),%eax
  1005f7:	83 f8 2f             	cmp    $0x2f,%eax
  1005fa:	77 99                	ja     100595 <printer_vprintf+0x26b>
  1005fc:	89 c2                	mov    %eax,%edx
  1005fe:	48 03 51 10          	add    0x10(%rcx),%rdx
  100602:	83 c0 08             	add    $0x8,%eax
  100605:	89 01                	mov    %eax,(%rcx)
  100607:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  10060a:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10060e:	85 f6                	test   %esi,%esi
  100610:	79 c2                	jns    1005d4 <printer_vprintf+0x2aa>
        base = -base;
  100612:	41 89 f1             	mov    %esi,%r9d
  100615:	f7 de                	neg    %esi
  100617:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  10061e:	bf 90 11 10 00       	mov    $0x101190,%edi
  100623:	e9 a2 02 00 00       	jmpq   1008ca <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  100628:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10062c:	8b 07                	mov    (%rdi),%eax
  10062e:	83 f8 2f             	cmp    $0x2f,%eax
  100631:	77 1c                	ja     10064f <printer_vprintf+0x325>
  100633:	89 c2                	mov    %eax,%edx
  100635:	48 03 57 10          	add    0x10(%rdi),%rdx
  100639:	83 c0 08             	add    $0x8,%eax
  10063c:	89 07                	mov    %eax,(%rdi)
  10063e:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100641:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  100648:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  10064d:	eb c3                	jmp    100612 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  10064f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100653:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100657:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10065b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10065f:	eb dd                	jmp    10063e <printer_vprintf+0x314>
            data = va_arg(val, char*);
  100661:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100665:	8b 01                	mov    (%rcx),%eax
  100667:	83 f8 2f             	cmp    $0x2f,%eax
  10066a:	0f 87 a5 01 00 00    	ja     100815 <printer_vprintf+0x4eb>
  100670:	89 c2                	mov    %eax,%edx
  100672:	48 03 51 10          	add    0x10(%rcx),%rdx
  100676:	83 c0 08             	add    $0x8,%eax
  100679:	89 01                	mov    %eax,(%rcx)
  10067b:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  10067e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  100684:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100687:	83 e0 20             	and    $0x20,%eax
  10068a:	89 45 8c             	mov    %eax,-0x74(%rbp)
  10068d:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  100693:	0f 85 21 02 00 00    	jne    1008ba <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100699:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10069c:	89 45 88             	mov    %eax,-0x78(%rbp)
  10069f:	83 e0 60             	and    $0x60,%eax
  1006a2:	83 f8 60             	cmp    $0x60,%eax
  1006a5:	0f 84 54 02 00 00    	je     1008ff <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006ab:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006ae:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  1006b1:	48 c7 45 a0 d0 11 10 	movq   $0x1011d0,-0x60(%rbp)
  1006b8:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006b9:	83 f8 21             	cmp    $0x21,%eax
  1006bc:	0f 84 79 02 00 00    	je     10093b <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1006c2:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  1006c5:	89 f8                	mov    %edi,%eax
  1006c7:	f7 d0                	not    %eax
  1006c9:	c1 e8 1f             	shr    $0x1f,%eax
  1006cc:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1006cf:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1006d3:	0f 85 9e 02 00 00    	jne    100977 <printer_vprintf+0x64d>
  1006d9:	84 c0                	test   %al,%al
  1006db:	0f 84 96 02 00 00    	je     100977 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  1006e1:	48 63 f7             	movslq %edi,%rsi
  1006e4:	4c 89 e7             	mov    %r12,%rdi
  1006e7:	e8 63 fb ff ff       	callq  10024f <strnlen>
  1006ec:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  1006ef:	8b 45 88             	mov    -0x78(%rbp),%eax
  1006f2:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  1006f5:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1006fc:	83 f8 22             	cmp    $0x22,%eax
  1006ff:	0f 84 aa 02 00 00    	je     1009af <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100705:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100709:	e8 26 fb ff ff       	callq  100234 <strlen>
  10070e:	8b 55 9c             	mov    -0x64(%rbp),%edx
  100711:	03 55 98             	add    -0x68(%rbp),%edx
  100714:	44 89 e9             	mov    %r13d,%ecx
  100717:	29 d1                	sub    %edx,%ecx
  100719:	29 c1                	sub    %eax,%ecx
  10071b:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  10071e:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100721:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100725:	75 2d                	jne    100754 <printer_vprintf+0x42a>
  100727:	85 c9                	test   %ecx,%ecx
  100729:	7e 29                	jle    100754 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  10072b:	44 89 fa             	mov    %r15d,%edx
  10072e:	be 20 00 00 00       	mov    $0x20,%esi
  100733:	4c 89 f7             	mov    %r14,%rdi
  100736:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100739:	41 83 ed 01          	sub    $0x1,%r13d
  10073d:	45 85 ed             	test   %r13d,%r13d
  100740:	7f e9                	jg     10072b <printer_vprintf+0x401>
  100742:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  100745:	85 ff                	test   %edi,%edi
  100747:	b8 01 00 00 00       	mov    $0x1,%eax
  10074c:	0f 4f c7             	cmovg  %edi,%eax
  10074f:	29 c7                	sub    %eax,%edi
  100751:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  100754:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100758:	0f b6 07             	movzbl (%rdi),%eax
  10075b:	84 c0                	test   %al,%al
  10075d:	74 22                	je     100781 <printer_vprintf+0x457>
  10075f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100763:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  100766:	0f b6 f0             	movzbl %al,%esi
  100769:	44 89 fa             	mov    %r15d,%edx
  10076c:	4c 89 f7             	mov    %r14,%rdi
  10076f:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  100772:	48 83 c3 01          	add    $0x1,%rbx
  100776:	0f b6 03             	movzbl (%rbx),%eax
  100779:	84 c0                	test   %al,%al
  10077b:	75 e9                	jne    100766 <printer_vprintf+0x43c>
  10077d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  100781:	8b 45 9c             	mov    -0x64(%rbp),%eax
  100784:	85 c0                	test   %eax,%eax
  100786:	7e 1d                	jle    1007a5 <printer_vprintf+0x47b>
  100788:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  10078c:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  10078e:	44 89 fa             	mov    %r15d,%edx
  100791:	be 30 00 00 00       	mov    $0x30,%esi
  100796:	4c 89 f7             	mov    %r14,%rdi
  100799:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  10079c:	83 eb 01             	sub    $0x1,%ebx
  10079f:	75 ed                	jne    10078e <printer_vprintf+0x464>
  1007a1:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  1007a5:	8b 45 98             	mov    -0x68(%rbp),%eax
  1007a8:	85 c0                	test   %eax,%eax
  1007aa:	7e 27                	jle    1007d3 <printer_vprintf+0x4a9>
  1007ac:	89 c0                	mov    %eax,%eax
  1007ae:	4c 01 e0             	add    %r12,%rax
  1007b1:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007b5:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  1007b8:	41 0f b6 34 24       	movzbl (%r12),%esi
  1007bd:	44 89 fa             	mov    %r15d,%edx
  1007c0:	4c 89 f7             	mov    %r14,%rdi
  1007c3:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  1007c6:	49 83 c4 01          	add    $0x1,%r12
  1007ca:	49 39 dc             	cmp    %rbx,%r12
  1007cd:	75 e9                	jne    1007b8 <printer_vprintf+0x48e>
  1007cf:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  1007d3:	45 85 ed             	test   %r13d,%r13d
  1007d6:	7e 14                	jle    1007ec <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  1007d8:	44 89 fa             	mov    %r15d,%edx
  1007db:	be 20 00 00 00       	mov    $0x20,%esi
  1007e0:	4c 89 f7             	mov    %r14,%rdi
  1007e3:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  1007e6:	41 83 ed 01          	sub    $0x1,%r13d
  1007ea:	75 ec                	jne    1007d8 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  1007ec:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  1007f0:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1007f4:	84 c0                	test   %al,%al
  1007f6:	0f 84 fe 01 00 00    	je     1009fa <printer_vprintf+0x6d0>
        if (*format != '%') {
  1007fc:	3c 25                	cmp    $0x25,%al
  1007fe:	0f 84 54 fb ff ff    	je     100358 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100804:	0f b6 f0             	movzbl %al,%esi
  100807:	44 89 fa             	mov    %r15d,%edx
  10080a:	4c 89 f7             	mov    %r14,%rdi
  10080d:	41 ff 16             	callq  *(%r14)
            continue;
  100810:	4c 89 e3             	mov    %r12,%rbx
  100813:	eb d7                	jmp    1007ec <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100815:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100819:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10081d:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100821:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100825:	e9 51 fe ff ff       	jmpq   10067b <printer_vprintf+0x351>
            color = va_arg(val, int);
  10082a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10082e:	8b 07                	mov    (%rdi),%eax
  100830:	83 f8 2f             	cmp    $0x2f,%eax
  100833:	77 10                	ja     100845 <printer_vprintf+0x51b>
  100835:	89 c2                	mov    %eax,%edx
  100837:	48 03 57 10          	add    0x10(%rdi),%rdx
  10083b:	83 c0 08             	add    $0x8,%eax
  10083e:	89 07                	mov    %eax,(%rdi)
  100840:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  100843:	eb a7                	jmp    1007ec <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  100845:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100849:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10084d:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100851:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100855:	eb e9                	jmp    100840 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  100857:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10085b:	8b 01                	mov    (%rcx),%eax
  10085d:	83 f8 2f             	cmp    $0x2f,%eax
  100860:	77 23                	ja     100885 <printer_vprintf+0x55b>
  100862:	89 c2                	mov    %eax,%edx
  100864:	48 03 51 10          	add    0x10(%rcx),%rdx
  100868:	83 c0 08             	add    $0x8,%eax
  10086b:	89 01                	mov    %eax,(%rcx)
  10086d:	8b 02                	mov    (%rdx),%eax
  10086f:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  100872:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100876:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10087a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  100880:	e9 ff fd ff ff       	jmpq   100684 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  100885:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100889:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10088d:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100891:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100895:	eb d6                	jmp    10086d <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  100897:	84 d2                	test   %dl,%dl
  100899:	0f 85 39 01 00 00    	jne    1009d8 <printer_vprintf+0x6ae>
  10089f:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  1008a3:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  1008a7:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  1008ab:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008af:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1008b5:	e9 ca fd ff ff       	jmpq   100684 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  1008ba:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  1008c0:	bf b0 11 10 00       	mov    $0x1011b0,%edi
        if (flags & FLAG_NUMERIC) {
  1008c5:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1008ca:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1008ce:	4c 89 c1             	mov    %r8,%rcx
  1008d1:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  1008d5:	48 63 f6             	movslq %esi,%rsi
  1008d8:	49 83 ec 01          	sub    $0x1,%r12
  1008dc:	48 89 c8             	mov    %rcx,%rax
  1008df:	ba 00 00 00 00       	mov    $0x0,%edx
  1008e4:	48 f7 f6             	div    %rsi
  1008e7:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  1008eb:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  1008ef:	48 89 ca             	mov    %rcx,%rdx
  1008f2:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  1008f5:	48 39 d6             	cmp    %rdx,%rsi
  1008f8:	76 de                	jbe    1008d8 <printer_vprintf+0x5ae>
  1008fa:	e9 9a fd ff ff       	jmpq   100699 <printer_vprintf+0x36f>
                prefix = "-";
  1008ff:	48 c7 45 a0 c2 0f 10 	movq   $0x100fc2,-0x60(%rbp)
  100906:	00 
            if (flags & FLAG_NEGATIVE) {
  100907:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10090a:	a8 80                	test   $0x80,%al
  10090c:	0f 85 b0 fd ff ff    	jne    1006c2 <printer_vprintf+0x398>
                prefix = "+";
  100912:	48 c7 45 a0 bd 0f 10 	movq   $0x100fbd,-0x60(%rbp)
  100919:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  10091a:	a8 10                	test   $0x10,%al
  10091c:	0f 85 a0 fd ff ff    	jne    1006c2 <printer_vprintf+0x398>
                prefix = " ";
  100922:	a8 08                	test   $0x8,%al
  100924:	ba d0 11 10 00       	mov    $0x1011d0,%edx
  100929:	b8 cd 11 10 00       	mov    $0x1011cd,%eax
  10092e:	48 0f 44 c2          	cmove  %rdx,%rax
  100932:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100936:	e9 87 fd ff ff       	jmpq   1006c2 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  10093b:	41 8d 41 10          	lea    0x10(%r9),%eax
  10093f:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  100944:	0f 85 78 fd ff ff    	jne    1006c2 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  10094a:	4d 85 c0             	test   %r8,%r8
  10094d:	75 0d                	jne    10095c <printer_vprintf+0x632>
  10094f:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  100956:	0f 84 66 fd ff ff    	je     1006c2 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  10095c:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  100960:	ba c4 0f 10 00       	mov    $0x100fc4,%edx
  100965:	b8 bf 0f 10 00       	mov    $0x100fbf,%eax
  10096a:	48 0f 44 c2          	cmove  %rdx,%rax
  10096e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100972:	e9 4b fd ff ff       	jmpq   1006c2 <printer_vprintf+0x398>
            len = strlen(data);
  100977:	4c 89 e7             	mov    %r12,%rdi
  10097a:	e8 b5 f8 ff ff       	callq  100234 <strlen>
  10097f:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100982:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100986:	0f 84 63 fd ff ff    	je     1006ef <printer_vprintf+0x3c5>
  10098c:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  100990:	0f 84 59 fd ff ff    	je     1006ef <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  100996:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  100999:	89 ca                	mov    %ecx,%edx
  10099b:	29 c2                	sub    %eax,%edx
  10099d:	39 c1                	cmp    %eax,%ecx
  10099f:	b8 00 00 00 00       	mov    $0x0,%eax
  1009a4:	0f 4e d0             	cmovle %eax,%edx
  1009a7:	89 55 9c             	mov    %edx,-0x64(%rbp)
  1009aa:	e9 56 fd ff ff       	jmpq   100705 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  1009af:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1009b3:	e8 7c f8 ff ff       	callq  100234 <strlen>
  1009b8:	8b 7d 98             	mov    -0x68(%rbp),%edi
  1009bb:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  1009be:	44 89 e9             	mov    %r13d,%ecx
  1009c1:	29 f9                	sub    %edi,%ecx
  1009c3:	29 c1                	sub    %eax,%ecx
  1009c5:	44 39 ea             	cmp    %r13d,%edx
  1009c8:	b8 00 00 00 00       	mov    $0x0,%eax
  1009cd:	0f 4d c8             	cmovge %eax,%ecx
  1009d0:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  1009d3:	e9 2d fd ff ff       	jmpq   100705 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  1009d8:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  1009db:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1009df:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1009e3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1009e9:	e9 96 fc ff ff       	jmpq   100684 <printer_vprintf+0x35a>
        int flags = 0;
  1009ee:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  1009f5:	e9 b0 f9 ff ff       	jmpq   1003aa <printer_vprintf+0x80>
}
  1009fa:	48 83 c4 58          	add    $0x58,%rsp
  1009fe:	5b                   	pop    %rbx
  1009ff:	41 5c                	pop    %r12
  100a01:	41 5d                	pop    %r13
  100a03:	41 5e                	pop    %r14
  100a05:	41 5f                	pop    %r15
  100a07:	5d                   	pop    %rbp
  100a08:	c3                   	retq   

0000000000100a09 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100a09:	55                   	push   %rbp
  100a0a:	48 89 e5             	mov    %rsp,%rbp
  100a0d:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  100a11:	48 c7 45 f0 14 01 10 	movq   $0x100114,-0x10(%rbp)
  100a18:	00 
        cpos = 0;
  100a19:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  100a1f:	b8 00 00 00 00       	mov    $0x0,%eax
  100a24:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100a27:	48 63 ff             	movslq %edi,%rdi
  100a2a:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100a31:	00 
  100a32:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100a36:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100a3a:	e8 eb f8 ff ff       	callq  10032a <printer_vprintf>
    return cp.cursor - console;
  100a3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a43:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100a49:	48 d1 f8             	sar    %rax
}
  100a4c:	c9                   	leaveq 
  100a4d:	c3                   	retq   

0000000000100a4e <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100a4e:	55                   	push   %rbp
  100a4f:	48 89 e5             	mov    %rsp,%rbp
  100a52:	48 83 ec 50          	sub    $0x50,%rsp
  100a56:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a5a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a5e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100a62:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a69:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a6d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a71:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a75:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100a79:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a7d:	e8 87 ff ff ff       	callq  100a09 <console_vprintf>
}
  100a82:	c9                   	leaveq 
  100a83:	c3                   	retq   

0000000000100a84 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100a84:	55                   	push   %rbp
  100a85:	48 89 e5             	mov    %rsp,%rbp
  100a88:	53                   	push   %rbx
  100a89:	48 83 ec 28          	sub    $0x28,%rsp
  100a8d:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100a90:	48 c7 45 d8 9a 01 10 	movq   $0x10019a,-0x28(%rbp)
  100a97:	00 
    sp.s = s;
  100a98:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100a9c:	48 85 f6             	test   %rsi,%rsi
  100a9f:	75 0b                	jne    100aac <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100aa1:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100aa4:	29 d8                	sub    %ebx,%eax
}
  100aa6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100aaa:	c9                   	leaveq 
  100aab:	c3                   	retq   
        sp.end = s + size - 1;
  100aac:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100ab1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100ab5:	be 00 00 00 00       	mov    $0x0,%esi
  100aba:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100abe:	e8 67 f8 ff ff       	callq  10032a <printer_vprintf>
        *sp.s = 0;
  100ac3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100ac7:	c6 00 00             	movb   $0x0,(%rax)
  100aca:	eb d5                	jmp    100aa1 <vsnprintf+0x1d>

0000000000100acc <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100acc:	55                   	push   %rbp
  100acd:	48 89 e5             	mov    %rsp,%rbp
  100ad0:	48 83 ec 50          	sub    $0x50,%rsp
  100ad4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100ad8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100adc:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100ae0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100ae7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100aeb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100aef:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100af3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100af7:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100afb:	e8 84 ff ff ff       	callq  100a84 <vsnprintf>
    va_end(val);
    return n;
}
  100b00:	c9                   	leaveq 
  100b01:	c3                   	retq   

0000000000100b02 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b02:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100b07:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100b0c:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b11:	48 83 c0 02          	add    $0x2,%rax
  100b15:	48 39 d0             	cmp    %rdx,%rax
  100b18:	75 f2                	jne    100b0c <console_clear+0xa>
    }
    cursorpos = 0;
  100b1a:	c7 05 d8 84 fb ff 00 	movl   $0x0,-0x47b28(%rip)        # b8ffc <cursorpos>
  100b21:	00 00 00 
}
  100b24:	c3                   	retq   

0000000000100b25 <free>:

//head list ptr
linked *head = NULL;

void free(void *firstbyte) {
    if (firstbyte == NULL)
  100b25:	48 85 ff             	test   %rdi,%rdi
  100b28:	74 0c                	je     100b36 <free+0x11>
        return;
    linked *curr = head;
  100b2a:	48 8b 05 f7 14 00 00 	mov    0x14f7(%rip),%rax        # 102028 <head>
    while (curr){
  100b31:	48 85 c0             	test   %rax,%rax
  100b34:	75 0a                	jne    100b40 <free+0x1b>
                break;
            }
        curr = curr->next;
    }
    return;
}
  100b36:	c3                   	retq   
        curr = curr->next;
  100b37:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (curr){
  100b3b:	48 85 c0             	test   %rax,%rax
  100b3e:	74 f6                	je     100b36 <free+0x11>
        if (curr->addr == firstbyte) 
  100b40:	48 39 78 10          	cmp    %rdi,0x10(%rax)
  100b44:	75 f1                	jne    100b37 <free+0x12>
            if(curr->free == 1){
  100b46:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  100b4a:	75 eb                	jne    100b37 <free+0x12>
                curr->free = 0;
  100b4c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
                break;
  100b53:	c3                   	retq   

0000000000100b54 <add_block>:


void add_block(void *b) {
    linked *temp = (linked *)b;
    temp->next = NULL;
  100b54:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  100b5b:	00 
    temp->prev = NULL;
  100b5c:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  100b63:	00 
    temp->free = 0;
  100b64:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%rdi)
    if ((uintptr_t)temp <= (uintptr_t)head || head == NULL ){
  100b6b:	48 8b 05 b6 14 00 00 	mov    0x14b6(%rip),%rax        # 102028 <head>
  100b72:	48 85 c0             	test   %rax,%rax
  100b75:	74 1f                	je     100b96 <add_block+0x42>
  100b77:	48 39 f8             	cmp    %rdi,%rax
  100b7a:	73 1a                	jae    100b96 <add_block+0x42>
        temp->next = head;
        head = temp;
    }
    else{
        linked *curr = head;
        while ((uintptr_t)temp >= (uintptr_t) curr->next && curr->next != NULL){
  100b7c:	48 89 c2             	mov    %rax,%rdx
  100b7f:	48 8b 40 18          	mov    0x18(%rax),%rax
  100b83:	48 85 c0             	test   %rax,%rax
  100b86:	74 05                	je     100b8d <add_block+0x39>
  100b88:	48 39 f8             	cmp    %rdi,%rax
  100b8b:	76 ef                	jbe    100b7c <add_block+0x28>
            curr = curr->next;
        }
        temp->next = curr->next;
  100b8d:	48 89 47 18          	mov    %rax,0x18(%rdi)
        curr->next = temp;
  100b91:	48 89 7a 18          	mov    %rdi,0x18(%rdx)
    }
}
  100b95:	c3                   	retq   
        if (head != NULL)
  100b96:	48 85 c0             	test   %rax,%rax
  100b99:	74 04                	je     100b9f <add_block+0x4b>
            head->prev = temp;
  100b9b:	48 89 78 20          	mov    %rdi,0x20(%rax)
        temp->next = head;
  100b9f:	48 89 47 18          	mov    %rax,0x18(%rdi)
        head = temp;
  100ba3:	48 89 3d 7e 14 00 00 	mov    %rdi,0x147e(%rip)        # 102028 <head>
  100baa:	c3                   	retq   

0000000000100bab <malloc>:

void *malloc(uint64_t numbytes) { 
  100bab:	55                   	push   %rbp
  100bac:	48 89 e5             	mov    %rsp,%rbp
  100baf:	41 56                	push   %r14
  100bb1:	41 55                	push   %r13
  100bb3:	41 54                	push   %r12
  100bb5:	53                   	push   %rbx
    if(numbytes < 1)
  100bb6:	48 85 ff             	test   %rdi,%rdi
  100bb9:	0f 84 f0 00 00 00    	je     100caf <malloc+0x104>
        return NULL;    
    uint64_t meta_sz = (((numbytes + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))) + (8 - 1)) & ~(8 - 1));
  100bbf:	48 8d 5f 2f          	lea    0x2f(%rdi),%rbx
  100bc3:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx
    linked *sized_block = NULL;
    //assign block and search
    linked *curr = head;
  100bc7:	48 8b 05 5a 14 00 00 	mov    0x145a(%rip),%rax        # 102028 <head>
    while (curr != NULL){
  100bce:	48 85 c0             	test   %rax,%rax
  100bd1:	74 54                	je     100c27 <malloc+0x7c>
    linked *sized_block = NULL;
  100bd3:	ba 00 00 00 00       	mov    $0x0,%edx
  100bd8:	eb 09                	jmp    100be3 <malloc+0x38>
        if (curr->free == 0)
            if(curr->sz >= numbytes)
                sized_block = curr;
        curr = curr->next;
  100bda:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (curr != NULL){
  100bde:	48 85 c0             	test   %rax,%rax
  100be1:	74 0f                	je     100bf2 <malloc+0x47>
        if (curr->free == 0)
  100be3:	83 78 08 00          	cmpl   $0x0,0x8(%rax)
  100be7:	75 f1                	jne    100bda <malloc+0x2f>
            if(curr->sz >= numbytes)
  100be9:	48 39 38             	cmp    %rdi,(%rax)
  100bec:	48 0f 43 d0          	cmovae %rax,%rdx
  100bf0:	eb e8                	jmp    100bda <malloc+0x2f>
    }
    if (sized_block == NULL){
  100bf2:	48 85 d2             	test   %rdx,%rdx
  100bf5:	74 30                	je     100c27 <malloc+0x7c>
        }
        //split end

        return (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
    }
    if (heap_flag == 0){
  100bf7:	83 3d 32 14 00 00 00 	cmpl   $0x0,0x1432(%rip)        # 102030 <heap_flag>
  100bfe:	75 07                	jne    100c07 <malloc+0x5c>
        sized_block->free = 1;
  100c00:	c7 42 08 01 00 00 00 	movl   $0x1,0x8(%rdx)
    }
    sized_block->addr = (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
  100c07:	4c 8d 62 28          	lea    0x28(%rdx),%r12
  100c0b:	4c 89 62 10          	mov    %r12,0x10(%rdx)
    
    //splitting
    linked *temp = (linked *) sized_block;
    void *new_ptr = (void *) ((uintptr_t) sized_block + meta_sz);
    if ((sized_block->sz - meta_sz) < (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))){
  100c0f:	48 8b 02             	mov    (%rdx),%rax
  100c12:	48 29 d8             	sub    %rbx,%rax
  100c15:	48 83 f8 27          	cmp    $0x27,%rax
  100c19:	77 79                	ja     100c94 <malloc+0xe9>
        add_block(new_linked);
    } 
    //splitting end

    return (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
}
  100c1b:	4c 89 e0             	mov    %r12,%rax
  100c1e:	5b                   	pop    %rbx
  100c1f:	41 5c                	pop    %r12
  100c21:	41 5d                	pop    %r13
  100c23:	41 5e                	pop    %r14
  100c25:	5d                   	pop    %rbp
  100c26:	c3                   	retq   
        if (meta_sz > PAGESIZE){
  100c27:	41 bd 00 10 00 00    	mov    $0x1000,%r13d
  100c2d:	4c 39 eb             	cmp    %r13,%rbx
  100c30:	4c 0f 43 eb          	cmovae %rbx,%r13
  100c34:	4c 89 ef             	mov    %r13,%rdi
  100c37:	cd 3a                	int    $0x3a
  100c39:	49 89 c6             	mov    %rax,%r14
  100c3c:	48 89 05 f5 13 00 00 	mov    %rax,0x13f5(%rip)        # 102038 <result.0>
            return NULL;
  100c43:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        if (temp_block == (void *)-1){
  100c49:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100c4d:	74 cc                	je     100c1b <malloc+0x70>
        add_block(sized_block);
  100c4f:	48 89 c7             	mov    %rax,%rdi
  100c52:	e8 fd fe ff ff       	callq  100b54 <add_block>
        sized_block->sz = ex_sz;
  100c57:	4d 89 2e             	mov    %r13,(%r14)
        if (heap_flag == 0){
  100c5a:	83 3d cf 13 00 00 00 	cmpl   $0x0,0x13cf(%rip)        # 102030 <heap_flag>
  100c61:	75 08                	jne    100c6b <malloc+0xc0>
            sized_block->free = 1; //for debugging
  100c63:	41 c7 46 08 01 00 00 	movl   $0x1,0x8(%r14)
  100c6a:	00 
        sized_block->addr = (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
  100c6b:	4d 8d 66 28          	lea    0x28(%r14),%r12
  100c6f:	4d 89 66 10          	mov    %r12,0x10(%r14)
        if ((sized_block->sz - meta_sz) < (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))){
  100c73:	49 29 dd             	sub    %rbx,%r13
  100c76:	49 83 fd 27          	cmp    $0x27,%r13
  100c7a:	76 9f                	jbe    100c1b <malloc+0x70>
        void *new_ptr = (void *) ((uintptr_t) sized_block + meta_sz);
  100c7c:	49 8d 3c 1e          	lea    (%r14,%rbx,1),%rdi
            new_linked->sz = sized_block->sz - meta_sz;
  100c80:	4c 89 2f             	mov    %r13,(%rdi)
            temp->sz = meta_sz;
  100c83:	49 89 1e             	mov    %rbx,(%r14)
            new_linked->free = 0; //flag
  100c86:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%rdi)
            add_block(new_linked);
  100c8d:	e8 c2 fe ff ff       	callq  100b54 <add_block>
  100c92:	eb 87                	jmp    100c1b <malloc+0x70>
    void *new_ptr = (void *) ((uintptr_t) sized_block + meta_sz);
  100c94:	48 8d 3c 1a          	lea    (%rdx,%rbx,1),%rdi
        new_linked->sz = sized_block->sz - meta_sz;
  100c98:	48 89 07             	mov    %rax,(%rdi)
        temp->sz = meta_sz;
  100c9b:	48 89 1a             	mov    %rbx,(%rdx)
        new_linked->free = 0;
  100c9e:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%rdi)
        add_block(new_linked);
  100ca5:	e8 aa fe ff ff       	callq  100b54 <add_block>
  100caa:	e9 6c ff ff ff       	jmpq   100c1b <malloc+0x70>
        return NULL;    
  100caf:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100cb5:	e9 61 ff ff ff       	jmpq   100c1b <malloc+0x70>

0000000000100cba <calloc>:


void * calloc(uint64_t num, uint64_t sz) { //done
  100cba:	55                   	push   %rbp
  100cbb:	48 89 e5             	mov    %rsp,%rbp
  100cbe:	41 54                	push   %r12
  100cc0:	53                   	push   %rbx
    void* ptr = NULL;
    //edge case
    if(num == 0)
        return NULL;
    if(sz == 0)
  100cc1:	48 85 f6             	test   %rsi,%rsi
  100cc4:	74 46                	je     100d0c <calloc+0x52>
  100cc6:	48 85 ff             	test   %rdi,%rdi
  100cc9:	74 41                	je     100d0c <calloc+0x52>
        return NULL;

    if(sz > 0 && num > (4294967294/sz)){
  100ccb:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  100cd0:	ba 00 00 00 00       	mov    $0x0,%edx
  100cd5:	48 f7 f6             	div    %rsi
        ptr = NULL;
  100cd8:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if(sz > 0 && num > (4294967294/sz)){
  100cde:	48 39 f8             	cmp    %rdi,%rax
  100ce1:	72 2f                	jb     100d12 <calloc+0x58>
    }
    else
        ptr = malloc(num * sz);
  100ce3:	48 89 fb             	mov    %rdi,%rbx
  100ce6:	48 0f af de          	imul   %rsi,%rbx
  100cea:	48 89 df             	mov    %rbx,%rdi
  100ced:	e8 b9 fe ff ff       	callq  100bab <malloc>
  100cf2:	49 89 c4             	mov    %rax,%r12
    
    if (!ptr){
  100cf5:	48 85 c0             	test   %rax,%rax
  100cf8:	74 18                	je     100d12 <calloc+0x58>
        //nothing
    }
    else
        memset(ptr, 0, num * sz);
  100cfa:	48 89 da             	mov    %rbx,%rdx
  100cfd:	be 00 00 00 00       	mov    $0x0,%esi
  100d02:	48 89 c7             	mov    %rax,%rdi
  100d05:	e8 0f f5 ff ff       	callq  100219 <memset>
  100d0a:	eb 06                	jmp    100d12 <calloc+0x58>
        return NULL;
  100d0c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    return ptr;
}
  100d12:	4c 89 e0             	mov    %r12,%rax
  100d15:	5b                   	pop    %rbx
  100d16:	41 5c                	pop    %r12
  100d18:	5d                   	pop    %rbp
  100d19:	c3                   	retq   

0000000000100d1a <realloc>:

void * realloc(void * ptr, uint64_t sz) { //done
  100d1a:	55                   	push   %rbp
  100d1b:	48 89 e5             	mov    %rsp,%rbp
  100d1e:	41 54                	push   %r12
  100d20:	53                   	push   %rbx
  100d21:	48 89 fb             	mov    %rdi,%rbx
    //for it to equal free
    if (sz == 0){ //size must be 0
        if(ptr != NULL){ //ptr cannot be null
  100d24:	48 85 ff             	test   %rdi,%rdi
  100d27:	74 05                	je     100d2e <realloc+0x14>
  100d29:	48 85 f6             	test   %rsi,%rsi
  100d2c:	74 53                	je     100d81 <realloc+0x67>
            free(ptr); 
            return NULL;
        }
    }
    // for it to be malloc of the sz
    if (ptr == NULL){
  100d2e:	48 85 db             	test   %rbx,%rbx
  100d31:	74 5b                	je     100d8e <realloc+0x74>
        return temp_ptr;
    }
    
    linked *head_ptr = (linked *)(uintptr_t)ptr - (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
    if (sz < head_ptr->sz)
        return ptr;
  100d33:	49 89 dc             	mov    %rbx,%r12
    if (sz < head_ptr->sz)
  100d36:	48 39 b3 c0 f9 ff ff 	cmp    %rsi,-0x640(%rbx)
  100d3d:	77 3a                	ja     100d79 <realloc+0x5f>
    uint64_t new_sz = (((sz + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))) + (8 - 1)) & ~(8 - 1));
    linked *new_loc;
    //overflows?
    if ((((sizeof(linked)) + (8 - 1)) & ~(8 - 1)) > 0)
        if(sz > (4294967294) - (((sizeof(linked)) + (8 - 1)) & ~(8 - 1)))
            return NULL;
  100d3f:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        if(sz > (4294967294) - (((sizeof(linked)) + (8 - 1)) & ~(8 - 1)))
  100d45:	b8 d6 ff ff ff       	mov    $0xffffffd6,%eax
  100d4a:	48 39 c6             	cmp    %rax,%rsi
  100d4d:	77 2a                	ja     100d79 <realloc+0x5f>
    new_loc = malloc(sz);
  100d4f:	48 89 f7             	mov    %rsi,%rdi
  100d52:	e8 54 fe ff ff       	callq  100bab <malloc>
  100d57:	49 89 c4             	mov    %rax,%r12
    if (new_loc == NULL)
  100d5a:	48 85 c0             	test   %rax,%rax
  100d5d:	74 1a                	je     100d79 <realloc+0x5f>
        return NULL;
    memcpy(new_loc, ptr, head_ptr->sz);
  100d5f:	48 8b 93 c0 f9 ff ff 	mov    -0x640(%rbx),%rdx
  100d66:	48 89 de             	mov    %rbx,%rsi
  100d69:	48 89 c7             	mov    %rax,%rdi
  100d6c:	e8 3f f4 ff ff       	callq  1001b0 <memcpy>
    free(ptr);
  100d71:	48 89 df             	mov    %rbx,%rdi
  100d74:	e8 ac fd ff ff       	callq  100b25 <free>
    return new_loc;
}
  100d79:	4c 89 e0             	mov    %r12,%rax
  100d7c:	5b                   	pop    %rbx
  100d7d:	41 5c                	pop    %r12
  100d7f:	5d                   	pop    %rbp
  100d80:	c3                   	retq   
            free(ptr); 
  100d81:	e8 9f fd ff ff       	callq  100b25 <free>
            return NULL;
  100d86:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100d8c:	eb eb                	jmp    100d79 <realloc+0x5f>
        void *temp_ptr = malloc(sz);
  100d8e:	48 89 f7             	mov    %rsi,%rdi
  100d91:	e8 15 fe ff ff       	callq  100bab <malloc>
  100d96:	49 89 c4             	mov    %rax,%r12
        return temp_ptr;
  100d99:	eb de                	jmp    100d79 <realloc+0x5f>

0000000000100d9b <defrag>:

void defrag(){ //done
    linked *curr = head;
  100d9b:	48 8b 05 86 12 00 00 	mov    0x1286(%rip),%rax        # 102028 <head>
    while(curr != NULL){
  100da2:	48 85 c0             	test   %rax,%rax
  100da5:	75 15                	jne    100dbc <defrag+0x21>
                //end curr ==
            }
        }
        curr = curr->next;
    }
}
  100da7:	c3                   	retq   
                        curr->sz += av_sz;
  100da8:	48 8b 0a             	mov    (%rdx),%rcx
  100dab:	48 01 08             	add    %rcx,(%rax)
        curr = curr->next;
  100dae:	48 89 d0             	mov    %rdx,%rax
  100db1:	eb 09                	jmp    100dbc <defrag+0x21>
  100db3:	48 8b 40 18          	mov    0x18(%rax),%rax
    while(curr != NULL){
  100db7:	48 85 c0             	test   %rax,%rax
  100dba:	74 2c                	je     100de8 <defrag+0x4d>
        if (curr->free == 0){
  100dbc:	83 78 08 00          	cmpl   $0x0,0x8(%rax)
  100dc0:	75 f1                	jne    100db3 <defrag+0x18>
            if(curr->next){
  100dc2:	48 8b 50 18          	mov    0x18(%rax),%rdx
  100dc6:	48 85 d2             	test   %rdx,%rdx
  100dc9:	74 dc                	je     100da7 <defrag+0xc>
                if(curr->next->free == 0){
  100dcb:	83 7a 08 00          	cmpl   $0x0,0x8(%rdx)
  100dcf:	75 dd                	jne    100dae <defrag+0x13>
                    if (curr->prev != NULL && curr->prev->free == 0){
  100dd1:	48 8b 48 20          	mov    0x20(%rax),%rcx
  100dd5:	48 85 c9             	test   %rcx,%rcx
  100dd8:	74 ce                	je     100da8 <defrag+0xd>
  100dda:	83 79 08 00          	cmpl   $0x0,0x8(%rcx)
  100dde:	75 c8                	jne    100da8 <defrag+0xd>
                        curr->prev->sz += curr->sz; 
  100de0:	48 8b 10             	mov    (%rax),%rdx
  100de3:	48 01 11             	add    %rdx,(%rcx)
  100de6:	eb cb                	jmp    100db3 <defrag+0x18>
  100de8:	c3                   	retq   

0000000000100de9 <heap_info>:

int heap_info(heap_info_struct * info) {
    return 0;
}
  100de9:	b8 00 00 00 00       	mov    $0x0,%eax
  100dee:	c3                   	retq   

0000000000100def <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100def:	55                   	push   %rbp
  100df0:	48 89 e5             	mov    %rsp,%rbp
  100df3:	48 83 ec 50          	sub    $0x50,%rsp
  100df7:	49 89 f2             	mov    %rsi,%r10
  100dfa:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100dfe:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100e02:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100e06:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100e0a:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100e0f:	85 ff                	test   %edi,%edi
  100e11:	78 2e                	js     100e41 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100e13:	48 63 ff             	movslq %edi,%rdi
  100e16:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100e1d:	cc cc cc 
  100e20:	48 89 f8             	mov    %rdi,%rax
  100e23:	48 f7 e2             	mul    %rdx
  100e26:	48 89 d0             	mov    %rdx,%rax
  100e29:	48 c1 e8 02          	shr    $0x2,%rax
  100e2d:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100e31:	48 01 c2             	add    %rax,%rdx
  100e34:	48 29 d7             	sub    %rdx,%rdi
  100e37:	0f b6 b7 fd 11 10 00 	movzbl 0x1011fd(%rdi),%esi
  100e3e:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100e41:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100e48:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100e4c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e50:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100e54:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100e58:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100e5c:	4c 89 d2             	mov    %r10,%rdx
  100e5f:	8b 3d 97 81 fb ff    	mov    -0x47e69(%rip),%edi        # b8ffc <cursorpos>
  100e65:	e8 9f fb ff ff       	callq  100a09 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100e6a:	3d 30 07 00 00       	cmp    $0x730,%eax
  100e6f:	ba 00 00 00 00       	mov    $0x0,%edx
  100e74:	0f 4d c2             	cmovge %edx,%eax
  100e77:	89 05 7f 81 fb ff    	mov    %eax,-0x47e81(%rip)        # b8ffc <cursorpos>
    }
}
  100e7d:	c9                   	leaveq 
  100e7e:	c3                   	retq   

0000000000100e7f <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100e7f:	55                   	push   %rbp
  100e80:	48 89 e5             	mov    %rsp,%rbp
  100e83:	53                   	push   %rbx
  100e84:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100e8b:	48 89 fb             	mov    %rdi,%rbx
  100e8e:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100e92:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100e96:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100e9a:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100e9e:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100ea2:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100ea9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100ead:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100eb1:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100eb5:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100eb9:	ba 07 00 00 00       	mov    $0x7,%edx
  100ebe:	be c7 11 10 00       	mov    $0x1011c7,%esi
  100ec3:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100eca:	e8 e1 f2 ff ff       	callq  1001b0 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100ecf:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100ed3:	48 89 da             	mov    %rbx,%rdx
  100ed6:	be 99 00 00 00       	mov    $0x99,%esi
  100edb:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100ee2:	e8 9d fb ff ff       	callq  100a84 <vsnprintf>
  100ee7:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100eea:	85 d2                	test   %edx,%edx
  100eec:	7e 0f                	jle    100efd <kernel_panic+0x7e>
  100eee:	83 c0 06             	add    $0x6,%eax
  100ef1:	48 98                	cltq   
  100ef3:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100efa:	0a 
  100efb:	75 2a                	jne    100f27 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100efd:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  100f04:	48 89 d9             	mov    %rbx,%rcx
  100f07:	ba d1 11 10 00       	mov    $0x1011d1,%edx
  100f0c:	be 00 c0 00 00       	mov    $0xc000,%esi
  100f11:	bf 30 07 00 00       	mov    $0x730,%edi
  100f16:	b8 00 00 00 00       	mov    $0x0,%eax
  100f1b:	e8 2e fb ff ff       	callq  100a4e <console_printf>
    asm volatile ("int %0" : /* no result */
  100f20:	48 89 df             	mov    %rbx,%rdi
  100f23:	cd 30                	int    $0x30
 loop: goto loop;
  100f25:	eb fe                	jmp    100f25 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100f27:	48 63 c2             	movslq %edx,%rax
  100f2a:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100f30:	0f 94 c2             	sete   %dl
  100f33:	0f b6 d2             	movzbl %dl,%edx
  100f36:	48 29 d0             	sub    %rdx,%rax
  100f39:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100f40:	ff 
  100f41:	be cf 11 10 00       	mov    $0x1011cf,%esi
  100f46:	e8 27 f3 ff ff       	callq  100272 <strcpy>
  100f4b:	eb b0                	jmp    100efd <kernel_panic+0x7e>

0000000000100f4d <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100f4d:	55                   	push   %rbp
  100f4e:	48 89 e5             	mov    %rsp,%rbp
  100f51:	48 89 f9             	mov    %rdi,%rcx
  100f54:	41 89 f0             	mov    %esi,%r8d
  100f57:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100f5a:	ba d8 11 10 00       	mov    $0x1011d8,%edx
  100f5f:	be 00 c0 00 00       	mov    $0xc000,%esi
  100f64:	bf 30 07 00 00       	mov    $0x730,%edi
  100f69:	b8 00 00 00 00       	mov    $0x0,%eax
  100f6e:	e8 db fa ff ff       	callq  100a4e <console_printf>
    asm volatile ("int %0" : /* no result */
  100f73:	bf 00 00 00 00       	mov    $0x0,%edi
  100f78:	cd 30                	int    $0x30
 loop: goto loop;
  100f7a:	eb fe                	jmp    100f7a <assert_fail+0x2d>
