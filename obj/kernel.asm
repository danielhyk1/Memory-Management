
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	pushq  $0x0
        popfq
   4000c:	9d                   	popfq  
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmpq   40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	pushq  $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	pushq  $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	pushq  $0x0
        pushq $32
   40038:	6a 20                	pushq  $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	pushq  $0x0
        pushq $48
   4003e:	6a 30                	pushq  $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	pushq  $0x0
        pushq $49
   40044:	6a 31                	pushq  $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	pushq  $0x0
        pushq $50
   4004a:	6a 32                	pushq  $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	pushq  $0x0
        pushq $51
   40050:	6a 33                	pushq  $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	pushq  $0x0
        pushq $52
   40056:	6a 34                	pushq  $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	pushq  $0x0
        pushq $53
   4005c:	6a 35                	pushq  $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	pushq  $0x0
        pushq $54
   40062:	6a 36                	pushq  $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	pushq  $0x0
        pushq $55
   40068:	6a 37                	pushq  $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	pushq  $0x0
        pushq $56
   4006e:	6a 38                	pushq  $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	pushq  $0x0
        pushq $57
   40074:	6a 39                	pushq  $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	pushq  $0x0
        pushq $58
   4007a:	6a 3a                	pushq  $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	pushq  $0x0
        pushq $59
   40080:	6a 3b                	pushq  $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	pushq  $0x0
        pushq $60
   40086:	6a 3c                	pushq  $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	pushq  $0x0
        pushq $61
   4008c:	6a 3d                	pushq  $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	pushq  $0x0
        pushq $62
   40092:	6a 3e                	pushq  $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	pushq  $0x0
        pushq $63
   40098:	6a 3f                	pushq  $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	pushq  $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	pushq  %gs
        pushq %fs
   400a2:	0f a0                	pushq  %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 c7 06 00 00       	callq  4078a <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	popq   %fs
        popq %gs
   400df:	0f a9                	popq   %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 31 15 00 00       	callq  416a9 <hardware_init>
    pageinfo_init();
   40178:	e8 b5 0b 00 00       	callq  40d32 <pageinfo_init>
    console_clear();
   4017d:	e8 cf 39 00 00       	callq  43b51 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 0d 1a 00 00       	callq  41b99 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 10 05 00       	mov    $0x51000,%edi
   4019b:	e8 c8 30 00 00       	callq  43268 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 10 05 00 	lea    0x51000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be e6 46 04 00       	mov    $0x446e6,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 ce 30 00 00       	callq  432d9 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 4);
   4020f:	be 04 00 00 00       	mov    $0x4,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	callq  402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmpq   402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be ed 46 04 00       	mov    $0x446ed,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 9e 30 00 00       	callq  432d9 <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 5);
   4023f:	be 05 00 00 00       	mov    $0x5,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	callq  402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be f8 46 04 00       	mov    $0x446f8,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 71 30 00 00       	callq  432d9 <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 6);
   4026c:	be 06 00 00 00       	mov    $0x6,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	callq  402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be fd 46 04 00       	mov    $0x446fd,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 44 30 00 00       	callq  432d9 <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 6);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 06 00 00 00       	mov    $0x6,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	callq  402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	callq  402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 10 05 00       	mov    $0x510f0,%edi
   402d1:	e8 cb 09 00 00       	callq  40ca1 <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 10 05 00    	add    $0x51000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 20 1b 00 00       	callq  41e2b <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 5a 3c 00 00       	callq  43f6f <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 08 47 04 00       	mov    $0x44708,%edx
   4031e:	be 78 00 00 00       	mov    $0x78,%esi
   40323:	bf 28 47 04 00       	mov    $0x44728,%edi
   40328:	e8 c6 22 00 00       	callq  425f3 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 10 05 00 	lea    0x51000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 68 3f 00 00       	callq  442bd <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 38 47 04 00       	mov    $0x44738,%edx
   4035e:	be 7b 00 00 00       	mov    $0x7b,%esi
   40363:	bf 28 47 04 00       	mov    $0x44728,%edi
   40368:	e8 86 22 00 00       	callq  425f3 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 10 05 00    	add    $0x51000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 66 3f 00 00       	callq  442f5 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leaveq 
   403b1:	c3                   	retq   

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq   
   403e5:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq   
   40402:	c6 84 00 21 1f 05 00 	movb   $0x1,0x51f21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 1f 05 00 	mov    %dl,0x51f20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leaveq 
   40425:	c3                   	retq   

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf 1a 01 00 	mov    0x11acf(%rip),%rax        # 51f00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 6f 3f 00 00       	callq  443a8 <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	retq   

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba 1a 01 00 	mov    0x11aba(%rip),%rax        # 51f00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 3e 38 00 00       	callq  43c8d <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	retq   

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b 1a 01 00 	mov    0x11a9b(%rip),%rax        # 51f00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 c6 41 00 00       	callq  4463a <process_page_alloc>
}
   40474:	c9                   	leaveq 
   40475:	c3                   	retq   

0000000000040476 <sbrk>:


int sbrk(proc *p, intptr_t difference) {
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 20          	sub    $0x20,%rsp
   4047e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40482:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    uintptr_t prev_break = p->program_break;
   40486:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4048a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4048e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int err;
    if(difference < 0)
   40492:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40497:	79 21                	jns    404ba <sbrk+0x44>
        if((err = heap_wipe(p, prev_break)) == -1)
   40499:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4049d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404a1:	48 89 d6             	mov    %rdx,%rsi
   404a4:	48 89 c7             	mov    %rax,%rdi
   404a7:	e8 8c 00 00 00       	callq  40538 <heap_wipe>
   404ac:	89 45 f4             	mov    %eax,-0xc(%rbp)
   404af:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   404b3:	75 05                	jne    404ba <sbrk+0x44>
            return err;
   404b5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   404b8:	eb 47                	jmp    40501 <sbrk+0x8b>
    p->program_break = p->program_break + difference;
   404ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404be:	48 8b 50 08          	mov    0x8(%rax),%rdx
   404c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404c6:	48 01 c2             	add    %rax,%rdx
   404c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404cd:	48 89 50 08          	mov    %rdx,0x8(%rax)
    if (p->program_break >= MEMSIZE_VIRTUAL - PAGESIZE)
   404d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404d5:	48 8b 40 08          	mov    0x8(%rax),%rax
   404d9:	48 3d ff ef 2f 00    	cmp    $0x2fefff,%rax
   404df:	76 1c                	jbe    404fd <sbrk+0x87>
        if(p->program_break < p->original_break)
   404e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404e5:	48 8b 50 08          	mov    0x8(%rax),%rdx
   404e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404ed:	48 8b 40 10          	mov    0x10(%rax),%rax
   404f1:	48 39 c2             	cmp    %rax,%rdx
   404f4:	73 07                	jae    404fd <sbrk+0x87>
            return -1; //error
   404f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   404fb:	eb 04                	jmp    40501 <sbrk+0x8b>
    return prev_break;
   404fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   40501:	c9                   	leaveq 
   40502:	c3                   	retq   

0000000000040503 <brk>:

int brk(proc *p, intptr_t difference){
   40503:	55                   	push   %rbp
   40504:	48 89 e5             	mov    %rsp,%rbp
   40507:	48 83 ec 10          	sub    $0x10,%rsp
   4050b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4050f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    if(sbrk(p, difference) < 0)
   40513:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40517:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4051b:	48 89 d6             	mov    %rdx,%rsi
   4051e:	48 89 c7             	mov    %rax,%rdi
   40521:	e8 50 ff ff ff       	callq  40476 <sbrk>
   40526:	85 c0                	test   %eax,%eax
   40528:	79 07                	jns    40531 <brk+0x2e>
        return -1;
   4052a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4052f:	eb 05                	jmp    40536 <brk+0x33>
    else    
        return 0;
   40531:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40536:	c9                   	leaveq 
   40537:	c3                   	retq   

0000000000040538 <heap_wipe>:

int heap_wipe(proc* p, intptr_t prev_break){
   40538:	55                   	push   %rbp
   40539:	48 89 e5             	mov    %rsp,%rbp
   4053c:	48 83 ec 50          	sub    $0x50,%rsp
   40540:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
   40544:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
    int top = ROUNDDOWN(prev_break, PAGESIZE);
   40548:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4054c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   40550:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40554:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4055a:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while(top >= (int) ROUNDUP(p->program_break, PAGESIZE)){
   4055d:	e9 b3 00 00 00       	jmpq   40615 <heap_wipe+0xdd>
        vamapping m = virtual_memory_lookup(p->p_pagetable, top);
   40562:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40565:	48 63 d0             	movslq %eax,%rdx
   40568:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4056c:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40573:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40577:	48 89 ce             	mov    %rcx,%rsi
   4057a:	48 89 c7             	mov    %rax,%rdi
   4057d:	e8 33 27 00 00       	callq  42cb5 <virtual_memory_lookup>
        if (m.pn !=-1) {
   40582:	8b 45 c0             	mov    -0x40(%rbp),%eax
   40585:	83 f8 ff             	cmp    $0xffffffff,%eax
   40588:	0f 84 80 00 00 00    	je     4060e <heap_wipe+0xd6>
            if ((m.perm & PTE_P)){//if perm allows
   4058e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40591:	48 98                	cltq   
   40593:	83 e0 01             	and    $0x1,%eax
   40596:	48 85 c0             	test   %rax,%rax
   40599:	74 3a                	je     405d5 <heap_wipe+0x9d>
                pageinfo[m.pn].refcount -= 1;
   4059b:	8b 45 c0             	mov    -0x40(%rbp),%eax
   4059e:	48 98                	cltq   
   405a0:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   405a7:	00 
   405a8:	8d 50 ff             	lea    -0x1(%rax),%edx
   405ab:	8b 45 c0             	mov    -0x40(%rbp),%eax
   405ae:	48 98                	cltq   
   405b0:	88 94 00 21 1f 05 00 	mov    %dl,0x51f21(%rax,%rax,1)
                if (pageinfo[m.pn].refcount == 0)
   405b7:	8b 45 c0             	mov    -0x40(%rbp),%eax
   405ba:	48 98                	cltq   
   405bc:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   405c3:	00 
   405c4:	84 c0                	test   %al,%al
   405c6:	75 0d                	jne    405d5 <heap_wipe+0x9d>
                    pageinfo[m.pn].owner = PO_FREE; 
   405c8:	8b 45 c0             	mov    -0x40(%rbp),%eax
   405cb:	48 98                	cltq   
   405cd:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   405d4:	00 
            }
            //virtual mem = 0
            int err;
            if((err = virtual_memory_map(p->p_pagetable, top ,-1,PAGESIZE, 0)) == -1)
   405d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   405d8:	48 63 f0             	movslq %eax,%rsi
   405db:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   405df:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   405e6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   405ec:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405f1:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
   405f8:	48 89 c7             	mov    %rax,%rdi
   405fb:	e8 f2 22 00 00       	callq  428f2 <virtual_memory_map>
   40600:	89 45 dc             	mov    %eax,-0x24(%rbp)
   40603:	83 7d dc ff          	cmpl   $0xffffffff,-0x24(%rbp)
   40607:	75 05                	jne    4060e <heap_wipe+0xd6>
                return err;   
   40609:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4060c:	eb 48                	jmp    40656 <heap_wipe+0x11e>
        }
        top -= PAGESIZE;
   4060e:	81 6d fc 00 10 00 00 	subl   $0x1000,-0x4(%rbp)
    while(top >= (int) ROUNDUP(p->program_break, PAGESIZE)){
   40615:	48 c7 45 e8 00 10 00 	movq   $0x1000,-0x18(%rbp)
   4061c:	00 
   4061d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40621:	48 8b 50 08          	mov    0x8(%rax),%rdx
   40625:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40629:	48 01 d0             	add    %rdx,%rax
   4062c:	48 83 e8 01          	sub    $0x1,%rax
   40630:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   40634:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40638:	ba 00 00 00 00       	mov    $0x0,%edx
   4063d:	48 f7 75 e8          	divq   -0x18(%rbp)
   40641:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40645:	48 29 d0             	sub    %rdx,%rax
   40648:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4064b:	0f 8d 11 ff ff ff    	jge    40562 <heap_wipe+0x2a>
    }
    return 0;
   40651:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40656:	c9                   	leaveq 
   40657:	c3                   	retq   

0000000000040658 <syscall_mapping>:

void syscall_mapping(proc* p){
   40658:	55                   	push   %rbp
   40659:	48 89 e5             	mov    %rsp,%rbp
   4065c:	48 83 ec 70          	sub    $0x70,%rsp
   40660:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40664:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40668:	48 8b 40 48          	mov    0x48(%rax),%rax
   4066c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40670:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40674:	48 8b 40 40          	mov    0x40(%rax),%rax
   40678:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   4067c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40680:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40687:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4068b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4068f:	48 89 ce             	mov    %rcx,%rsi
   40692:	48 89 c7             	mov    %rax,%rdi
   40695:	e8 1b 26 00 00       	callq  42cb5 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   4069a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4069d:	48 98                	cltq   
   4069f:	83 e0 06             	and    $0x6,%eax
   406a2:	48 83 f8 06          	cmp    $0x6,%rax
   406a6:	75 73                	jne    4071b <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   406a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406ac:	48 83 c0 17          	add    $0x17,%rax
   406b0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   406b4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406b8:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406bf:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406c3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   406c7:	48 89 ce             	mov    %rcx,%rsi
   406ca:	48 89 c7             	mov    %rax,%rdi
   406cd:	e8 e3 25 00 00       	callq  42cb5 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   406d2:	8b 45 c8             	mov    -0x38(%rbp),%eax
   406d5:	48 98                	cltq   
   406d7:	83 e0 03             	and    $0x3,%eax
   406da:	48 83 f8 03          	cmp    $0x3,%rax
   406de:	75 3e                	jne    4071e <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   406e0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406e4:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406eb:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   406ef:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   406f3:	48 89 ce             	mov    %rcx,%rsi
   406f6:	48 89 c7             	mov    %rax,%rdi
   406f9:	e8 b7 25 00 00       	callq  42cb5 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   406fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40702:	48 89 c1             	mov    %rax,%rcx
   40705:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40709:	ba 18 00 00 00       	mov    $0x18,%edx
   4070e:	48 89 c6             	mov    %rax,%rsi
   40711:	48 89 cf             	mov    %rcx,%rdi
   40714:	e8 e6 2a 00 00       	callq  431ff <memcpy>
   40719:	eb 04                	jmp    4071f <syscall_mapping+0xc7>
	return;
   4071b:	90                   	nop
   4071c:	eb 01                	jmp    4071f <syscall_mapping+0xc7>
	return;
   4071e:	90                   	nop
}
   4071f:	c9                   	leaveq 
   40720:	c3                   	retq   

0000000000040721 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40721:	55                   	push   %rbp
   40722:	48 89 e5             	mov    %rsp,%rbp
   40725:	48 83 ec 18          	sub    $0x18,%rsp
   40729:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4072d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40731:	48 8b 40 48          	mov    0x48(%rax),%rax
   40735:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40738:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4073c:	75 14                	jne    40752 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4073e:	0f b6 05 bb 58 00 00 	movzbl 0x58bb(%rip),%eax        # 46000 <disp_global>
   40745:	84 c0                	test   %al,%al
   40747:	0f 94 c0             	sete   %al
   4074a:	88 05 b0 58 00 00    	mov    %al,0x58b0(%rip)        # 46000 <disp_global>
   40750:	eb 36                	jmp    40788 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40752:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40756:	78 2f                	js     40787 <syscall_mem_tog+0x66>
   40758:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4075c:	7f 29                	jg     40787 <syscall_mem_tog+0x66>
   4075e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40762:	8b 00                	mov    (%rax),%eax
   40764:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40767:	75 1e                	jne    40787 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40769:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4076d:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   40774:	84 c0                	test   %al,%al
   40776:	0f 94 c0             	sete   %al
   40779:	89 c2                	mov    %eax,%edx
   4077b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4077f:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   40785:	eb 01                	jmp    40788 <syscall_mem_tog+0x67>
            return;
   40787:	90                   	nop
    }
}
   40788:	c9                   	leaveq 
   40789:	c3                   	retq   

000000000004078a <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   4078a:	55                   	push   %rbp
   4078b:	48 89 e5             	mov    %rsp,%rbp
   4078e:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
   40795:	48 89 bd e8 fe ff ff 	mov    %rdi,-0x118(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   4079c:	48 8b 05 5d 17 01 00 	mov    0x1175d(%rip),%rax        # 51f00 <current>
   407a3:	48 8b 95 e8 fe ff ff 	mov    -0x118(%rbp),%rdx
   407aa:	48 83 c0 18          	add    $0x18,%rax
   407ae:	48 89 d6             	mov    %rdx,%rsi
   407b1:	ba 18 00 00 00       	mov    $0x18,%edx
   407b6:	48 89 c7             	mov    %rax,%rdi
   407b9:	48 89 d1             	mov    %rdx,%rcx
   407bc:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   407bf:	48 8b 05 3a 38 01 00 	mov    0x1383a(%rip),%rax        # 54000 <kernel_pagetable>
   407c6:	48 89 c7             	mov    %rax,%rdi
   407c9:	e8 f3 1f 00 00       	callq  427c1 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407ce:	8b 05 28 88 07 00    	mov    0x78828(%rip),%eax        # b8ffc <cursorpos>
   407d4:	89 c7                	mov    %eax,%edi
   407d6:	e8 1a 17 00 00       	callq  41ef5 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   407db:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   407e2:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407e9:	48 83 f8 0e          	cmp    $0xe,%rax
   407ed:	74 14                	je     40803 <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   407ef:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   407f6:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407fd:	48 83 f8 0d          	cmp    $0xd,%rax
   40801:	75 16                	jne    40819 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   40803:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   4080a:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40811:	83 e0 04             	and    $0x4,%eax
   40814:	48 85 c0             	test   %rax,%rax
   40817:	74 1a                	je     40833 <exception+0xa9>
        check_virtual_memory();
   40819:	e8 ab 08 00 00       	callq  410c9 <check_virtual_memory>
        if(disp_global){
   4081e:	0f b6 05 db 57 00 00 	movzbl 0x57db(%rip),%eax        # 46000 <disp_global>
   40825:	84 c0                	test   %al,%al
   40827:	74 0a                	je     40833 <exception+0xa9>
            memshow_physical();
   40829:	e8 13 0a 00 00       	callq  41241 <memshow_physical>
            memshow_virtual_animate();
   4082e:	e8 39 0d 00 00       	callq  4156c <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40833:	e8 9a 1b 00 00       	callq  423d2 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40838:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   4083f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40846:	48 83 e8 0e          	sub    $0xe,%rax
   4084a:	48 83 f8 2c          	cmp    $0x2c,%rax
   4084e:	0f 87 a0 03 00 00    	ja     40bf4 <exception+0x46a>
   40854:	48 8b 04 c5 f8 47 04 	mov    0x447f8(,%rax,8),%rax
   4085b:	00 
   4085c:	ff e0                	jmpq   *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   4085e:	48 8b 05 9b 16 01 00 	mov    0x1169b(%rip),%rax        # 51f00 <current>
   40865:	48 8b 40 48          	mov    0x48(%rax),%rax
   40869:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   4086d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40872:	75 0f                	jne    40883 <exception+0xf9>
                        kernel_panic(NULL);
   40874:	bf 00 00 00 00       	mov    $0x0,%edi
   40879:	b8 00 00 00 00       	mov    $0x0,%eax
   4087e:	e8 90 1c 00 00       	callq  42513 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40883:	48 8b 05 76 16 01 00 	mov    0x11676(%rip),%rax        # 51f00 <current>
   4088a:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40891:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   40895:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40899:	48 89 ce             	mov    %rcx,%rsi
   4089c:	48 89 c7             	mov    %rax,%rdi
   4089f:	e8 11 24 00 00       	callq  42cb5 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   408a4:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   408a8:	48 89 c1             	mov    %rax,%rcx
   408ab:	48 8d 85 f8 fe ff ff 	lea    -0x108(%rbp),%rax
   408b2:	ba a0 00 00 00       	mov    $0xa0,%edx
   408b7:	48 89 ce             	mov    %rcx,%rsi
   408ba:	48 89 c7             	mov    %rax,%rdi
   408bd:	e8 3d 29 00 00       	callq  431ff <memcpy>
                    kernel_panic(msg);
   408c2:	48 8d 85 f8 fe ff ff 	lea    -0x108(%rbp),%rax
   408c9:	48 89 c7             	mov    %rax,%rdi
   408cc:	b8 00 00 00 00       	mov    $0x0,%eax
   408d1:	e8 3d 1c 00 00       	callq  42513 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   408d6:	48 8b 05 23 16 01 00 	mov    0x11623(%rip),%rax        # 51f00 <current>
   408dd:	8b 10                	mov    (%rax),%edx
   408df:	48 8b 05 1a 16 01 00 	mov    0x1161a(%rip),%rax        # 51f00 <current>
   408e6:	48 63 d2             	movslq %edx,%rdx
   408e9:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408ed:	e9 14 03 00 00       	jmpq   40c06 <exception+0x47c>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   408f2:	b8 00 00 00 00       	mov    $0x0,%eax
   408f7:	e8 2a fb ff ff       	callq  40426 <syscall_fork>
   408fc:	89 c2                	mov    %eax,%edx
   408fe:	48 8b 05 fb 15 01 00 	mov    0x115fb(%rip),%rax        # 51f00 <current>
   40905:	48 63 d2             	movslq %edx,%rdx
   40908:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   4090c:	e9 f5 02 00 00       	jmpq   40c06 <exception+0x47c>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40911:	48 8b 05 e8 15 01 00 	mov    0x115e8(%rip),%rax        # 51f00 <current>
   40918:	48 89 c7             	mov    %rax,%rdi
   4091b:	e8 38 fd ff ff       	callq  40658 <syscall_mapping>
                break;
   40920:	e9 e1 02 00 00       	jmpq   40c06 <exception+0x47c>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   40925:	b8 00 00 00 00       	mov    $0x0,%eax
   4092a:	e8 0c fb ff ff       	callq  4043b <syscall_exit>
                schedule();
   4092f:	e8 fb 02 00 00       	callq  40c2f <schedule>
                break;
   40934:	e9 cd 02 00 00       	jmpq   40c06 <exception+0x47c>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   40939:	e8 f1 02 00 00       	callq  40c2f <schedule>
                break;                  /* will not be reached */
   4093e:	e9 c3 02 00 00       	jmpq   40c06 <exception+0x47c>
            }

        case INT_SYS_BRK:
            {
                current->p_registers.reg_rax = brk(current, reg->reg_rdi - current->program_break);
   40943:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   4094a:	48 8b 50 30          	mov    0x30(%rax),%rdx
   4094e:	48 8b 05 ab 15 01 00 	mov    0x115ab(%rip),%rax        # 51f00 <current>
   40955:	48 8b 48 08          	mov    0x8(%rax),%rcx
   40959:	48 89 d0             	mov    %rdx,%rax
   4095c:	48 29 c8             	sub    %rcx,%rax
   4095f:	48 89 c2             	mov    %rax,%rdx
   40962:	48 8b 05 97 15 01 00 	mov    0x11597(%rip),%rax        # 51f00 <current>
   40969:	48 89 d6             	mov    %rdx,%rsi
   4096c:	48 89 c7             	mov    %rax,%rdi
   4096f:	e8 8f fb ff ff       	callq  40503 <brk>
   40974:	89 c2                	mov    %eax,%edx
   40976:	48 8b 05 83 15 01 00 	mov    0x11583(%rip),%rax        # 51f00 <current>
   4097d:	48 63 d2             	movslq %edx,%rdx
   40980:	48 89 50 18          	mov    %rdx,0x18(%rax)
		break;
   40984:	e9 7d 02 00 00       	jmpq   40c06 <exception+0x47c>
            }

        case INT_SYS_SBRK:
            {
                current->p_registers.reg_rax = sbrk(current, reg->reg_rdi);
   40989:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40990:	48 8b 40 30          	mov    0x30(%rax),%rax
   40994:	48 89 c2             	mov    %rax,%rdx
   40997:	48 8b 05 62 15 01 00 	mov    0x11562(%rip),%rax        # 51f00 <current>
   4099e:	48 89 d6             	mov    %rdx,%rsi
   409a1:	48 89 c7             	mov    %rax,%rdi
   409a4:	e8 cd fa ff ff       	callq  40476 <sbrk>
   409a9:	89 c2                	mov    %eax,%edx
   409ab:	48 8b 05 4e 15 01 00 	mov    0x1154e(%rip),%rax        # 51f00 <current>
   409b2:	48 63 d2             	movslq %edx,%rdx
   409b5:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   409b9:	e9 48 02 00 00       	jmpq   40c06 <exception+0x47c>
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   409be:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   409c5:	48 8b 40 30          	mov    0x30(%rax),%rax
   409c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   409cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409d1:	48 89 c7             	mov    %rax,%rdi
   409d4:	e8 79 fa ff ff       	callq  40452 <syscall_page_alloc>
		break;
   409d9:	e9 28 02 00 00       	jmpq   40c06 <exception+0x47c>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   409de:	48 8b 05 1b 15 01 00 	mov    0x1151b(%rip),%rax        # 51f00 <current>
   409e5:	48 89 c7             	mov    %rax,%rdi
   409e8:	e8 34 fd ff ff       	callq  40721 <syscall_mem_tog>
                break;
   409ed:	e9 14 02 00 00       	jmpq   40c06 <exception+0x47c>
            }

        case INT_TIMER:
            {
                ++ticks;
   409f2:	8b 05 28 19 01 00    	mov    0x11928(%rip),%eax        # 52320 <ticks>
   409f8:	83 c0 01             	add    $0x1,%eax
   409fb:	89 05 1f 19 01 00    	mov    %eax,0x1191f(%rip)        # 52320 <ticks>
                schedule();
   40a01:	e8 29 02 00 00       	callq  40c2f <schedule>
                break;                  /* will not be reached */
   40a06:	e9 fb 01 00 00       	jmpq   40c06 <exception+0x47c>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40a0b:	0f 20 d0             	mov    %cr2,%rax
   40a0e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    return val;
   40a12:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   40a16:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
                uintptr_t new_mem_size = MEMSIZE_VIRTUAL - PAGESIZE;
   40a1a:	48 c7 45 e0 00 f0 2f 	movq   $0x2ff000,-0x20(%rbp)
   40a21:	00 
                if (addr >= current->original_break  && !(reg->reg_err & PFERR_PRESENT) && addr < new_mem_size){
   40a22:	48 8b 05 d7 14 01 00 	mov    0x114d7(%rip),%rax        # 51f00 <current>
   40a29:	48 8b 40 10          	mov    0x10(%rax),%rax
   40a2d:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40a31:	0f 82 c7 00 00 00    	jb     40afe <exception+0x374>
   40a37:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40a3e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a45:	83 e0 01             	and    $0x1,%eax
   40a48:	48 85 c0             	test   %rax,%rax
   40a4b:	0f 85 ad 00 00 00    	jne    40afe <exception+0x374>
   40a51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40a55:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   40a59:	0f 83 9f 00 00 00    	jae    40afe <exception+0x374>
                    void* phys_page = palloc(current->p_pid);
   40a5f:	48 8b 05 9a 14 01 00 	mov    0x1149a(%rip),%rax        # 51f00 <current>
   40a66:	8b 00                	mov    (%rax),%eax
   40a68:	89 c7                	mov    %eax,%edi
   40a6a:	e8 05 31 00 00       	callq  43b74 <palloc>
   40a6f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
                    if (!phys_page){//no memory
   40a73:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   40a78:	75 20                	jne    40a9a <exception+0x310>
                        current->p_state = P_BROKEN;
   40a7a:	48 8b 05 7f 14 01 00 	mov    0x1147f(%rip),%rax        # 51f00 <current>
   40a81:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40a88:	00 00 00 
                        syscall_exit();
   40a8b:	b8 00 00 00 00       	mov    $0x0,%eax
   40a90:	e8 a6 f9 ff ff       	callq  4043b <syscall_exit>
                        break;
   40a95:	e9 6c 01 00 00       	jmpq   40c06 <exception+0x47c>
                    }
                    uintptr_t align = addr - addr % PAGESIZE;
   40a9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40a9e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40aa4:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
                    int err;
                    if ((err = virtual_memory_map(current->p_pagetable, align, (uintptr_t) phys_page, PAGESIZE, PTE_P | PTE_W| PTE_U)) == 0)
   40aa8:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40aac:	48 8b 05 4d 14 01 00 	mov    0x1144d(%rip),%rax        # 51f00 <current>
   40ab3:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40aba:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40abe:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40ac4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40ac9:	48 89 c7             	mov    %rax,%rdi
   40acc:	e8 21 1e 00 00       	callq  428f2 <virtual_memory_map>
   40ad1:	89 45 cc             	mov    %eax,-0x34(%rbp)
   40ad4:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
   40ad8:	0f 84 27 01 00 00    	je     40c05 <exception+0x47b>
                        break;
                    current->p_state = P_BROKEN;
   40ade:	48 8b 05 1b 14 01 00 	mov    0x1141b(%rip),%rax        # 51f00 <current>
   40ae5:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40aec:	00 00 00 
                    syscall_exit();
   40aef:	b8 00 00 00 00       	mov    $0x0,%eax
   40af4:	e8 42 f9 ff ff       	callq  4043b <syscall_exit>
                    break;
   40af9:	e9 08 01 00 00       	jmpq   40c06 <exception+0x47c>
                }
                const char* operation = reg->reg_err & PFERR_WRITE
   40afe:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b05:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b0c:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   40b0f:	48 85 c0             	test   %rax,%rax
   40b12:	74 07                	je     40b1b <exception+0x391>
   40b14:	b8 6b 47 04 00       	mov    $0x4476b,%eax
   40b19:	eb 05                	jmp    40b20 <exception+0x396>
   40b1b:	b8 71 47 04 00       	mov    $0x44771,%eax
                const char* operation = reg->reg_err & PFERR_WRITE
   40b20:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
                const char* problem = reg->reg_err & PFERR_PRESENT
   40b24:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b2b:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b32:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   40b35:	48 85 c0             	test   %rax,%rax
   40b38:	74 07                	je     40b41 <exception+0x3b7>
   40b3a:	b8 76 47 04 00       	mov    $0x44776,%eax
   40b3f:	eb 05                	jmp    40b46 <exception+0x3bc>
   40b41:	b8 89 47 04 00       	mov    $0x44789,%eax
                const char* problem = reg->reg_err & PFERR_PRESENT
   40b46:	48 89 45 b8          	mov    %rax,-0x48(%rbp)

                if (!(reg->reg_err & PFERR_USER)) {
   40b4a:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b51:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b58:	83 e0 04             	and    $0x4,%eax
   40b5b:	48 85 c0             	test   %rax,%rax
   40b5e:	75 2f                	jne    40b8f <exception+0x405>
                    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40b60:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b67:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40b6e:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40b72:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40b76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b7a:	49 89 f0             	mov    %rsi,%r8
   40b7d:	48 89 c6             	mov    %rax,%rsi
   40b80:	bf 98 47 04 00       	mov    $0x44798,%edi
   40b85:	b8 00 00 00 00       	mov    $0x0,%eax
   40b8a:	e8 84 19 00 00       	callq  42513 <kernel_panic>
                            addr, operation, problem, reg->reg_rip);
                }
                console_printf(CPOS(24, 0), 0x0C00,
   40b8f:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b96:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                        "Process %d page fault for %p (%s %s, rip=%p)!\n",
                        current->p_pid, addr, operation, problem, reg->reg_rip);
   40b9d:	48 8b 05 5c 13 01 00 	mov    0x1135c(%rip),%rax        # 51f00 <current>
                console_printf(CPOS(24, 0), 0x0C00,
   40ba4:	8b 00                	mov    (%rax),%eax
   40ba6:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   40baa:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40bae:	52                   	push   %rdx
   40baf:	ff 75 b8             	pushq  -0x48(%rbp)
   40bb2:	49 89 f1             	mov    %rsi,%r9
   40bb5:	49 89 c8             	mov    %rcx,%r8
   40bb8:	89 c1                	mov    %eax,%ecx
   40bba:	ba c8 47 04 00       	mov    $0x447c8,%edx
   40bbf:	be 00 0c 00 00       	mov    $0xc00,%esi
   40bc4:	bf 80 07 00 00       	mov    $0x780,%edi
   40bc9:	b8 00 00 00 00       	mov    $0x0,%eax
   40bce:	e8 ca 2e 00 00       	callq  43a9d <console_printf>
   40bd3:	48 83 c4 10          	add    $0x10,%rsp
                current->p_state = P_BROKEN;
   40bd7:	48 8b 05 22 13 01 00 	mov    0x11322(%rip),%rax        # 51f00 <current>
   40bde:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40be5:	00 00 00 
                syscall_exit();
   40be8:	b8 00 00 00 00       	mov    $0x0,%eax
   40bed:	e8 49 f8 ff ff       	callq  4043b <syscall_exit>
                break;
   40bf2:	eb 12                	jmp    40c06 <exception+0x47c>
            }

        default:
            default_exception(current);
   40bf4:	48 8b 05 05 13 01 00 	mov    0x11305(%rip),%rax        # 51f00 <current>
   40bfb:	48 89 c7             	mov    %rax,%rdi
   40bfe:	e8 20 1a 00 00       	callq  42623 <default_exception>
            break;                  /* will not be reached */
   40c03:	eb 01                	jmp    40c06 <exception+0x47c>
                        break;
   40c05:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40c06:	48 8b 05 f3 12 01 00 	mov    0x112f3(%rip),%rax        # 51f00 <current>
   40c0d:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c13:	83 f8 01             	cmp    $0x1,%eax
   40c16:	75 0f                	jne    40c27 <exception+0x49d>
        run(current);
   40c18:	48 8b 05 e1 12 01 00 	mov    0x112e1(%rip),%rax        # 51f00 <current>
   40c1f:	48 89 c7             	mov    %rax,%rdi
   40c22:	e8 7a 00 00 00       	callq  40ca1 <run>
    } else {
        schedule();
   40c27:	e8 03 00 00 00       	callq  40c2f <schedule>
    }
}
   40c2c:	90                   	nop
   40c2d:	c9                   	leaveq 
   40c2e:	c3                   	retq   

0000000000040c2f <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40c2f:	55                   	push   %rbp
   40c30:	48 89 e5             	mov    %rsp,%rbp
   40c33:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40c37:	48 8b 05 c2 12 01 00 	mov    0x112c2(%rip),%rax        # 51f00 <current>
   40c3e:	8b 00                	mov    (%rax),%eax
   40c40:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40c43:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c46:	83 c0 01             	add    $0x1,%eax
   40c49:	99                   	cltd   
   40c4a:	c1 ea 1c             	shr    $0x1c,%edx
   40c4d:	01 d0                	add    %edx,%eax
   40c4f:	83 e0 0f             	and    $0xf,%eax
   40c52:	29 d0                	sub    %edx,%eax
   40c54:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40c57:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c5a:	48 63 d0             	movslq %eax,%rdx
   40c5d:	48 89 d0             	mov    %rdx,%rax
   40c60:	48 c1 e0 04          	shl    $0x4,%rax
   40c64:	48 29 d0             	sub    %rdx,%rax
   40c67:	48 c1 e0 04          	shl    $0x4,%rax
   40c6b:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40c71:	8b 00                	mov    (%rax),%eax
   40c73:	83 f8 01             	cmp    $0x1,%eax
   40c76:	75 22                	jne    40c9a <schedule+0x6b>
            run(&processes[pid]);
   40c78:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c7b:	48 63 d0             	movslq %eax,%rdx
   40c7e:	48 89 d0             	mov    %rdx,%rax
   40c81:	48 c1 e0 04          	shl    $0x4,%rax
   40c85:	48 29 d0             	sub    %rdx,%rax
   40c88:	48 c1 e0 04          	shl    $0x4,%rax
   40c8c:	48 05 00 10 05 00    	add    $0x51000,%rax
   40c92:	48 89 c7             	mov    %rax,%rdi
   40c95:	e8 07 00 00 00       	callq  40ca1 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40c9a:	e8 33 17 00 00       	callq  423d2 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40c9f:	eb a2                	jmp    40c43 <schedule+0x14>

0000000000040ca1 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40ca1:	55                   	push   %rbp
   40ca2:	48 89 e5             	mov    %rsp,%rbp
   40ca5:	48 83 ec 10          	sub    $0x10,%rsp
   40ca9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40cad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cb1:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40cb7:	83 f8 01             	cmp    $0x1,%eax
   40cba:	74 14                	je     40cd0 <run+0x2f>
   40cbc:	ba 60 49 04 00       	mov    $0x44960,%edx
   40cc1:	be ac 01 00 00       	mov    $0x1ac,%esi
   40cc6:	bf 28 47 04 00       	mov    $0x44728,%edi
   40ccb:	e8 23 19 00 00       	callq  425f3 <assert_fail>
    current = p;
   40cd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cd4:	48 89 05 25 12 01 00 	mov    %rax,0x11225(%rip)        # 51f00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40cdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cdf:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40ce1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ce5:	8b 00                	mov    (%rax),%eax
   40ce7:	83 c0 02             	add    $0x2,%eax
   40cea:	48 98                	cltq   
   40cec:	0f b7 84 00 c0 46 04 	movzwl 0x446c0(%rax,%rax,1),%eax
   40cf3:	00 
    console_printf(CPOS(24, 79),
   40cf4:	0f b7 c0             	movzwl %ax,%eax
   40cf7:	89 d1                	mov    %edx,%ecx
   40cf9:	ba 79 49 04 00       	mov    $0x44979,%edx
   40cfe:	89 c6                	mov    %eax,%esi
   40d00:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40d05:	b8 00 00 00 00       	mov    $0x0,%eax
   40d0a:	e8 8e 2d 00 00       	callq  43a9d <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40d0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d13:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40d1a:	48 89 c7             	mov    %rax,%rdi
   40d1d:	e8 9f 1a 00 00       	callq  427c1 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40d22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d26:	48 83 c0 18          	add    $0x18,%rax
   40d2a:	48 89 c7             	mov    %rax,%rdi
   40d2d:	e8 91 f3 ff ff       	callq  400c3 <exception_return>

0000000000040d32 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40d32:	55                   	push   %rbp
   40d33:	48 89 e5             	mov    %rsp,%rbp
   40d36:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d3a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40d41:	00 
   40d42:	e9 81 00 00 00       	jmpq   40dc8 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40d47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d4b:	48 89 c7             	mov    %rax,%rdi
   40d4e:	e8 13 0f 00 00       	callq  41c66 <physical_memory_isreserved>
   40d53:	85 c0                	test   %eax,%eax
   40d55:	74 09                	je     40d60 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40d57:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40d5e:	eb 2f                	jmp    40d8f <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40d60:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40d67:	00 
   40d68:	76 0b                	jbe    40d75 <pageinfo_init+0x43>
   40d6a:	b8 18 a0 05 00       	mov    $0x5a018,%eax
   40d6f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d73:	72 0a                	jb     40d7f <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40d75:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40d7c:	00 
   40d7d:	75 09                	jne    40d88 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40d7f:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40d86:	eb 07                	jmp    40d8f <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40d88:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40d8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d93:	48 c1 e8 0c          	shr    $0xc,%rax
   40d97:	89 c1                	mov    %eax,%ecx
   40d99:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d9c:	89 c2                	mov    %eax,%edx
   40d9e:	48 63 c1             	movslq %ecx,%rax
   40da1:	88 94 00 20 1f 05 00 	mov    %dl,0x51f20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40da8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40dac:	0f 95 c2             	setne  %dl
   40daf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40db3:	48 c1 e8 0c          	shr    $0xc,%rax
   40db7:	48 98                	cltq   
   40db9:	88 94 00 21 1f 05 00 	mov    %dl,0x51f21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40dc0:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40dc7:	00 
   40dc8:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40dcf:	00 
   40dd0:	0f 86 71 ff ff ff    	jbe    40d47 <pageinfo_init+0x15>
    }
}
   40dd6:	90                   	nop
   40dd7:	90                   	nop
   40dd8:	c9                   	leaveq 
   40dd9:	c3                   	retq   

0000000000040dda <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40dda:	55                   	push   %rbp
   40ddb:	48 89 e5             	mov    %rsp,%rbp
   40dde:	48 83 ec 50          	sub    $0x50,%rsp
   40de2:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40de6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40dea:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40df0:	48 89 c2             	mov    %rax,%rdx
   40df3:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40df7:	48 39 c2             	cmp    %rax,%rdx
   40dfa:	74 14                	je     40e10 <check_page_table_mappings+0x36>
   40dfc:	ba 80 49 04 00       	mov    $0x44980,%edx
   40e01:	be da 01 00 00       	mov    $0x1da,%esi
   40e06:	bf 28 47 04 00       	mov    $0x44728,%edi
   40e0b:	e8 e3 17 00 00       	callq  425f3 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e10:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40e17:	00 
   40e18:	e9 9a 00 00 00       	jmpq   40eb7 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40e1d:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40e21:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40e25:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e29:	48 89 ce             	mov    %rcx,%rsi
   40e2c:	48 89 c7             	mov    %rax,%rdi
   40e2f:	e8 81 1e 00 00       	callq  42cb5 <virtual_memory_lookup>
        if (vam.pa != va) {
   40e34:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e38:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e3c:	74 27                	je     40e65 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40e3e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40e42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e46:	49 89 d0             	mov    %rdx,%r8
   40e49:	48 89 c1             	mov    %rax,%rcx
   40e4c:	ba 9f 49 04 00       	mov    $0x4499f,%edx
   40e51:	be 00 c0 00 00       	mov    $0xc000,%esi
   40e56:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40e5b:	b8 00 00 00 00       	mov    $0x0,%eax
   40e60:	e8 38 2c 00 00       	callq  43a9d <console_printf>
        }
        assert(vam.pa == va);
   40e65:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e69:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e6d:	74 14                	je     40e83 <check_page_table_mappings+0xa9>
   40e6f:	ba a9 49 04 00       	mov    $0x449a9,%edx
   40e74:	be e3 01 00 00       	mov    $0x1e3,%esi
   40e79:	bf 28 47 04 00       	mov    $0x44728,%edi
   40e7e:	e8 70 17 00 00       	callq  425f3 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40e83:	b8 00 60 04 00       	mov    $0x46000,%eax
   40e88:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e8c:	72 21                	jb     40eaf <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40e8e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40e91:	48 98                	cltq   
   40e93:	83 e0 02             	and    $0x2,%eax
   40e96:	48 85 c0             	test   %rax,%rax
   40e99:	75 14                	jne    40eaf <check_page_table_mappings+0xd5>
   40e9b:	ba b6 49 04 00       	mov    $0x449b6,%edx
   40ea0:	be e5 01 00 00       	mov    $0x1e5,%esi
   40ea5:	bf 28 47 04 00       	mov    $0x44728,%edi
   40eaa:	e8 44 17 00 00       	callq  425f3 <assert_fail>
         va += PAGESIZE) {
   40eaf:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40eb6:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40eb7:	b8 18 a0 05 00       	mov    $0x5a018,%eax
   40ebc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ec0:	0f 82 57 ff ff ff    	jb     40e1d <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40ec6:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40ecd:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40ece:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40ed2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40ed6:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40eda:	48 89 ce             	mov    %rcx,%rsi
   40edd:	48 89 c7             	mov    %rax,%rdi
   40ee0:	e8 d0 1d 00 00       	callq  42cb5 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40ee5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40ee9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40eed:	74 14                	je     40f03 <check_page_table_mappings+0x129>
   40eef:	ba c7 49 04 00       	mov    $0x449c7,%edx
   40ef4:	be ec 01 00 00       	mov    $0x1ec,%esi
   40ef9:	bf 28 47 04 00       	mov    $0x44728,%edi
   40efe:	e8 f0 16 00 00       	callq  425f3 <assert_fail>
    assert(vam.perm & PTE_W);
   40f03:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40f06:	48 98                	cltq   
   40f08:	83 e0 02             	and    $0x2,%eax
   40f0b:	48 85 c0             	test   %rax,%rax
   40f0e:	75 14                	jne    40f24 <check_page_table_mappings+0x14a>
   40f10:	ba b6 49 04 00       	mov    $0x449b6,%edx
   40f15:	be ed 01 00 00       	mov    $0x1ed,%esi
   40f1a:	bf 28 47 04 00       	mov    $0x44728,%edi
   40f1f:	e8 cf 16 00 00       	callq  425f3 <assert_fail>
}
   40f24:	90                   	nop
   40f25:	c9                   	leaveq 
   40f26:	c3                   	retq   

0000000000040f27 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40f27:	55                   	push   %rbp
   40f28:	48 89 e5             	mov    %rsp,%rbp
   40f2b:	48 83 ec 20          	sub    $0x20,%rsp
   40f2f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f33:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40f36:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40f39:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40f3c:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40f43:	48 8b 05 b6 30 01 00 	mov    0x130b6(%rip),%rax        # 54000 <kernel_pagetable>
   40f4a:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40f4e:	75 67                	jne    40fb7 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40f50:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40f5e:	eb 51                	jmp    40fb1 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40f60:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f63:	48 63 d0             	movslq %eax,%rdx
   40f66:	48 89 d0             	mov    %rdx,%rax
   40f69:	48 c1 e0 04          	shl    $0x4,%rax
   40f6d:	48 29 d0             	sub    %rdx,%rax
   40f70:	48 c1 e0 04          	shl    $0x4,%rax
   40f74:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40f7a:	8b 00                	mov    (%rax),%eax
   40f7c:	85 c0                	test   %eax,%eax
   40f7e:	74 2d                	je     40fad <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40f80:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f83:	48 63 d0             	movslq %eax,%rdx
   40f86:	48 89 d0             	mov    %rdx,%rax
   40f89:	48 c1 e0 04          	shl    $0x4,%rax
   40f8d:	48 29 d0             	sub    %rdx,%rax
   40f90:	48 c1 e0 04          	shl    $0x4,%rax
   40f94:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   40f9a:	48 8b 10             	mov    (%rax),%rdx
   40f9d:	48 8b 05 5c 30 01 00 	mov    0x1305c(%rip),%rax        # 54000 <kernel_pagetable>
   40fa4:	48 39 c2             	cmp    %rax,%rdx
   40fa7:	75 04                	jne    40fad <check_page_table_ownership+0x86>
                ++expected_refcount;
   40fa9:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40fad:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40fb1:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40fb5:	7e a9                	jle    40f60 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40fb7:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40fba:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fc1:	be 00 00 00 00       	mov    $0x0,%esi
   40fc6:	48 89 c7             	mov    %rax,%rdi
   40fc9:	e8 03 00 00 00       	callq  40fd1 <check_page_table_ownership_level>
}
   40fce:	90                   	nop
   40fcf:	c9                   	leaveq 
   40fd0:	c3                   	retq   

0000000000040fd1 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40fd1:	55                   	push   %rbp
   40fd2:	48 89 e5             	mov    %rsp,%rbp
   40fd5:	48 83 ec 30          	sub    $0x30,%rsp
   40fd9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40fdd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40fe0:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40fe3:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40fe6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fea:	48 c1 e8 0c          	shr    $0xc,%rax
   40fee:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40ff3:	7e 14                	jle    41009 <check_page_table_ownership_level+0x38>
   40ff5:	ba d8 49 04 00       	mov    $0x449d8,%edx
   40ffa:	be 0a 02 00 00       	mov    $0x20a,%esi
   40fff:	bf 28 47 04 00       	mov    $0x44728,%edi
   41004:	e8 ea 15 00 00       	callq  425f3 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41009:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4100d:	48 c1 e8 0c          	shr    $0xc,%rax
   41011:	48 98                	cltq   
   41013:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   4101a:	00 
   4101b:	0f be c0             	movsbl %al,%eax
   4101e:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41021:	74 14                	je     41037 <check_page_table_ownership_level+0x66>
   41023:	ba f0 49 04 00       	mov    $0x449f0,%edx
   41028:	be 0b 02 00 00       	mov    $0x20b,%esi
   4102d:	bf 28 47 04 00       	mov    $0x44728,%edi
   41032:	e8 bc 15 00 00       	callq  425f3 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41037:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4103b:	48 c1 e8 0c          	shr    $0xc,%rax
   4103f:	48 98                	cltq   
   41041:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   41048:	00 
   41049:	0f be c0             	movsbl %al,%eax
   4104c:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4104f:	74 14                	je     41065 <check_page_table_ownership_level+0x94>
   41051:	ba 18 4a 04 00       	mov    $0x44a18,%edx
   41056:	be 0c 02 00 00       	mov    $0x20c,%esi
   4105b:	bf 28 47 04 00       	mov    $0x44728,%edi
   41060:	e8 8e 15 00 00       	callq  425f3 <assert_fail>
    if (level < 3) {
   41065:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41069:	7f 5b                	jg     410c6 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4106b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41072:	eb 49                	jmp    410bd <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   41074:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41078:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4107b:	48 63 d2             	movslq %edx,%rdx
   4107e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41082:	48 85 c0             	test   %rax,%rax
   41085:	74 32                	je     410b9 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41087:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4108b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4108e:	48 63 d2             	movslq %edx,%rdx
   41091:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41095:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4109b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4109f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   410a2:	8d 70 01             	lea    0x1(%rax),%esi
   410a5:	8b 55 e0             	mov    -0x20(%rbp),%edx
   410a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   410ac:	b9 01 00 00 00       	mov    $0x1,%ecx
   410b1:	48 89 c7             	mov    %rax,%rdi
   410b4:	e8 18 ff ff ff       	callq  40fd1 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   410b9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   410bd:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   410c4:	7e ae                	jle    41074 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   410c6:	90                   	nop
   410c7:	c9                   	leaveq 
   410c8:	c3                   	retq   

00000000000410c9 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   410c9:	55                   	push   %rbp
   410ca:	48 89 e5             	mov    %rsp,%rbp
   410cd:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   410d1:	8b 05 01 00 01 00    	mov    0x10001(%rip),%eax        # 510d8 <processes+0xd8>
   410d7:	85 c0                	test   %eax,%eax
   410d9:	74 14                	je     410ef <check_virtual_memory+0x26>
   410db:	ba 48 4a 04 00       	mov    $0x44a48,%edx
   410e0:	be 1f 02 00 00       	mov    $0x21f,%esi
   410e5:	bf 28 47 04 00       	mov    $0x44728,%edi
   410ea:	e8 04 15 00 00       	callq  425f3 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   410ef:	48 8b 05 0a 2f 01 00 	mov    0x12f0a(%rip),%rax        # 54000 <kernel_pagetable>
   410f6:	48 89 c7             	mov    %rax,%rdi
   410f9:	e8 dc fc ff ff       	callq  40dda <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   410fe:	48 8b 05 fb 2e 01 00 	mov    0x12efb(%rip),%rax        # 54000 <kernel_pagetable>
   41105:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4110a:	48 89 c7             	mov    %rax,%rdi
   4110d:	e8 15 fe ff ff       	callq  40f27 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41112:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41119:	e9 9c 00 00 00       	jmpq   411ba <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4111e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41121:	48 63 d0             	movslq %eax,%rdx
   41124:	48 89 d0             	mov    %rdx,%rax
   41127:	48 c1 e0 04          	shl    $0x4,%rax
   4112b:	48 29 d0             	sub    %rdx,%rax
   4112e:	48 c1 e0 04          	shl    $0x4,%rax
   41132:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   41138:	8b 00                	mov    (%rax),%eax
   4113a:	85 c0                	test   %eax,%eax
   4113c:	74 78                	je     411b6 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4113e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41141:	48 63 d0             	movslq %eax,%rdx
   41144:	48 89 d0             	mov    %rdx,%rax
   41147:	48 c1 e0 04          	shl    $0x4,%rax
   4114b:	48 29 d0             	sub    %rdx,%rax
   4114e:	48 c1 e0 04          	shl    $0x4,%rax
   41152:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   41158:	48 8b 10             	mov    (%rax),%rdx
   4115b:	48 8b 05 9e 2e 01 00 	mov    0x12e9e(%rip),%rax        # 54000 <kernel_pagetable>
   41162:	48 39 c2             	cmp    %rax,%rdx
   41165:	74 4f                	je     411b6 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41167:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4116a:	48 63 d0             	movslq %eax,%rdx
   4116d:	48 89 d0             	mov    %rdx,%rax
   41170:	48 c1 e0 04          	shl    $0x4,%rax
   41174:	48 29 d0             	sub    %rdx,%rax
   41177:	48 c1 e0 04          	shl    $0x4,%rax
   4117b:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   41181:	48 8b 00             	mov    (%rax),%rax
   41184:	48 89 c7             	mov    %rax,%rdi
   41187:	e8 4e fc ff ff       	callq  40dda <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4118c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4118f:	48 63 d0             	movslq %eax,%rdx
   41192:	48 89 d0             	mov    %rdx,%rax
   41195:	48 c1 e0 04          	shl    $0x4,%rax
   41199:	48 29 d0             	sub    %rdx,%rax
   4119c:	48 c1 e0 04          	shl    $0x4,%rax
   411a0:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   411a6:	48 8b 00             	mov    (%rax),%rax
   411a9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411ac:	89 d6                	mov    %edx,%esi
   411ae:	48 89 c7             	mov    %rax,%rdi
   411b1:	e8 71 fd ff ff       	callq  40f27 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   411b6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411ba:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   411be:	0f 8e 5a ff ff ff    	jle    4111e <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411c4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   411cb:	eb 67                	jmp    41234 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   411cd:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411d0:	48 98                	cltq   
   411d2:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   411d9:	00 
   411da:	84 c0                	test   %al,%al
   411dc:	7e 52                	jle    41230 <check_virtual_memory+0x167>
   411de:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411e1:	48 98                	cltq   
   411e3:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   411ea:	00 
   411eb:	84 c0                	test   %al,%al
   411ed:	78 41                	js     41230 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   411ef:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411f2:	48 98                	cltq   
   411f4:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   411fb:	00 
   411fc:	0f be c0             	movsbl %al,%eax
   411ff:	48 63 d0             	movslq %eax,%rdx
   41202:	48 89 d0             	mov    %rdx,%rax
   41205:	48 c1 e0 04          	shl    $0x4,%rax
   41209:	48 29 d0             	sub    %rdx,%rax
   4120c:	48 c1 e0 04          	shl    $0x4,%rax
   41210:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   41216:	8b 00                	mov    (%rax),%eax
   41218:	85 c0                	test   %eax,%eax
   4121a:	75 14                	jne    41230 <check_virtual_memory+0x167>
   4121c:	ba 68 4a 04 00       	mov    $0x44a68,%edx
   41221:	be 36 02 00 00       	mov    $0x236,%esi
   41226:	bf 28 47 04 00       	mov    $0x44728,%edi
   4122b:	e8 c3 13 00 00       	callq  425f3 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41230:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41234:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4123b:	7e 90                	jle    411cd <check_virtual_memory+0x104>
        }
    }
}
   4123d:	90                   	nop
   4123e:	90                   	nop
   4123f:	c9                   	leaveq 
   41240:	c3                   	retq   

0000000000041241 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41241:	55                   	push   %rbp
   41242:	48 89 e5             	mov    %rsp,%rbp
   41245:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41249:	ba 98 4a 04 00       	mov    $0x44a98,%edx
   4124e:	be 00 0f 00 00       	mov    $0xf00,%esi
   41253:	bf 20 00 00 00       	mov    $0x20,%edi
   41258:	b8 00 00 00 00       	mov    $0x0,%eax
   4125d:	e8 3b 28 00 00       	callq  43a9d <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41262:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41269:	e9 f4 00 00 00       	jmpq   41362 <memshow_physical+0x121>
        if (pn % 64 == 0) {
   4126e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41271:	83 e0 3f             	and    $0x3f,%eax
   41274:	85 c0                	test   %eax,%eax
   41276:	75 3e                	jne    412b6 <memshow_physical+0x75>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41278:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4127b:	c1 e0 0c             	shl    $0xc,%eax
   4127e:	89 c2                	mov    %eax,%edx
   41280:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41283:	8d 48 3f             	lea    0x3f(%rax),%ecx
   41286:	85 c0                	test   %eax,%eax
   41288:	0f 48 c1             	cmovs  %ecx,%eax
   4128b:	c1 f8 06             	sar    $0x6,%eax
   4128e:	8d 48 01             	lea    0x1(%rax),%ecx
   41291:	89 c8                	mov    %ecx,%eax
   41293:	c1 e0 02             	shl    $0x2,%eax
   41296:	01 c8                	add    %ecx,%eax
   41298:	c1 e0 04             	shl    $0x4,%eax
   4129b:	83 c0 03             	add    $0x3,%eax
   4129e:	89 d1                	mov    %edx,%ecx
   412a0:	ba a8 4a 04 00       	mov    $0x44aa8,%edx
   412a5:	be 00 0f 00 00       	mov    $0xf00,%esi
   412aa:	89 c7                	mov    %eax,%edi
   412ac:	b8 00 00 00 00       	mov    $0x0,%eax
   412b1:	e8 e7 27 00 00       	callq  43a9d <console_printf>
        }

        int owner = pageinfo[pn].owner;
   412b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412b9:	48 98                	cltq   
   412bb:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   412c2:	00 
   412c3:	0f be c0             	movsbl %al,%eax
   412c6:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   412c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412cc:	48 98                	cltq   
   412ce:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   412d5:	00 
   412d6:	84 c0                	test   %al,%al
   412d8:	75 07                	jne    412e1 <memshow_physical+0xa0>
            owner = PO_FREE;
   412da:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   412e1:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412e4:	83 c0 02             	add    $0x2,%eax
   412e7:	48 98                	cltq   
   412e9:	0f b7 84 00 c0 46 04 	movzwl 0x446c0(%rax,%rax,1),%eax
   412f0:	00 
   412f1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   412f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412f8:	48 98                	cltq   
   412fa:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   41301:	00 
   41302:	3c 01                	cmp    $0x1,%al
   41304:	7e 1a                	jle    41320 <memshow_physical+0xdf>
   41306:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4130b:	48 c1 e8 0c          	shr    $0xc,%rax
   4130f:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41312:	74 0c                	je     41320 <memshow_physical+0xdf>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41314:	b8 53 00 00 00       	mov    $0x53,%eax
   41319:	80 cc 0f             	or     $0xf,%ah
   4131c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41320:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41323:	8d 50 3f             	lea    0x3f(%rax),%edx
   41326:	85 c0                	test   %eax,%eax
   41328:	0f 48 c2             	cmovs  %edx,%eax
   4132b:	c1 f8 06             	sar    $0x6,%eax
   4132e:	8d 50 01             	lea    0x1(%rax),%edx
   41331:	89 d0                	mov    %edx,%eax
   41333:	c1 e0 02             	shl    $0x2,%eax
   41336:	01 d0                	add    %edx,%eax
   41338:	c1 e0 04             	shl    $0x4,%eax
   4133b:	89 c1                	mov    %eax,%ecx
   4133d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41340:	99                   	cltd   
   41341:	c1 ea 1a             	shr    $0x1a,%edx
   41344:	01 d0                	add    %edx,%eax
   41346:	83 e0 3f             	and    $0x3f,%eax
   41349:	29 d0                	sub    %edx,%eax
   4134b:	83 c0 0c             	add    $0xc,%eax
   4134e:	01 c8                	add    %ecx,%eax
   41350:	48 98                	cltq   
   41352:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41356:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   4135d:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4135e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41362:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41369:	0f 8e ff fe ff ff    	jle    4126e <memshow_physical+0x2d>
    }
}
   4136f:	90                   	nop
   41370:	90                   	nop
   41371:	c9                   	leaveq 
   41372:	c3                   	retq   

0000000000041373 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41373:	55                   	push   %rbp
   41374:	48 89 e5             	mov    %rsp,%rbp
   41377:	48 83 ec 40          	sub    $0x40,%rsp
   4137b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4137f:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41383:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41387:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4138d:	48 89 c2             	mov    %rax,%rdx
   41390:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41394:	48 39 c2             	cmp    %rax,%rdx
   41397:	74 14                	je     413ad <memshow_virtual+0x3a>
   41399:	ba b0 4a 04 00       	mov    $0x44ab0,%edx
   4139e:	be 67 02 00 00       	mov    $0x267,%esi
   413a3:	bf 28 47 04 00       	mov    $0x44728,%edi
   413a8:	e8 46 12 00 00       	callq  425f3 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   413ad:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   413b1:	48 89 c1             	mov    %rax,%rcx
   413b4:	ba dd 4a 04 00       	mov    $0x44add,%edx
   413b9:	be 00 0f 00 00       	mov    $0xf00,%esi
   413be:	bf 3a 03 00 00       	mov    $0x33a,%edi
   413c3:	b8 00 00 00 00       	mov    $0x0,%eax
   413c8:	e8 d0 26 00 00       	callq  43a9d <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   413cd:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   413d4:	00 
   413d5:	e9 80 01 00 00       	jmpq   4155a <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   413da:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   413de:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   413e2:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   413e6:	48 89 ce             	mov    %rcx,%rsi
   413e9:	48 89 c7             	mov    %rax,%rdi
   413ec:	e8 c4 18 00 00       	callq  42cb5 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   413f1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413f4:	85 c0                	test   %eax,%eax
   413f6:	79 0b                	jns    41403 <memshow_virtual+0x90>
            color = ' ';
   413f8:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   413fe:	e9 d7 00 00 00       	jmpq   414da <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41403:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41407:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4140d:	76 14                	jbe    41423 <memshow_virtual+0xb0>
   4140f:	ba fa 4a 04 00       	mov    $0x44afa,%edx
   41414:	be 70 02 00 00       	mov    $0x270,%esi
   41419:	bf 28 47 04 00       	mov    $0x44728,%edi
   4141e:	e8 d0 11 00 00       	callq  425f3 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41423:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41426:	48 98                	cltq   
   41428:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   4142f:	00 
   41430:	0f be c0             	movsbl %al,%eax
   41433:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41436:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41439:	48 98                	cltq   
   4143b:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   41442:	00 
   41443:	84 c0                	test   %al,%al
   41445:	75 07                	jne    4144e <memshow_virtual+0xdb>
                owner = PO_FREE;
   41447:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   4144e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41451:	83 c0 02             	add    $0x2,%eax
   41454:	48 98                	cltq   
   41456:	0f b7 84 00 c0 46 04 	movzwl 0x446c0(%rax,%rax,1),%eax
   4145d:	00 
   4145e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41462:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41465:	48 98                	cltq   
   41467:	83 e0 04             	and    $0x4,%eax
   4146a:	48 85 c0             	test   %rax,%rax
   4146d:	74 27                	je     41496 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4146f:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41473:	c1 e0 04             	shl    $0x4,%eax
   41476:	66 25 00 f0          	and    $0xf000,%ax
   4147a:	89 c2                	mov    %eax,%edx
   4147c:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41480:	c1 f8 04             	sar    $0x4,%eax
   41483:	66 25 00 0f          	and    $0xf00,%ax
   41487:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41489:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4148d:	0f b6 c0             	movzbl %al,%eax
   41490:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41492:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41496:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41499:	48 98                	cltq   
   4149b:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   414a2:	00 
   414a3:	3c 01                	cmp    $0x1,%al
   414a5:	7e 33                	jle    414da <memshow_virtual+0x167>
   414a7:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   414ac:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414b0:	74 28                	je     414da <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   414b2:	b8 53 00 00 00       	mov    $0x53,%eax
   414b7:	89 c2                	mov    %eax,%edx
   414b9:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414bd:	66 25 00 f0          	and    $0xf000,%ax
   414c1:	09 d0                	or     %edx,%eax
   414c3:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   414c7:	8b 45 e0             	mov    -0x20(%rbp),%eax
   414ca:	48 98                	cltq   
   414cc:	83 e0 04             	and    $0x4,%eax
   414cf:	48 85 c0             	test   %rax,%rax
   414d2:	75 06                	jne    414da <memshow_virtual+0x167>
                    color = color | 0x0F00;
   414d4:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   414da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414de:	48 c1 e8 0c          	shr    $0xc,%rax
   414e2:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   414e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414e8:	83 e0 3f             	and    $0x3f,%eax
   414eb:	85 c0                	test   %eax,%eax
   414ed:	75 34                	jne    41523 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   414ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414f2:	c1 e8 06             	shr    $0x6,%eax
   414f5:	89 c2                	mov    %eax,%edx
   414f7:	89 d0                	mov    %edx,%eax
   414f9:	c1 e0 02             	shl    $0x2,%eax
   414fc:	01 d0                	add    %edx,%eax
   414fe:	c1 e0 04             	shl    $0x4,%eax
   41501:	05 73 03 00 00       	add    $0x373,%eax
   41506:	89 c7                	mov    %eax,%edi
   41508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4150c:	48 89 c1             	mov    %rax,%rcx
   4150f:	ba a8 4a 04 00       	mov    $0x44aa8,%edx
   41514:	be 00 0f 00 00       	mov    $0xf00,%esi
   41519:	b8 00 00 00 00       	mov    $0x0,%eax
   4151e:	e8 7a 25 00 00       	callq  43a9d <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41523:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41526:	c1 e8 06             	shr    $0x6,%eax
   41529:	89 c2                	mov    %eax,%edx
   4152b:	89 d0                	mov    %edx,%eax
   4152d:	c1 e0 02             	shl    $0x2,%eax
   41530:	01 d0                	add    %edx,%eax
   41532:	c1 e0 04             	shl    $0x4,%eax
   41535:	89 c2                	mov    %eax,%edx
   41537:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4153a:	83 e0 3f             	and    $0x3f,%eax
   4153d:	01 d0                	add    %edx,%eax
   4153f:	05 7c 03 00 00       	add    $0x37c,%eax
   41544:	89 c2                	mov    %eax,%edx
   41546:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4154a:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41551:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41552:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41559:	00 
   4155a:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41561:	00 
   41562:	0f 86 72 fe ff ff    	jbe    413da <memshow_virtual+0x67>
    }
}
   41568:	90                   	nop
   41569:	90                   	nop
   4156a:	c9                   	leaveq 
   4156b:	c3                   	retq   

000000000004156c <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4156c:	55                   	push   %rbp
   4156d:	48 89 e5             	mov    %rsp,%rbp
   41570:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41574:	8b 05 aa 0d 01 00    	mov    0x10daa(%rip),%eax        # 52324 <last_ticks.1>
   4157a:	85 c0                	test   %eax,%eax
   4157c:	74 13                	je     41591 <memshow_virtual_animate+0x25>
   4157e:	8b 05 9c 0d 01 00    	mov    0x10d9c(%rip),%eax        # 52320 <ticks>
   41584:	8b 15 9a 0d 01 00    	mov    0x10d9a(%rip),%edx        # 52324 <last_ticks.1>
   4158a:	29 d0                	sub    %edx,%eax
   4158c:	83 f8 31             	cmp    $0x31,%eax
   4158f:	76 2c                	jbe    415bd <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41591:	8b 05 89 0d 01 00    	mov    0x10d89(%rip),%eax        # 52320 <ticks>
   41597:	89 05 87 0d 01 00    	mov    %eax,0x10d87(%rip)        # 52324 <last_ticks.1>
        ++showing;
   4159d:	8b 05 61 4a 00 00    	mov    0x4a61(%rip),%eax        # 46004 <showing.0>
   415a3:	83 c0 01             	add    $0x1,%eax
   415a6:	89 05 58 4a 00 00    	mov    %eax,0x4a58(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   415ac:	eb 0f                	jmp    415bd <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   415ae:	8b 05 50 4a 00 00    	mov    0x4a50(%rip),%eax        # 46004 <showing.0>
   415b4:	83 c0 01             	add    $0x1,%eax
   415b7:	89 05 47 4a 00 00    	mov    %eax,0x4a47(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   415bd:	8b 05 41 4a 00 00    	mov    0x4a41(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   415c3:	83 f8 20             	cmp    $0x20,%eax
   415c6:	7f 2e                	jg     415f6 <memshow_virtual_animate+0x8a>
   415c8:	8b 05 36 4a 00 00    	mov    0x4a36(%rip),%eax        # 46004 <showing.0>
   415ce:	99                   	cltd   
   415cf:	c1 ea 1c             	shr    $0x1c,%edx
   415d2:	01 d0                	add    %edx,%eax
   415d4:	83 e0 0f             	and    $0xf,%eax
   415d7:	29 d0                	sub    %edx,%eax
   415d9:	48 63 d0             	movslq %eax,%rdx
   415dc:	48 89 d0             	mov    %rdx,%rax
   415df:	48 c1 e0 04          	shl    $0x4,%rax
   415e3:	48 29 d0             	sub    %rdx,%rax
   415e6:	48 c1 e0 04          	shl    $0x4,%rax
   415ea:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   415f0:	8b 00                	mov    (%rax),%eax
   415f2:	85 c0                	test   %eax,%eax
   415f4:	74 b8                	je     415ae <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   415f6:	8b 05 08 4a 00 00    	mov    0x4a08(%rip),%eax        # 46004 <showing.0>
   415fc:	99                   	cltd   
   415fd:	c1 ea 1c             	shr    $0x1c,%edx
   41600:	01 d0                	add    %edx,%eax
   41602:	83 e0 0f             	and    $0xf,%eax
   41605:	29 d0                	sub    %edx,%eax
   41607:	89 05 f7 49 00 00    	mov    %eax,0x49f7(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   4160d:	8b 05 f1 49 00 00    	mov    0x49f1(%rip),%eax        # 46004 <showing.0>
   41613:	48 63 d0             	movslq %eax,%rdx
   41616:	48 89 d0             	mov    %rdx,%rax
   41619:	48 c1 e0 04          	shl    $0x4,%rax
   4161d:	48 29 d0             	sub    %rdx,%rax
   41620:	48 c1 e0 04          	shl    $0x4,%rax
   41624:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   4162a:	8b 00                	mov    (%rax),%eax
   4162c:	85 c0                	test   %eax,%eax
   4162e:	74 76                	je     416a6 <memshow_virtual_animate+0x13a>
   41630:	8b 05 ce 49 00 00    	mov    0x49ce(%rip),%eax        # 46004 <showing.0>
   41636:	48 63 d0             	movslq %eax,%rdx
   41639:	48 89 d0             	mov    %rdx,%rax
   4163c:	48 c1 e0 04          	shl    $0x4,%rax
   41640:	48 29 d0             	sub    %rdx,%rax
   41643:	48 c1 e0 04          	shl    $0x4,%rax
   41647:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   4164d:	0f b6 00             	movzbl (%rax),%eax
   41650:	84 c0                	test   %al,%al
   41652:	74 52                	je     416a6 <memshow_virtual_animate+0x13a>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41654:	8b 15 aa 49 00 00    	mov    0x49aa(%rip),%edx        # 46004 <showing.0>
   4165a:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4165e:	89 d1                	mov    %edx,%ecx
   41660:	ba 14 4b 04 00       	mov    $0x44b14,%edx
   41665:	be 04 00 00 00       	mov    $0x4,%esi
   4166a:	48 89 c7             	mov    %rax,%rdi
   4166d:	b8 00 00 00 00       	mov    $0x0,%eax
   41672:	e8 a4 24 00 00       	callq  43b1b <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41677:	8b 05 87 49 00 00    	mov    0x4987(%rip),%eax        # 46004 <showing.0>
   4167d:	48 63 d0             	movslq %eax,%rdx
   41680:	48 89 d0             	mov    %rdx,%rax
   41683:	48 c1 e0 04          	shl    $0x4,%rax
   41687:	48 29 d0             	sub    %rdx,%rax
   4168a:	48 c1 e0 04          	shl    $0x4,%rax
   4168e:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   41694:	48 8b 00             	mov    (%rax),%rax
   41697:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4169b:	48 89 d6             	mov    %rdx,%rsi
   4169e:	48 89 c7             	mov    %rax,%rdi
   416a1:	e8 cd fc ff ff       	callq  41373 <memshow_virtual>
    }
}
   416a6:	90                   	nop
   416a7:	c9                   	leaveq 
   416a8:	c3                   	retq   

00000000000416a9 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   416a9:	55                   	push   %rbp
   416aa:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   416ad:	e8 53 01 00 00       	callq  41805 <segments_init>
    interrupt_init();
   416b2:	e8 d4 03 00 00       	callq  41a8b <interrupt_init>
    virtual_memory_init();
   416b7:	e8 f2 0f 00 00       	callq  426ae <virtual_memory_init>
}
   416bc:	90                   	nop
   416bd:	5d                   	pop    %rbp
   416be:	c3                   	retq   

00000000000416bf <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   416bf:	55                   	push   %rbp
   416c0:	48 89 e5             	mov    %rsp,%rbp
   416c3:	48 83 ec 18          	sub    $0x18,%rsp
   416c7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   416cb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   416cf:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   416d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416d5:	48 98                	cltq   
   416d7:	48 c1 e0 2d          	shl    $0x2d,%rax
   416db:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   416df:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   416e6:	90 00 00 
   416e9:	48 09 c2             	or     %rax,%rdx
    *segment = type
   416ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416f0:	48 89 10             	mov    %rdx,(%rax)
}
   416f3:	90                   	nop
   416f4:	c9                   	leaveq 
   416f5:	c3                   	retq   

00000000000416f6 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   416f6:	55                   	push   %rbp
   416f7:	48 89 e5             	mov    %rsp,%rbp
   416fa:	48 83 ec 28          	sub    $0x28,%rsp
   416fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41702:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41706:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41709:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4170d:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41711:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41715:	48 c1 e0 10          	shl    $0x10,%rax
   41719:	48 89 c2             	mov    %rax,%rdx
   4171c:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41723:	00 00 00 
   41726:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41729:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4172d:	48 c1 e0 20          	shl    $0x20,%rax
   41731:	48 89 c1             	mov    %rax,%rcx
   41734:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4173b:	00 00 ff 
   4173e:	48 21 c8             	and    %rcx,%rax
   41741:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41744:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41748:	48 83 e8 01          	sub    $0x1,%rax
   4174c:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   4174f:	48 09 d0             	or     %rdx,%rax
        | type
   41752:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41756:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41759:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4175c:	48 98                	cltq   
   4175e:	48 c1 e0 2d          	shl    $0x2d,%rax
   41762:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41765:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4176c:	80 00 00 
   4176f:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41772:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41776:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41779:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4177d:	48 83 c0 08          	add    $0x8,%rax
   41781:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41785:	48 c1 ea 20          	shr    $0x20,%rdx
   41789:	48 89 10             	mov    %rdx,(%rax)
}
   4178c:	90                   	nop
   4178d:	c9                   	leaveq 
   4178e:	c3                   	retq   

000000000004178f <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4178f:	55                   	push   %rbp
   41790:	48 89 e5             	mov    %rsp,%rbp
   41793:	48 83 ec 20          	sub    $0x20,%rsp
   41797:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4179b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4179f:	89 55 ec             	mov    %edx,-0x14(%rbp)
   417a2:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   417a6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417aa:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   417ad:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   417b1:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   417b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   417b7:	48 98                	cltq   
   417b9:	48 c1 e0 2d          	shl    $0x2d,%rax
   417bd:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   417c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417c4:	48 c1 e0 20          	shl    $0x20,%rax
   417c8:	48 89 c1             	mov    %rax,%rcx
   417cb:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   417d2:	00 ff ff 
   417d5:	48 21 c8             	and    %rcx,%rax
   417d8:	48 09 c2             	or     %rax,%rdx
   417db:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   417e2:	80 00 00 
   417e5:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   417e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417ec:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   417ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417f3:	48 c1 e8 20          	shr    $0x20,%rax
   417f7:	48 89 c2             	mov    %rax,%rdx
   417fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417fe:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41802:	90                   	nop
   41803:	c9                   	leaveq 
   41804:	c3                   	retq   

0000000000041805 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41805:	55                   	push   %rbp
   41806:	48 89 e5             	mov    %rsp,%rbp
   41809:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4180d:	48 c7 05 28 0b 01 00 	movq   $0x0,0x10b28(%rip)        # 52340 <segments>
   41814:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41818:	ba 00 00 00 00       	mov    $0x0,%edx
   4181d:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41824:	08 20 00 
   41827:	48 89 c6             	mov    %rax,%rsi
   4182a:	bf 48 23 05 00       	mov    $0x52348,%edi
   4182f:	e8 8b fe ff ff       	callq  416bf <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41834:	ba 03 00 00 00       	mov    $0x3,%edx
   41839:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41840:	08 20 00 
   41843:	48 89 c6             	mov    %rax,%rsi
   41846:	bf 50 23 05 00       	mov    $0x52350,%edi
   4184b:	e8 6f fe ff ff       	callq  416bf <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41850:	ba 00 00 00 00       	mov    $0x0,%edx
   41855:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4185c:	02 00 00 
   4185f:	48 89 c6             	mov    %rax,%rsi
   41862:	bf 58 23 05 00       	mov    $0x52358,%edi
   41867:	e8 53 fe ff ff       	callq  416bf <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   4186c:	ba 03 00 00 00       	mov    $0x3,%edx
   41871:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41878:	02 00 00 
   4187b:	48 89 c6             	mov    %rax,%rsi
   4187e:	bf 60 23 05 00       	mov    $0x52360,%edi
   41883:	e8 37 fe ff ff       	callq  416bf <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41888:	b8 80 33 05 00       	mov    $0x53380,%eax
   4188d:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41893:	48 89 c1             	mov    %rax,%rcx
   41896:	ba 00 00 00 00       	mov    $0x0,%edx
   4189b:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   418a2:	09 00 00 
   418a5:	48 89 c6             	mov    %rax,%rsi
   418a8:	bf 68 23 05 00       	mov    $0x52368,%edi
   418ad:	e8 44 fe ff ff       	callq  416f6 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   418b2:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   418b8:	b8 40 23 05 00       	mov    $0x52340,%eax
   418bd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   418c1:	ba 60 00 00 00       	mov    $0x60,%edx
   418c6:	be 00 00 00 00       	mov    $0x0,%esi
   418cb:	bf 80 33 05 00       	mov    $0x53380,%edi
   418d0:	e8 93 19 00 00       	callq  43268 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   418d5:	48 c7 05 a4 1a 01 00 	movq   $0x80000,0x11aa4(%rip)        # 53384 <kernel_task_descriptor+0x4>
   418dc:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   418e0:	ba 00 10 00 00       	mov    $0x1000,%edx
   418e5:	be 00 00 00 00       	mov    $0x0,%esi
   418ea:	bf 80 23 05 00       	mov    $0x52380,%edi
   418ef:	e8 74 19 00 00       	callq  43268 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   418f4:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   418fb:	eb 30                	jmp    4192d <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   418fd:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41902:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41905:	48 c1 e0 04          	shl    $0x4,%rax
   41909:	48 05 80 23 05 00    	add    $0x52380,%rax
   4190f:	48 89 d1             	mov    %rdx,%rcx
   41912:	ba 00 00 00 00       	mov    $0x0,%edx
   41917:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4191e:	0e 00 00 
   41921:	48 89 c7             	mov    %rax,%rdi
   41924:	e8 66 fe ff ff       	callq  4178f <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41929:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4192d:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41934:	76 c7                	jbe    418fd <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41936:	b8 36 00 04 00       	mov    $0x40036,%eax
   4193b:	48 89 c1             	mov    %rax,%rcx
   4193e:	ba 00 00 00 00       	mov    $0x0,%edx
   41943:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4194a:	0e 00 00 
   4194d:	48 89 c6             	mov    %rax,%rsi
   41950:	bf 80 25 05 00       	mov    $0x52580,%edi
   41955:	e8 35 fe ff ff       	callq  4178f <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   4195a:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   4195f:	48 89 c1             	mov    %rax,%rcx
   41962:	ba 00 00 00 00       	mov    $0x0,%edx
   41967:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4196e:	0e 00 00 
   41971:	48 89 c6             	mov    %rax,%rsi
   41974:	bf 50 24 05 00       	mov    $0x52450,%edi
   41979:	e8 11 fe ff ff       	callq  4178f <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   4197e:	b8 32 00 04 00       	mov    $0x40032,%eax
   41983:	48 89 c1             	mov    %rax,%rcx
   41986:	ba 00 00 00 00       	mov    $0x0,%edx
   4198b:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41992:	0e 00 00 
   41995:	48 89 c6             	mov    %rax,%rsi
   41998:	bf 60 24 05 00       	mov    $0x52460,%edi
   4199d:	e8 ed fd ff ff       	callq  4178f <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   419a2:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   419a9:	eb 3e                	jmp    419e9 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   419ab:	8b 45 f8             	mov    -0x8(%rbp),%eax
   419ae:	83 e8 30             	sub    $0x30,%eax
   419b1:	89 c0                	mov    %eax,%eax
   419b3:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   419ba:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   419bb:	48 89 c2             	mov    %rax,%rdx
   419be:	8b 45 f8             	mov    -0x8(%rbp),%eax
   419c1:	48 c1 e0 04          	shl    $0x4,%rax
   419c5:	48 05 80 23 05 00    	add    $0x52380,%rax
   419cb:	48 89 d1             	mov    %rdx,%rcx
   419ce:	ba 03 00 00 00       	mov    $0x3,%edx
   419d3:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   419da:	0e 00 00 
   419dd:	48 89 c7             	mov    %rax,%rdi
   419e0:	e8 aa fd ff ff       	callq  4178f <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   419e5:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   419e9:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   419ed:	76 bc                	jbe    419ab <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   419ef:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   419f5:	b8 80 23 05 00       	mov    $0x52380,%eax
   419fa:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   419fe:	b8 28 00 00 00       	mov    $0x28,%eax
   41a03:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41a07:	0f 00 d8             	ltr    %ax
   41a0a:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41a0e:	0f 20 c0             	mov    %cr0,%rax
   41a11:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41a15:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41a19:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41a1c:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41a23:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41a26:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41a29:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a2c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41a30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41a34:	0f 22 c0             	mov    %rax,%cr0
}
   41a37:	90                   	nop
    lcr0(cr0);
}
   41a38:	90                   	nop
   41a39:	c9                   	leaveq 
   41a3a:	c3                   	retq   

0000000000041a3b <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41a3b:	55                   	push   %rbp
   41a3c:	48 89 e5             	mov    %rsp,%rbp
   41a3f:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41a43:	0f b7 05 96 19 01 00 	movzwl 0x11996(%rip),%eax        # 533e0 <interrupts_enabled>
   41a4a:	f7 d0                	not    %eax
   41a4c:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41a50:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a54:	0f b6 c0             	movzbl %al,%eax
   41a57:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41a5e:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a61:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41a65:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41a68:	ee                   	out    %al,(%dx)
}
   41a69:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41a6a:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a6e:	66 c1 e8 08          	shr    $0x8,%ax
   41a72:	0f b6 c0             	movzbl %al,%eax
   41a75:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41a7c:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a7f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41a83:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41a86:	ee                   	out    %al,(%dx)
}
   41a87:	90                   	nop
}
   41a88:	90                   	nop
   41a89:	c9                   	leaveq 
   41a8a:	c3                   	retq   

0000000000041a8b <interrupt_init>:

void interrupt_init(void) {
   41a8b:	55                   	push   %rbp
   41a8c:	48 89 e5             	mov    %rsp,%rbp
   41a8f:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41a93:	66 c7 05 44 19 01 00 	movw   $0x0,0x11944(%rip)        # 533e0 <interrupts_enabled>
   41a9a:	00 00 
    interrupt_mask();
   41a9c:	e8 9a ff ff ff       	callq  41a3b <interrupt_mask>
   41aa1:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41aa8:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aac:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41ab0:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41ab3:	ee                   	out    %al,(%dx)
}
   41ab4:	90                   	nop
   41ab5:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41abc:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ac0:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41ac4:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41ac7:	ee                   	out    %al,(%dx)
}
   41ac8:	90                   	nop
   41ac9:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41ad0:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ad4:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41ad8:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41adb:	ee                   	out    %al,(%dx)
}
   41adc:	90                   	nop
   41add:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41ae4:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ae8:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41aec:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41aef:	ee                   	out    %al,(%dx)
}
   41af0:	90                   	nop
   41af1:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41af8:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41afc:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41b00:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41b03:	ee                   	out    %al,(%dx)
}
   41b04:	90                   	nop
   41b05:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41b0c:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b10:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41b14:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41b17:	ee                   	out    %al,(%dx)
}
   41b18:	90                   	nop
   41b19:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41b20:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b24:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41b28:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41b2b:	ee                   	out    %al,(%dx)
}
   41b2c:	90                   	nop
   41b2d:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41b34:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b38:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41b3c:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41b3f:	ee                   	out    %al,(%dx)
}
   41b40:	90                   	nop
   41b41:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41b48:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b4c:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41b50:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41b53:	ee                   	out    %al,(%dx)
}
   41b54:	90                   	nop
   41b55:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41b5c:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b60:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b64:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b67:	ee                   	out    %al,(%dx)
}
   41b68:	90                   	nop
   41b69:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41b70:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b74:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b78:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b7b:	ee                   	out    %al,(%dx)
}
   41b7c:	90                   	nop
   41b7d:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41b84:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b88:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b8c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b8f:	ee                   	out    %al,(%dx)
}
   41b90:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41b91:	e8 a5 fe ff ff       	callq  41a3b <interrupt_mask>
}
   41b96:	90                   	nop
   41b97:	c9                   	leaveq 
   41b98:	c3                   	retq   

0000000000041b99 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b99:	55                   	push   %rbp
   41b9a:	48 89 e5             	mov    %rsp,%rbp
   41b9d:	48 83 ec 28          	sub    $0x28,%rsp
   41ba1:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41ba4:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41ba8:	0f 8e 9f 00 00 00    	jle    41c4d <timer_init+0xb4>
   41bae:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41bb5:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bb9:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41bbd:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41bc0:	ee                   	out    %al,(%dx)
}
   41bc1:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41bc2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41bc5:	89 c2                	mov    %eax,%edx
   41bc7:	c1 ea 1f             	shr    $0x1f,%edx
   41bca:	01 d0                	add    %edx,%eax
   41bcc:	d1 f8                	sar    %eax
   41bce:	05 de 34 12 00       	add    $0x1234de,%eax
   41bd3:	99                   	cltd   
   41bd4:	f7 7d dc             	idivl  -0x24(%rbp)
   41bd7:	89 c2                	mov    %eax,%edx
   41bd9:	89 d0                	mov    %edx,%eax
   41bdb:	c1 f8 1f             	sar    $0x1f,%eax
   41bde:	c1 e8 18             	shr    $0x18,%eax
   41be1:	89 c1                	mov    %eax,%ecx
   41be3:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41be6:	0f b6 c0             	movzbl %al,%eax
   41be9:	29 c8                	sub    %ecx,%eax
   41beb:	0f b6 c0             	movzbl %al,%eax
   41bee:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41bf5:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bf8:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41bfc:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41bff:	ee                   	out    %al,(%dx)
}
   41c00:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41c01:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c04:	89 c2                	mov    %eax,%edx
   41c06:	c1 ea 1f             	shr    $0x1f,%edx
   41c09:	01 d0                	add    %edx,%eax
   41c0b:	d1 f8                	sar    %eax
   41c0d:	05 de 34 12 00       	add    $0x1234de,%eax
   41c12:	99                   	cltd   
   41c13:	f7 7d dc             	idivl  -0x24(%rbp)
   41c16:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41c1c:	85 c0                	test   %eax,%eax
   41c1e:	0f 48 c2             	cmovs  %edx,%eax
   41c21:	c1 f8 08             	sar    $0x8,%eax
   41c24:	0f b6 c0             	movzbl %al,%eax
   41c27:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41c2e:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c31:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c35:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c38:	ee                   	out    %al,(%dx)
}
   41c39:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41c3a:	0f b7 05 9f 17 01 00 	movzwl 0x1179f(%rip),%eax        # 533e0 <interrupts_enabled>
   41c41:	83 c8 01             	or     $0x1,%eax
   41c44:	66 89 05 95 17 01 00 	mov    %ax,0x11795(%rip)        # 533e0 <interrupts_enabled>
   41c4b:	eb 11                	jmp    41c5e <timer_init+0xc5>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41c4d:	0f b7 05 8c 17 01 00 	movzwl 0x1178c(%rip),%eax        # 533e0 <interrupts_enabled>
   41c54:	83 e0 fe             	and    $0xfffffffe,%eax
   41c57:	66 89 05 82 17 01 00 	mov    %ax,0x11782(%rip)        # 533e0 <interrupts_enabled>
    }
    interrupt_mask();
   41c5e:	e8 d8 fd ff ff       	callq  41a3b <interrupt_mask>
}
   41c63:	90                   	nop
   41c64:	c9                   	leaveq 
   41c65:	c3                   	retq   

0000000000041c66 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41c66:	55                   	push   %rbp
   41c67:	48 89 e5             	mov    %rsp,%rbp
   41c6a:	48 83 ec 08          	sub    $0x8,%rsp
   41c6e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41c72:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41c77:	74 14                	je     41c8d <physical_memory_isreserved+0x27>
   41c79:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41c80:	00 
   41c81:	76 11                	jbe    41c94 <physical_memory_isreserved+0x2e>
   41c83:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41c8a:	00 
   41c8b:	77 07                	ja     41c94 <physical_memory_isreserved+0x2e>
   41c8d:	b8 01 00 00 00       	mov    $0x1,%eax
   41c92:	eb 05                	jmp    41c99 <physical_memory_isreserved+0x33>
   41c94:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c99:	c9                   	leaveq 
   41c9a:	c3                   	retq   

0000000000041c9b <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c9b:	55                   	push   %rbp
   41c9c:	48 89 e5             	mov    %rsp,%rbp
   41c9f:	48 83 ec 10          	sub    $0x10,%rsp
   41ca3:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41ca6:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41ca9:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41cac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41caf:	c1 e0 10             	shl    $0x10,%eax
   41cb2:	89 c2                	mov    %eax,%edx
   41cb4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41cb7:	c1 e0 0b             	shl    $0xb,%eax
   41cba:	09 c2                	or     %eax,%edx
   41cbc:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41cbf:	c1 e0 08             	shl    $0x8,%eax
   41cc2:	09 d0                	or     %edx,%eax
}
   41cc4:	c9                   	leaveq 
   41cc5:	c3                   	retq   

0000000000041cc6 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41cc6:	55                   	push   %rbp
   41cc7:	48 89 e5             	mov    %rsp,%rbp
   41cca:	48 83 ec 18          	sub    $0x18,%rsp
   41cce:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41cd1:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41cd4:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41cd7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41cda:	09 d0                	or     %edx,%eax
   41cdc:	0d 00 00 00 80       	or     $0x80000000,%eax
   41ce1:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41ce8:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41ceb:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cee:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cf1:	ef                   	out    %eax,(%dx)
}
   41cf2:	90                   	nop
   41cf3:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41cfa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cfd:	89 c2                	mov    %eax,%edx
   41cff:	ed                   	in     (%dx),%eax
   41d00:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41d03:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41d06:	c9                   	leaveq 
   41d07:	c3                   	retq   

0000000000041d08 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41d08:	55                   	push   %rbp
   41d09:	48 89 e5             	mov    %rsp,%rbp
   41d0c:	48 83 ec 28          	sub    $0x28,%rsp
   41d10:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41d13:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41d16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41d1d:	eb 73                	jmp    41d92 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41d1f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41d26:	eb 60                	jmp    41d88 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41d28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41d2f:	eb 4a                	jmp    41d7b <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41d31:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d34:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41d37:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d3a:	89 ce                	mov    %ecx,%esi
   41d3c:	89 c7                	mov    %eax,%edi
   41d3e:	e8 58 ff ff ff       	callq  41c9b <pci_make_configaddr>
   41d43:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41d46:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d49:	be 00 00 00 00       	mov    $0x0,%esi
   41d4e:	89 c7                	mov    %eax,%edi
   41d50:	e8 71 ff ff ff       	callq  41cc6 <pci_config_readl>
   41d55:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41d58:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41d5b:	c1 e0 10             	shl    $0x10,%eax
   41d5e:	0b 45 dc             	or     -0x24(%rbp),%eax
   41d61:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41d64:	75 05                	jne    41d6b <pci_find_device+0x63>
                    return configaddr;
   41d66:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d69:	eb 35                	jmp    41da0 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41d6b:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41d6f:	75 06                	jne    41d77 <pci_find_device+0x6f>
   41d71:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41d75:	74 0c                	je     41d83 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41d77:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41d7b:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41d7f:	75 b0                	jne    41d31 <pci_find_device+0x29>
   41d81:	eb 01                	jmp    41d84 <pci_find_device+0x7c>
                    break;
   41d83:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41d84:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d88:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41d8c:	75 9a                	jne    41d28 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41d8e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d92:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d99:	75 84                	jne    41d1f <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41d9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41da0:	c9                   	leaveq 
   41da1:	c3                   	retq   

0000000000041da2 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41da2:	55                   	push   %rbp
   41da3:	48 89 e5             	mov    %rsp,%rbp
   41da6:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41daa:	be 13 71 00 00       	mov    $0x7113,%esi
   41daf:	bf 86 80 00 00       	mov    $0x8086,%edi
   41db4:	e8 4f ff ff ff       	callq  41d08 <pci_find_device>
   41db9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41dbc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41dc0:	78 30                	js     41df2 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41dc2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41dc5:	be 40 00 00 00       	mov    $0x40,%esi
   41dca:	89 c7                	mov    %eax,%edi
   41dcc:	e8 f5 fe ff ff       	callq  41cc6 <pci_config_readl>
   41dd1:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41dd6:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41dd9:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ddc:	83 c0 04             	add    $0x4,%eax
   41ddf:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41de2:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41de8:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41dec:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41def:	66 ef                	out    %ax,(%dx)
}
   41df1:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41df2:	ba 20 4b 04 00       	mov    $0x44b20,%edx
   41df7:	be 00 c0 00 00       	mov    $0xc000,%esi
   41dfc:	bf 80 07 00 00       	mov    $0x780,%edi
   41e01:	b8 00 00 00 00       	mov    $0x0,%eax
   41e06:	e8 92 1c 00 00       	callq  43a9d <console_printf>
 spinloop: goto spinloop;
   41e0b:	eb fe                	jmp    41e0b <poweroff+0x69>

0000000000041e0d <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41e0d:	55                   	push   %rbp
   41e0e:	48 89 e5             	mov    %rsp,%rbp
   41e11:	48 83 ec 10          	sub    $0x10,%rsp
   41e15:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41e1c:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e20:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e24:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e27:	ee                   	out    %al,(%dx)
}
   41e28:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41e29:	eb fe                	jmp    41e29 <reboot+0x1c>

0000000000041e2b <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41e2b:	55                   	push   %rbp
   41e2c:	48 89 e5             	mov    %rsp,%rbp
   41e2f:	48 83 ec 10          	sub    $0x10,%rsp
   41e33:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e37:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41e3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e3e:	48 83 c0 18          	add    $0x18,%rax
   41e42:	ba c0 00 00 00       	mov    $0xc0,%edx
   41e47:	be 00 00 00 00       	mov    $0x0,%esi
   41e4c:	48 89 c7             	mov    %rax,%rdi
   41e4f:	e8 14 14 00 00       	callq  43268 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41e54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e58:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41e5f:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41e61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e65:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41e6c:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41e70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e74:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41e7b:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41e7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e83:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41e8a:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41e8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e90:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41e97:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41e9b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e9e:	83 e0 01             	and    $0x1,%eax
   41ea1:	85 c0                	test   %eax,%eax
   41ea3:	74 1c                	je     41ec1 <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41ea5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ea9:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41eb0:	80 cc 30             	or     $0x30,%ah
   41eb3:	48 89 c2             	mov    %rax,%rdx
   41eb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41eba:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41ec1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ec4:	83 e0 02             	and    $0x2,%eax
   41ec7:	85 c0                	test   %eax,%eax
   41ec9:	74 1c                	je     41ee7 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41ecb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ecf:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41ed6:	80 e4 fd             	and    $0xfd,%ah
   41ed9:	48 89 c2             	mov    %rax,%rdx
   41edc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ee0:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41ee7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41eeb:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41ef2:	90                   	nop
   41ef3:	c9                   	leaveq 
   41ef4:	c3                   	retq   

0000000000041ef5 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41ef5:	55                   	push   %rbp
   41ef6:	48 89 e5             	mov    %rsp,%rbp
   41ef9:	48 83 ec 28          	sub    $0x28,%rsp
   41efd:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41f00:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41f04:	78 09                	js     41f0f <console_show_cursor+0x1a>
   41f06:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41f0d:	7e 07                	jle    41f16 <console_show_cursor+0x21>
        cpos = 0;
   41f0f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41f16:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41f1d:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f21:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41f25:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41f28:	ee                   	out    %al,(%dx)
}
   41f29:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41f2a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f2d:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41f33:	85 c0                	test   %eax,%eax
   41f35:	0f 48 c2             	cmovs  %edx,%eax
   41f38:	c1 f8 08             	sar    $0x8,%eax
   41f3b:	0f b6 c0             	movzbl %al,%eax
   41f3e:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41f45:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f48:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41f4c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f4f:	ee                   	out    %al,(%dx)
}
   41f50:	90                   	nop
   41f51:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41f58:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f5c:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41f60:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f63:	ee                   	out    %al,(%dx)
}
   41f64:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41f65:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f68:	99                   	cltd   
   41f69:	c1 ea 18             	shr    $0x18,%edx
   41f6c:	01 d0                	add    %edx,%eax
   41f6e:	0f b6 c0             	movzbl %al,%eax
   41f71:	29 d0                	sub    %edx,%eax
   41f73:	0f b6 c0             	movzbl %al,%eax
   41f76:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41f7d:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f80:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f84:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f87:	ee                   	out    %al,(%dx)
}
   41f88:	90                   	nop
}
   41f89:	90                   	nop
   41f8a:	c9                   	leaveq 
   41f8b:	c3                   	retq   

0000000000041f8c <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41f8c:	55                   	push   %rbp
   41f8d:	48 89 e5             	mov    %rsp,%rbp
   41f90:	48 83 ec 20          	sub    $0x20,%rsp
   41f94:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f9b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f9e:	89 c2                	mov    %eax,%edx
   41fa0:	ec                   	in     (%dx),%al
   41fa1:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41fa4:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41fa8:	0f b6 c0             	movzbl %al,%eax
   41fab:	83 e0 01             	and    $0x1,%eax
   41fae:	85 c0                	test   %eax,%eax
   41fb0:	75 0a                	jne    41fbc <keyboard_readc+0x30>
        return -1;
   41fb2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41fb7:	e9 e7 01 00 00       	jmpq   421a3 <keyboard_readc+0x217>
   41fbc:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41fc3:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41fc6:	89 c2                	mov    %eax,%edx
   41fc8:	ec                   	in     (%dx),%al
   41fc9:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41fcc:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41fd0:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41fd3:	0f b6 05 08 14 01 00 	movzbl 0x11408(%rip),%eax        # 533e2 <last_escape.2>
   41fda:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41fdd:	c6 05 fe 13 01 00 00 	movb   $0x0,0x113fe(%rip)        # 533e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41fe4:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41fe8:	75 11                	jne    41ffb <keyboard_readc+0x6f>
        last_escape = 0x80;
   41fea:	c6 05 f1 13 01 00 80 	movb   $0x80,0x113f1(%rip)        # 533e2 <last_escape.2>
        return 0;
   41ff1:	b8 00 00 00 00       	mov    $0x0,%eax
   41ff6:	e9 a8 01 00 00       	jmpq   421a3 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41ffb:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fff:	84 c0                	test   %al,%al
   42001:	79 60                	jns    42063 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42003:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42007:	83 e0 7f             	and    $0x7f,%eax
   4200a:	89 c2                	mov    %eax,%edx
   4200c:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42010:	09 d0                	or     %edx,%eax
   42012:	48 98                	cltq   
   42014:	0f b6 80 40 4b 04 00 	movzbl 0x44b40(%rax),%eax
   4201b:	0f b6 c0             	movzbl %al,%eax
   4201e:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42021:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42028:	7e 2f                	jle    42059 <keyboard_readc+0xcd>
   4202a:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42031:	7f 26                	jg     42059 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42033:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42036:	2d fa 00 00 00       	sub    $0xfa,%eax
   4203b:	ba 01 00 00 00       	mov    $0x1,%edx
   42040:	89 c1                	mov    %eax,%ecx
   42042:	d3 e2                	shl    %cl,%edx
   42044:	89 d0                	mov    %edx,%eax
   42046:	f7 d0                	not    %eax
   42048:	89 c2                	mov    %eax,%edx
   4204a:	0f b6 05 92 13 01 00 	movzbl 0x11392(%rip),%eax        # 533e3 <modifiers.1>
   42051:	21 d0                	and    %edx,%eax
   42053:	88 05 8a 13 01 00    	mov    %al,0x1138a(%rip)        # 533e3 <modifiers.1>
        }
        return 0;
   42059:	b8 00 00 00 00       	mov    $0x0,%eax
   4205e:	e9 40 01 00 00       	jmpq   421a3 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   42063:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42067:	0a 45 fa             	or     -0x6(%rbp),%al
   4206a:	0f b6 c0             	movzbl %al,%eax
   4206d:	48 98                	cltq   
   4206f:	0f b6 80 40 4b 04 00 	movzbl 0x44b40(%rax),%eax
   42076:	0f b6 c0             	movzbl %al,%eax
   42079:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   4207c:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42080:	7e 57                	jle    420d9 <keyboard_readc+0x14d>
   42082:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42086:	7f 51                	jg     420d9 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   42088:	0f b6 05 54 13 01 00 	movzbl 0x11354(%rip),%eax        # 533e3 <modifiers.1>
   4208f:	0f b6 c0             	movzbl %al,%eax
   42092:	83 e0 02             	and    $0x2,%eax
   42095:	85 c0                	test   %eax,%eax
   42097:	74 09                	je     420a2 <keyboard_readc+0x116>
            ch -= 0x60;
   42099:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4209d:	e9 fd 00 00 00       	jmpq   4219f <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   420a2:	0f b6 05 3a 13 01 00 	movzbl 0x1133a(%rip),%eax        # 533e3 <modifiers.1>
   420a9:	0f b6 c0             	movzbl %al,%eax
   420ac:	83 e0 01             	and    $0x1,%eax
   420af:	85 c0                	test   %eax,%eax
   420b1:	0f 94 c2             	sete   %dl
   420b4:	0f b6 05 28 13 01 00 	movzbl 0x11328(%rip),%eax        # 533e3 <modifiers.1>
   420bb:	0f b6 c0             	movzbl %al,%eax
   420be:	83 e0 08             	and    $0x8,%eax
   420c1:	85 c0                	test   %eax,%eax
   420c3:	0f 94 c0             	sete   %al
   420c6:	31 d0                	xor    %edx,%eax
   420c8:	84 c0                	test   %al,%al
   420ca:	0f 84 cf 00 00 00    	je     4219f <keyboard_readc+0x213>
            ch -= 0x20;
   420d0:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   420d4:	e9 c6 00 00 00       	jmpq   4219f <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   420d9:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   420e0:	7e 30                	jle    42112 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   420e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420e5:	2d fa 00 00 00       	sub    $0xfa,%eax
   420ea:	ba 01 00 00 00       	mov    $0x1,%edx
   420ef:	89 c1                	mov    %eax,%ecx
   420f1:	d3 e2                	shl    %cl,%edx
   420f3:	89 d0                	mov    %edx,%eax
   420f5:	89 c2                	mov    %eax,%edx
   420f7:	0f b6 05 e5 12 01 00 	movzbl 0x112e5(%rip),%eax        # 533e3 <modifiers.1>
   420fe:	31 d0                	xor    %edx,%eax
   42100:	88 05 dd 12 01 00    	mov    %al,0x112dd(%rip)        # 533e3 <modifiers.1>
        ch = 0;
   42106:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4210d:	e9 8e 00 00 00       	jmpq   421a0 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42112:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42119:	7e 2d                	jle    42148 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4211b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4211e:	2d fa 00 00 00       	sub    $0xfa,%eax
   42123:	ba 01 00 00 00       	mov    $0x1,%edx
   42128:	89 c1                	mov    %eax,%ecx
   4212a:	d3 e2                	shl    %cl,%edx
   4212c:	89 d0                	mov    %edx,%eax
   4212e:	89 c2                	mov    %eax,%edx
   42130:	0f b6 05 ac 12 01 00 	movzbl 0x112ac(%rip),%eax        # 533e3 <modifiers.1>
   42137:	09 d0                	or     %edx,%eax
   42139:	88 05 a4 12 01 00    	mov    %al,0x112a4(%rip)        # 533e3 <modifiers.1>
        ch = 0;
   4213f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42146:	eb 58                	jmp    421a0 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42148:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4214c:	7e 31                	jle    4217f <keyboard_readc+0x1f3>
   4214e:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42155:	7f 28                	jg     4217f <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42157:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4215a:	8d 50 80             	lea    -0x80(%rax),%edx
   4215d:	0f b6 05 7f 12 01 00 	movzbl 0x1127f(%rip),%eax        # 533e3 <modifiers.1>
   42164:	0f b6 c0             	movzbl %al,%eax
   42167:	83 e0 03             	and    $0x3,%eax
   4216a:	48 98                	cltq   
   4216c:	48 63 d2             	movslq %edx,%rdx
   4216f:	0f b6 84 90 40 4c 04 	movzbl 0x44c40(%rax,%rdx,4),%eax
   42176:	00 
   42177:	0f b6 c0             	movzbl %al,%eax
   4217a:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4217d:	eb 21                	jmp    421a0 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4217f:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42183:	7f 1b                	jg     421a0 <keyboard_readc+0x214>
   42185:	0f b6 05 57 12 01 00 	movzbl 0x11257(%rip),%eax        # 533e3 <modifiers.1>
   4218c:	0f b6 c0             	movzbl %al,%eax
   4218f:	83 e0 02             	and    $0x2,%eax
   42192:	85 c0                	test   %eax,%eax
   42194:	74 0a                	je     421a0 <keyboard_readc+0x214>
        ch = 0;
   42196:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4219d:	eb 01                	jmp    421a0 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   4219f:	90                   	nop
    }

    return ch;
   421a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   421a3:	c9                   	leaveq 
   421a4:	c3                   	retq   

00000000000421a5 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   421a5:	55                   	push   %rbp
   421a6:	48 89 e5             	mov    %rsp,%rbp
   421a9:	48 83 ec 20          	sub    $0x20,%rsp
   421ad:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421b4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   421b7:	89 c2                	mov    %eax,%edx
   421b9:	ec                   	in     (%dx),%al
   421ba:	88 45 e3             	mov    %al,-0x1d(%rbp)
   421bd:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   421c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   421c7:	89 c2                	mov    %eax,%edx
   421c9:	ec                   	in     (%dx),%al
   421ca:	88 45 eb             	mov    %al,-0x15(%rbp)
   421cd:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   421d4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   421d7:	89 c2                	mov    %eax,%edx
   421d9:	ec                   	in     (%dx),%al
   421da:	88 45 f3             	mov    %al,-0xd(%rbp)
   421dd:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   421e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421e7:	89 c2                	mov    %eax,%edx
   421e9:	ec                   	in     (%dx),%al
   421ea:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   421ed:	90                   	nop
   421ee:	c9                   	leaveq 
   421ef:	c3                   	retq   

00000000000421f0 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   421f0:	55                   	push   %rbp
   421f1:	48 89 e5             	mov    %rsp,%rbp
   421f4:	48 83 ec 40          	sub    $0x40,%rsp
   421f8:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   421fc:	89 f0                	mov    %esi,%eax
   421fe:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42201:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42204:	8b 05 da 11 01 00    	mov    0x111da(%rip),%eax        # 533e4 <initialized.0>
   4220a:	85 c0                	test   %eax,%eax
   4220c:	75 1e                	jne    4222c <parallel_port_putc+0x3c>
   4220e:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42215:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42219:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4221d:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42220:	ee                   	out    %al,(%dx)
}
   42221:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42222:	c7 05 b8 11 01 00 01 	movl   $0x1,0x111b8(%rip)        # 533e4 <initialized.0>
   42229:	00 00 00 
    }

    for (int i = 0;
   4222c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42233:	eb 09                	jmp    4223e <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42235:	e8 6b ff ff ff       	callq  421a5 <delay>
         ++i) {
   4223a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   4223e:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42245:	7f 18                	jg     4225f <parallel_port_putc+0x6f>
   42247:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4224e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42251:	89 c2                	mov    %eax,%edx
   42253:	ec                   	in     (%dx),%al
   42254:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42257:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4225b:	84 c0                	test   %al,%al
   4225d:	79 d6                	jns    42235 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   4225f:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42263:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4226a:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4226d:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42271:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42274:	ee                   	out    %al,(%dx)
}
   42275:	90                   	nop
   42276:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4227d:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42281:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42285:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42288:	ee                   	out    %al,(%dx)
}
   42289:	90                   	nop
   4228a:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42291:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42295:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42299:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4229c:	ee                   	out    %al,(%dx)
}
   4229d:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4229e:	90                   	nop
   4229f:	c9                   	leaveq 
   422a0:	c3                   	retq   

00000000000422a1 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   422a1:	55                   	push   %rbp
   422a2:	48 89 e5             	mov    %rsp,%rbp
   422a5:	48 83 ec 20          	sub    $0x20,%rsp
   422a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   422ad:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   422b1:	48 c7 45 f8 f0 21 04 	movq   $0x421f0,-0x8(%rbp)
   422b8:	00 
    printer_vprintf(&p, 0, format, val);
   422b9:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   422bd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   422c1:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   422c5:	be 00 00 00 00       	mov    $0x0,%esi
   422ca:	48 89 c7             	mov    %rax,%rdi
   422cd:	e8 a7 10 00 00       	callq  43379 <printer_vprintf>
}
   422d2:	90                   	nop
   422d3:	c9                   	leaveq 
   422d4:	c3                   	retq   

00000000000422d5 <log_printf>:

void log_printf(const char* format, ...) {
   422d5:	55                   	push   %rbp
   422d6:	48 89 e5             	mov    %rsp,%rbp
   422d9:	48 83 ec 60          	sub    $0x60,%rsp
   422dd:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   422e1:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   422e5:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   422e9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   422ed:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   422f1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   422f5:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   422fc:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42300:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42304:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42308:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4230c:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42310:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42314:	48 89 d6             	mov    %rdx,%rsi
   42317:	48 89 c7             	mov    %rax,%rdi
   4231a:	e8 82 ff ff ff       	callq  422a1 <log_vprintf>
    va_end(val);
}
   4231f:	90                   	nop
   42320:	c9                   	leaveq 
   42321:	c3                   	retq   

0000000000042322 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42322:	55                   	push   %rbp
   42323:	48 89 e5             	mov    %rsp,%rbp
   42326:	48 83 ec 40          	sub    $0x40,%rsp
   4232a:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4232d:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42330:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42334:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42338:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4233c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42340:	48 8b 0a             	mov    (%rdx),%rcx
   42343:	48 89 08             	mov    %rcx,(%rax)
   42346:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4234a:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4234e:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42352:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42356:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4235a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4235e:	48 89 d6             	mov    %rdx,%rsi
   42361:	48 89 c7             	mov    %rax,%rdi
   42364:	e8 38 ff ff ff       	callq  422a1 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42369:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4236d:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42371:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42374:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42377:	89 c7                	mov    %eax,%edi
   42379:	e8 da 16 00 00       	callq  43a58 <console_vprintf>
}
   4237e:	c9                   	leaveq 
   4237f:	c3                   	retq   

0000000000042380 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42380:	55                   	push   %rbp
   42381:	48 89 e5             	mov    %rsp,%rbp
   42384:	48 83 ec 60          	sub    $0x60,%rsp
   42388:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4238b:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4238e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42392:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42396:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4239a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4239e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   423a5:	48 8d 45 10          	lea    0x10(%rbp),%rax
   423a9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   423ad:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   423b1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   423b5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   423b9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   423bd:	8b 75 a8             	mov    -0x58(%rbp),%esi
   423c0:	8b 45 ac             	mov    -0x54(%rbp),%eax
   423c3:	89 c7                	mov    %eax,%edi
   423c5:	e8 58 ff ff ff       	callq  42322 <error_vprintf>
   423ca:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   423cd:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   423d0:	c9                   	leaveq 
   423d1:	c3                   	retq   

00000000000423d2 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   423d2:	55                   	push   %rbp
   423d3:	48 89 e5             	mov    %rsp,%rbp
   423d6:	53                   	push   %rbx
   423d7:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   423db:	e8 ac fb ff ff       	callq  41f8c <keyboard_readc>
   423e0:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   423e3:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   423e7:	74 1c                	je     42405 <check_keyboard+0x33>
   423e9:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   423ed:	74 16                	je     42405 <check_keyboard+0x33>
   423ef:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   423f3:	74 10                	je     42405 <check_keyboard+0x33>
   423f5:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   423f9:	74 0a                	je     42405 <check_keyboard+0x33>
   423fb:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   423ff:	0f 85 e9 00 00 00    	jne    424ee <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42405:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4240c:	00 
        memset(pt, 0, PAGESIZE * 3);
   4240d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42411:	ba 00 30 00 00       	mov    $0x3000,%edx
   42416:	be 00 00 00 00       	mov    $0x0,%esi
   4241b:	48 89 c7             	mov    %rax,%rdi
   4241e:	e8 45 0e 00 00       	callq  43268 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42423:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42427:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   4242e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42432:	48 05 00 10 00 00    	add    $0x1000,%rax
   42438:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   4243f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42443:	48 05 00 20 00 00    	add    $0x2000,%rax
   42449:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42450:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42454:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42458:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4245c:	0f 22 d8             	mov    %rax,%cr3
}
   4245f:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42460:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   42467:	48 c7 45 e8 98 4c 04 	movq   $0x44c98,-0x18(%rbp)
   4246e:	00 
        if (c == 'a') {
   4246f:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42473:	75 0a                	jne    4247f <check_keyboard+0xad>
            argument = "allocator";
   42475:	48 c7 45 e8 9f 4c 04 	movq   $0x44c9f,-0x18(%rbp)
   4247c:	00 
   4247d:	eb 2e                	jmp    424ad <check_keyboard+0xdb>
        } else if (c == 'c') {
   4247f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42483:	75 0a                	jne    4248f <check_keyboard+0xbd>
            argument = "alloctests";
   42485:	48 c7 45 e8 a9 4c 04 	movq   $0x44ca9,-0x18(%rbp)
   4248c:	00 
   4248d:	eb 1e                	jmp    424ad <check_keyboard+0xdb>
        } else if(c == 't'){
   4248f:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42493:	75 0a                	jne    4249f <check_keyboard+0xcd>
            argument = "test";
   42495:	48 c7 45 e8 b4 4c 04 	movq   $0x44cb4,-0x18(%rbp)
   4249c:	00 
   4249d:	eb 0e                	jmp    424ad <check_keyboard+0xdb>
        }
        else if(c == '2'){
   4249f:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   424a3:	75 08                	jne    424ad <check_keyboard+0xdb>
            argument = "test2";
   424a5:	48 c7 45 e8 b9 4c 04 	movq   $0x44cb9,-0x18(%rbp)
   424ac:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   424ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   424b1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   424b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   424ba:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   424be:	76 14                	jbe    424d4 <check_keyboard+0x102>
   424c0:	ba bf 4c 04 00       	mov    $0x44cbf,%edx
   424c5:	be 5c 02 00 00       	mov    $0x25c,%esi
   424ca:	bf db 4c 04 00       	mov    $0x44cdb,%edi
   424cf:	e8 1f 01 00 00       	callq  425f3 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   424d4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   424d8:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   424db:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   424df:	48 89 c3             	mov    %rax,%rbx
   424e2:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   424e7:	e9 14 db ff ff       	jmpq   40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   424ec:	eb 11                	jmp    424ff <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   424ee:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   424f2:	74 06                	je     424fa <check_keyboard+0x128>
   424f4:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   424f8:	75 05                	jne    424ff <check_keyboard+0x12d>
        poweroff();
   424fa:	e8 a3 f8 ff ff       	callq  41da2 <poweroff>
    }
    return c;
   424ff:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42502:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42506:	c9                   	leaveq 
   42507:	c3                   	retq   

0000000000042508 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42508:	55                   	push   %rbp
   42509:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   4250c:	e8 c1 fe ff ff       	callq  423d2 <check_keyboard>
   42511:	eb f9                	jmp    4250c <fail+0x4>

0000000000042513 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42513:	55                   	push   %rbp
   42514:	48 89 e5             	mov    %rsp,%rbp
   42517:	48 83 ec 60          	sub    $0x60,%rsp
   4251b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4251f:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42523:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42527:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4252b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4252f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42533:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4253a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4253e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42542:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42546:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4254a:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   4254f:	0f 84 80 00 00 00    	je     425d5 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42555:	ba e8 4c 04 00       	mov    $0x44ce8,%edx
   4255a:	be 00 c0 00 00       	mov    $0xc000,%esi
   4255f:	bf 30 07 00 00       	mov    $0x730,%edi
   42564:	b8 00 00 00 00       	mov    $0x0,%eax
   42569:	e8 12 fe ff ff       	callq  42380 <error_printf>
   4256e:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42571:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42575:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42579:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4257c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42581:	89 c7                	mov    %eax,%edi
   42583:	e8 9a fd ff ff       	callq  42322 <error_vprintf>
   42588:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4258b:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   4258e:	48 63 c1             	movslq %ecx,%rax
   42591:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42598:	48 c1 e8 20          	shr    $0x20,%rax
   4259c:	c1 f8 05             	sar    $0x5,%eax
   4259f:	89 ce                	mov    %ecx,%esi
   425a1:	c1 fe 1f             	sar    $0x1f,%esi
   425a4:	29 f0                	sub    %esi,%eax
   425a6:	89 c2                	mov    %eax,%edx
   425a8:	89 d0                	mov    %edx,%eax
   425aa:	c1 e0 02             	shl    $0x2,%eax
   425ad:	01 d0                	add    %edx,%eax
   425af:	c1 e0 04             	shl    $0x4,%eax
   425b2:	29 c1                	sub    %eax,%ecx
   425b4:	89 ca                	mov    %ecx,%edx
   425b6:	85 d2                	test   %edx,%edx
   425b8:	74 34                	je     425ee <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   425ba:	8b 45 cc             	mov    -0x34(%rbp),%eax
   425bd:	ba f0 4c 04 00       	mov    $0x44cf0,%edx
   425c2:	be 00 c0 00 00       	mov    $0xc000,%esi
   425c7:	89 c7                	mov    %eax,%edi
   425c9:	b8 00 00 00 00       	mov    $0x0,%eax
   425ce:	e8 ad fd ff ff       	callq  42380 <error_printf>
   425d3:	eb 19                	jmp    425ee <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   425d5:	ba f2 4c 04 00       	mov    $0x44cf2,%edx
   425da:	be 00 c0 00 00       	mov    $0xc000,%esi
   425df:	bf 30 07 00 00       	mov    $0x730,%edi
   425e4:	b8 00 00 00 00       	mov    $0x0,%eax
   425e9:	e8 92 fd ff ff       	callq  42380 <error_printf>
    }

    va_end(val);
    fail();
   425ee:	e8 15 ff ff ff       	callq  42508 <fail>

00000000000425f3 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   425f3:	55                   	push   %rbp
   425f4:	48 89 e5             	mov    %rsp,%rbp
   425f7:	48 83 ec 20          	sub    $0x20,%rsp
   425fb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425ff:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42602:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42606:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4260a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4260d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42611:	48 89 c6             	mov    %rax,%rsi
   42614:	bf f8 4c 04 00       	mov    $0x44cf8,%edi
   42619:	b8 00 00 00 00       	mov    $0x0,%eax
   4261e:	e8 f0 fe ff ff       	callq  42513 <kernel_panic>

0000000000042623 <default_exception>:
}

void default_exception(proc* p){
   42623:	55                   	push   %rbp
   42624:	48 89 e5             	mov    %rsp,%rbp
   42627:	48 83 ec 20          	sub    $0x20,%rsp
   4262b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   4262f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42633:	48 83 c0 18          	add    $0x18,%rax
   42637:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   4263b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4263f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42646:	48 89 c6             	mov    %rax,%rsi
   42649:	bf 16 4d 04 00       	mov    $0x44d16,%edi
   4264e:	b8 00 00 00 00       	mov    $0x0,%eax
   42653:	e8 bb fe ff ff       	callq  42513 <kernel_panic>

0000000000042658 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42658:	55                   	push   %rbp
   42659:	48 89 e5             	mov    %rsp,%rbp
   4265c:	48 83 ec 10          	sub    $0x10,%rsp
   42660:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42664:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42667:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4266b:	78 06                	js     42673 <pageindex+0x1b>
   4266d:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42671:	7e 14                	jle    42687 <pageindex+0x2f>
   42673:	ba 30 4d 04 00       	mov    $0x44d30,%edx
   42678:	be 1e 00 00 00       	mov    $0x1e,%esi
   4267d:	bf 49 4d 04 00       	mov    $0x44d49,%edi
   42682:	e8 6c ff ff ff       	callq  425f3 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42687:	b8 03 00 00 00       	mov    $0x3,%eax
   4268c:	2b 45 f4             	sub    -0xc(%rbp),%eax
   4268f:	89 c2                	mov    %eax,%edx
   42691:	89 d0                	mov    %edx,%eax
   42693:	c1 e0 03             	shl    $0x3,%eax
   42696:	01 d0                	add    %edx,%eax
   42698:	83 c0 0c             	add    $0xc,%eax
   4269b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4269f:	89 c1                	mov    %eax,%ecx
   426a1:	48 d3 ea             	shr    %cl,%rdx
   426a4:	48 89 d0             	mov    %rdx,%rax
   426a7:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   426ac:	c9                   	leaveq 
   426ad:	c3                   	retq   

00000000000426ae <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   426ae:	55                   	push   %rbp
   426af:	48 89 e5             	mov    %rsp,%rbp
   426b2:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   426b6:	48 c7 05 3f 19 01 00 	movq   $0x55000,0x1193f(%rip)        # 54000 <kernel_pagetable>
   426bd:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   426c1:	ba 00 50 00 00       	mov    $0x5000,%edx
   426c6:	be 00 00 00 00       	mov    $0x0,%esi
   426cb:	bf 00 50 05 00       	mov    $0x55000,%edi
   426d0:	e8 93 0b 00 00       	callq  43268 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   426d5:	b8 00 60 05 00       	mov    $0x56000,%eax
   426da:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   426de:	48 89 05 1b 29 01 00 	mov    %rax,0x1291b(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   426e5:	b8 00 70 05 00       	mov    $0x57000,%eax
   426ea:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   426ee:	48 89 05 0b 39 01 00 	mov    %rax,0x1390b(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   426f5:	b8 00 80 05 00       	mov    $0x58000,%eax
   426fa:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   426fe:	48 89 05 fb 48 01 00 	mov    %rax,0x148fb(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42705:	b8 00 90 05 00       	mov    $0x59000,%eax
   4270a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4270e:	48 89 05 f3 48 01 00 	mov    %rax,0x148f3(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42715:	48 8b 05 e4 18 01 00 	mov    0x118e4(%rip),%rax        # 54000 <kernel_pagetable>
   4271c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42722:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42727:	ba 00 00 00 00       	mov    $0x0,%edx
   4272c:	be 00 00 00 00       	mov    $0x0,%esi
   42731:	48 89 c7             	mov    %rax,%rdi
   42734:	e8 b9 01 00 00       	callq  428f2 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42739:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42740:	00 
   42741:	eb 62                	jmp    427a5 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42743:	48 8b 0d b6 18 01 00 	mov    0x118b6(%rip),%rcx        # 54000 <kernel_pagetable>
   4274a:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4274e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42752:	48 89 ce             	mov    %rcx,%rsi
   42755:	48 89 c7             	mov    %rax,%rdi
   42758:	e8 58 05 00 00       	callq  42cb5 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   4275d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42761:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42765:	74 14                	je     4277b <virtual_memory_init+0xcd>
   42767:	ba 52 4d 04 00       	mov    $0x44d52,%edx
   4276c:	be 2d 00 00 00       	mov    $0x2d,%esi
   42771:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   42776:	e8 78 fe ff ff       	callq  425f3 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   4277b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4277e:	48 98                	cltq   
   42780:	83 e0 03             	and    $0x3,%eax
   42783:	48 83 f8 03          	cmp    $0x3,%rax
   42787:	74 14                	je     4279d <virtual_memory_init+0xef>
   42789:	ba 68 4d 04 00       	mov    $0x44d68,%edx
   4278e:	be 2e 00 00 00       	mov    $0x2e,%esi
   42793:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   42798:	e8 56 fe ff ff       	callq  425f3 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4279d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   427a4:	00 
   427a5:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   427ac:	00 
   427ad:	76 94                	jbe    42743 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   427af:	48 8b 05 4a 18 01 00 	mov    0x1184a(%rip),%rax        # 54000 <kernel_pagetable>
   427b6:	48 89 c7             	mov    %rax,%rdi
   427b9:	e8 03 00 00 00       	callq  427c1 <set_pagetable>
}
   427be:	90                   	nop
   427bf:	c9                   	leaveq 
   427c0:	c3                   	retq   

00000000000427c1 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   427c1:	55                   	push   %rbp
   427c2:	48 89 e5             	mov    %rsp,%rbp
   427c5:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   427c9:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   427cd:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427d1:	25 ff 0f 00 00       	and    $0xfff,%eax
   427d6:	48 85 c0             	test   %rax,%rax
   427d9:	74 14                	je     427ef <set_pagetable+0x2e>
   427db:	ba 95 4d 04 00       	mov    $0x44d95,%edx
   427e0:	be 3d 00 00 00       	mov    $0x3d,%esi
   427e5:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   427ea:	e8 04 fe ff ff       	callq  425f3 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   427ef:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   427f4:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   427f8:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   427fc:	48 89 ce             	mov    %rcx,%rsi
   427ff:	48 89 c7             	mov    %rax,%rdi
   42802:	e8 ae 04 00 00       	callq  42cb5 <virtual_memory_lookup>
   42807:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4280b:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42810:	48 39 d0             	cmp    %rdx,%rax
   42813:	74 14                	je     42829 <set_pagetable+0x68>
   42815:	ba b0 4d 04 00       	mov    $0x44db0,%edx
   4281a:	be 3f 00 00 00       	mov    $0x3f,%esi
   4281f:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   42824:	e8 ca fd ff ff       	callq  425f3 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42829:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   4282d:	48 8b 0d cc 17 01 00 	mov    0x117cc(%rip),%rcx        # 54000 <kernel_pagetable>
   42834:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42838:	48 89 ce             	mov    %rcx,%rsi
   4283b:	48 89 c7             	mov    %rax,%rdi
   4283e:	e8 72 04 00 00       	callq  42cb5 <virtual_memory_lookup>
   42843:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42847:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4284b:	48 39 c2             	cmp    %rax,%rdx
   4284e:	74 14                	je     42864 <set_pagetable+0xa3>
   42850:	ba 18 4e 04 00       	mov    $0x44e18,%edx
   42855:	be 41 00 00 00       	mov    $0x41,%esi
   4285a:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   4285f:	e8 8f fd ff ff       	callq  425f3 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42864:	48 8b 05 95 17 01 00 	mov    0x11795(%rip),%rax        # 54000 <kernel_pagetable>
   4286b:	48 89 c2             	mov    %rax,%rdx
   4286e:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42872:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42876:	48 89 ce             	mov    %rcx,%rsi
   42879:	48 89 c7             	mov    %rax,%rdi
   4287c:	e8 34 04 00 00       	callq  42cb5 <virtual_memory_lookup>
   42881:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42885:	48 8b 15 74 17 01 00 	mov    0x11774(%rip),%rdx        # 54000 <kernel_pagetable>
   4288c:	48 39 d0             	cmp    %rdx,%rax
   4288f:	74 14                	je     428a5 <set_pagetable+0xe4>
   42891:	ba 78 4e 04 00       	mov    $0x44e78,%edx
   42896:	be 43 00 00 00       	mov    $0x43,%esi
   4289b:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   428a0:	e8 4e fd ff ff       	callq  425f3 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   428a5:	ba f2 28 04 00       	mov    $0x428f2,%edx
   428aa:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   428ae:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   428b2:	48 89 ce             	mov    %rcx,%rsi
   428b5:	48 89 c7             	mov    %rax,%rdi
   428b8:	e8 f8 03 00 00       	callq  42cb5 <virtual_memory_lookup>
   428bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428c1:	ba f2 28 04 00       	mov    $0x428f2,%edx
   428c6:	48 39 d0             	cmp    %rdx,%rax
   428c9:	74 14                	je     428df <set_pagetable+0x11e>
   428cb:	ba e0 4e 04 00       	mov    $0x44ee0,%edx
   428d0:	be 45 00 00 00       	mov    $0x45,%esi
   428d5:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   428da:	e8 14 fd ff ff       	callq  425f3 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   428df:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   428e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   428e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   428eb:	0f 22 d8             	mov    %rax,%cr3
}
   428ee:	90                   	nop
}
   428ef:	90                   	nop
   428f0:	c9                   	leaveq 
   428f1:	c3                   	retq   

00000000000428f2 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   428f2:	55                   	push   %rbp
   428f3:	48 89 e5             	mov    %rsp,%rbp
   428f6:	53                   	push   %rbx
   428f7:	48 83 ec 58          	sub    $0x58,%rsp
   428fb:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   428ff:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42903:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42907:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   4290b:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4290f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42913:	25 ff 0f 00 00       	and    $0xfff,%eax
   42918:	48 85 c0             	test   %rax,%rax
   4291b:	74 14                	je     42931 <virtual_memory_map+0x3f>
   4291d:	ba 46 4f 04 00       	mov    $0x44f46,%edx
   42922:	be 66 00 00 00       	mov    $0x66,%esi
   42927:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   4292c:	e8 c2 fc ff ff       	callq  425f3 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42931:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42935:	25 ff 0f 00 00       	and    $0xfff,%eax
   4293a:	48 85 c0             	test   %rax,%rax
   4293d:	74 14                	je     42953 <virtual_memory_map+0x61>
   4293f:	ba 59 4f 04 00       	mov    $0x44f59,%edx
   42944:	be 67 00 00 00       	mov    $0x67,%esi
   42949:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   4294e:	e8 a0 fc ff ff       	callq  425f3 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42953:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42957:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4295b:	48 01 d0             	add    %rdx,%rax
   4295e:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   42962:	76 24                	jbe    42988 <virtual_memory_map+0x96>
   42964:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42968:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4296c:	48 01 d0             	add    %rdx,%rax
   4296f:	48 85 c0             	test   %rax,%rax
   42972:	74 14                	je     42988 <virtual_memory_map+0x96>
   42974:	ba 6c 4f 04 00       	mov    $0x44f6c,%edx
   42979:	be 68 00 00 00       	mov    $0x68,%esi
   4297e:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   42983:	e8 6b fc ff ff       	callq  425f3 <assert_fail>
    if (perm & PTE_P) {
   42988:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4298b:	48 98                	cltq   
   4298d:	83 e0 01             	and    $0x1,%eax
   42990:	48 85 c0             	test   %rax,%rax
   42993:	74 6e                	je     42a03 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42995:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42999:	25 ff 0f 00 00       	and    $0xfff,%eax
   4299e:	48 85 c0             	test   %rax,%rax
   429a1:	74 14                	je     429b7 <virtual_memory_map+0xc5>
   429a3:	ba 8a 4f 04 00       	mov    $0x44f8a,%edx
   429a8:	be 6a 00 00 00       	mov    $0x6a,%esi
   429ad:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   429b2:	e8 3c fc ff ff       	callq  425f3 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   429b7:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   429bb:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   429bf:	48 01 d0             	add    %rdx,%rax
   429c2:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   429c6:	76 14                	jbe    429dc <virtual_memory_map+0xea>
   429c8:	ba 9d 4f 04 00       	mov    $0x44f9d,%edx
   429cd:	be 6b 00 00 00       	mov    $0x6b,%esi
   429d2:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   429d7:	e8 17 fc ff ff       	callq  425f3 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   429dc:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   429e0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   429e4:	48 01 d0             	add    %rdx,%rax
   429e7:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   429ed:	76 14                	jbe    42a03 <virtual_memory_map+0x111>
   429ef:	ba ab 4f 04 00       	mov    $0x44fab,%edx
   429f4:	be 6c 00 00 00       	mov    $0x6c,%esi
   429f9:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   429fe:	e8 f0 fb ff ff       	callq  425f3 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42a03:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42a07:	78 09                	js     42a12 <virtual_memory_map+0x120>
   42a09:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42a10:	7e 14                	jle    42a26 <virtual_memory_map+0x134>
   42a12:	ba c7 4f 04 00       	mov    $0x44fc7,%edx
   42a17:	be 6e 00 00 00       	mov    $0x6e,%esi
   42a1c:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   42a21:	e8 cd fb ff ff       	callq  425f3 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42a26:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a2a:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a2f:	48 85 c0             	test   %rax,%rax
   42a32:	74 14                	je     42a48 <virtual_memory_map+0x156>
   42a34:	ba e8 4f 04 00       	mov    $0x44fe8,%edx
   42a39:	be 6f 00 00 00       	mov    $0x6f,%esi
   42a3e:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   42a43:	e8 ab fb ff ff       	callq  425f3 <assert_fail>

    int last_index123 = -1;
   42a48:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42a4f:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42a56:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42a57:	e9 e1 00 00 00       	jmpq   42b3d <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42a5c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a60:	48 c1 e8 15          	shr    $0x15,%rax
   42a64:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42a67:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a6a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42a6d:	74 20                	je     42a8f <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42a6f:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42a72:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42a76:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a7a:	48 89 ce             	mov    %rcx,%rsi
   42a7d:	48 89 c7             	mov    %rax,%rdi
   42a80:	e8 ce 00 00 00       	callq  42b53 <lookup_l4pagetable>
   42a85:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42a89:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a8c:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42a8f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a92:	48 98                	cltq   
   42a94:	83 e0 01             	and    $0x1,%eax
   42a97:	48 85 c0             	test   %rax,%rax
   42a9a:	74 34                	je     42ad0 <virtual_memory_map+0x1de>
   42a9c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42aa1:	74 2d                	je     42ad0 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42aa3:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42aa6:	48 63 d8             	movslq %eax,%rbx
   42aa9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42aad:	be 03 00 00 00       	mov    $0x3,%esi
   42ab2:	48 89 c7             	mov    %rax,%rdi
   42ab5:	e8 9e fb ff ff       	callq  42658 <pageindex>
   42aba:	89 c2                	mov    %eax,%edx
   42abc:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42ac0:	48 89 d9             	mov    %rbx,%rcx
   42ac3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ac7:	48 63 d2             	movslq %edx,%rdx
   42aca:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42ace:	eb 55                	jmp    42b25 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42ad0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42ad5:	74 26                	je     42afd <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42ad7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42adb:	be 03 00 00 00       	mov    $0x3,%esi
   42ae0:	48 89 c7             	mov    %rax,%rdi
   42ae3:	e8 70 fb ff ff       	callq  42658 <pageindex>
   42ae8:	89 c2                	mov    %eax,%edx
   42aea:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42aed:	48 63 c8             	movslq %eax,%rcx
   42af0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42af4:	48 63 d2             	movslq %edx,%rdx
   42af7:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42afb:	eb 28                	jmp    42b25 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42afd:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b00:	48 98                	cltq   
   42b02:	83 e0 01             	and    $0x1,%eax
   42b05:	48 85 c0             	test   %rax,%rax
   42b08:	74 1b                	je     42b25 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b0a:	be 84 00 00 00       	mov    $0x84,%esi
   42b0f:	bf 10 50 04 00       	mov    $0x45010,%edi
   42b14:	b8 00 00 00 00       	mov    $0x0,%eax
   42b19:	e8 b7 f7 ff ff       	callq  422d5 <log_printf>
            return -1;
   42b1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42b23:	eb 28                	jmp    42b4d <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42b25:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42b2c:	00 
   42b2d:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42b34:	00 
   42b35:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42b3c:	00 
   42b3d:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42b42:	0f 85 14 ff ff ff    	jne    42a5c <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42b48:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42b4d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42b51:	c9                   	leaveq 
   42b52:	c3                   	retq   

0000000000042b53 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42b53:	55                   	push   %rbp
   42b54:	48 89 e5             	mov    %rsp,%rbp
   42b57:	48 83 ec 40          	sub    $0x40,%rsp
   42b5b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b5f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42b63:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42b66:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42b6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42b75:	e9 2b 01 00 00       	jmpq   42ca5 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42b7a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42b7d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b81:	89 d6                	mov    %edx,%esi
   42b83:	48 89 c7             	mov    %rax,%rdi
   42b86:	e8 cd fa ff ff       	callq  42658 <pageindex>
   42b8b:	89 c2                	mov    %eax,%edx
   42b8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b91:	48 63 d2             	movslq %edx,%rdx
   42b94:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42b98:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42b9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ba0:	83 e0 01             	and    $0x1,%eax
   42ba3:	48 85 c0             	test   %rax,%rax
   42ba6:	75 63                	jne    42c0b <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42ba8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42bab:	8d 48 02             	lea    0x2(%rax),%ecx
   42bae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bb2:	25 ff 0f 00 00       	and    $0xfff,%eax
   42bb7:	48 89 c2             	mov    %rax,%rdx
   42bba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bbe:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42bc4:	48 89 c6             	mov    %rax,%rsi
   42bc7:	bf 50 50 04 00       	mov    $0x45050,%edi
   42bcc:	b8 00 00 00 00       	mov    $0x0,%eax
   42bd1:	e8 ff f6 ff ff       	callq  422d5 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42bd6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bd9:	48 98                	cltq   
   42bdb:	83 e0 01             	and    $0x1,%eax
   42bde:	48 85 c0             	test   %rax,%rax
   42be1:	75 0a                	jne    42bed <lookup_l4pagetable+0x9a>
                return NULL;
   42be3:	b8 00 00 00 00       	mov    $0x0,%eax
   42be8:	e9 c6 00 00 00       	jmpq   42cb3 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42bed:	be a7 00 00 00       	mov    $0xa7,%esi
   42bf2:	bf b8 50 04 00       	mov    $0x450b8,%edi
   42bf7:	b8 00 00 00 00       	mov    $0x0,%eax
   42bfc:	e8 d4 f6 ff ff       	callq  422d5 <log_printf>
            return NULL;
   42c01:	b8 00 00 00 00       	mov    $0x0,%eax
   42c06:	e9 a8 00 00 00       	jmpq   42cb3 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42c0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c0f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c15:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42c1b:	76 14                	jbe    42c31 <lookup_l4pagetable+0xde>
   42c1d:	ba f8 50 04 00       	mov    $0x450f8,%edx
   42c22:	be ac 00 00 00       	mov    $0xac,%esi
   42c27:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   42c2c:	e8 c2 f9 ff ff       	callq  425f3 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42c31:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c34:	48 98                	cltq   
   42c36:	83 e0 02             	and    $0x2,%eax
   42c39:	48 85 c0             	test   %rax,%rax
   42c3c:	74 20                	je     42c5e <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42c3e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c42:	83 e0 02             	and    $0x2,%eax
   42c45:	48 85 c0             	test   %rax,%rax
   42c48:	75 14                	jne    42c5e <lookup_l4pagetable+0x10b>
   42c4a:	ba 18 51 04 00       	mov    $0x45118,%edx
   42c4f:	be ae 00 00 00       	mov    $0xae,%esi
   42c54:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   42c59:	e8 95 f9 ff ff       	callq  425f3 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42c5e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c61:	48 98                	cltq   
   42c63:	83 e0 04             	and    $0x4,%eax
   42c66:	48 85 c0             	test   %rax,%rax
   42c69:	74 20                	je     42c8b <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42c6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c6f:	83 e0 04             	and    $0x4,%eax
   42c72:	48 85 c0             	test   %rax,%rax
   42c75:	75 14                	jne    42c8b <lookup_l4pagetable+0x138>
   42c77:	ba 23 51 04 00       	mov    $0x45123,%edx
   42c7c:	be b1 00 00 00       	mov    $0xb1,%esi
   42c81:	bf 62 4d 04 00       	mov    $0x44d62,%edi
   42c86:	e8 68 f9 ff ff       	callq  425f3 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42c8b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42c92:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c93:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c97:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c9d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42ca1:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42ca5:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42ca9:	0f 8e cb fe ff ff    	jle    42b7a <lookup_l4pagetable+0x27>
    }
    return pt;
   42caf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42cb3:	c9                   	leaveq 
   42cb4:	c3                   	retq   

0000000000042cb5 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42cb5:	55                   	push   %rbp
   42cb6:	48 89 e5             	mov    %rsp,%rbp
   42cb9:	48 83 ec 50          	sub    $0x50,%rsp
   42cbd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42cc1:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42cc5:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42cc9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42ccd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42cd1:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42cd8:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42cd9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42ce0:	eb 41                	jmp    42d23 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42ce2:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42ce5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ce9:	89 d6                	mov    %edx,%esi
   42ceb:	48 89 c7             	mov    %rax,%rdi
   42cee:	e8 65 f9 ff ff       	callq  42658 <pageindex>
   42cf3:	89 c2                	mov    %eax,%edx
   42cf5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42cf9:	48 63 d2             	movslq %edx,%rdx
   42cfc:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42d00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d04:	83 e0 06             	and    $0x6,%eax
   42d07:	48 f7 d0             	not    %rax
   42d0a:	48 21 d0             	and    %rdx,%rax
   42d0d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42d11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d15:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42d1f:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42d23:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42d27:	7f 0c                	jg     42d35 <virtual_memory_lookup+0x80>
   42d29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d2d:	83 e0 01             	and    $0x1,%eax
   42d30:	48 85 c0             	test   %rax,%rax
   42d33:	75 ad                	jne    42ce2 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42d35:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42d3c:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42d43:	ff 
   42d44:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42d4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d4f:	83 e0 01             	and    $0x1,%eax
   42d52:	48 85 c0             	test   %rax,%rax
   42d55:	74 34                	je     42d8b <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42d57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d5b:	48 c1 e8 0c          	shr    $0xc,%rax
   42d5f:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42d62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d66:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d6c:	48 89 c2             	mov    %rax,%rdx
   42d6f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d73:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d78:	48 09 d0             	or     %rdx,%rax
   42d7b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42d7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d83:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d88:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42d8b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d8f:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d93:	48 89 10             	mov    %rdx,(%rax)
   42d96:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42d9a:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42d9e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42da2:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42da6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42daa:	c9                   	leaveq 
   42dab:	c3                   	retq   

0000000000042dac <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42dac:	55                   	push   %rbp
   42dad:	48 89 e5             	mov    %rsp,%rbp
   42db0:	48 83 ec 40          	sub    $0x40,%rsp
   42db4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42db8:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42dbb:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42dbf:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42dc6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42dca:	78 08                	js     42dd4 <program_load+0x28>
   42dcc:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42dcf:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42dd2:	7c 14                	jl     42de8 <program_load+0x3c>
   42dd4:	ba 30 51 04 00       	mov    $0x45130,%edx
   42dd9:	be 37 00 00 00       	mov    $0x37,%esi
   42dde:	bf 60 51 04 00       	mov    $0x45160,%edi
   42de3:	e8 0b f8 ff ff       	callq  425f3 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42de8:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42deb:	48 98                	cltq   
   42ded:	48 c1 e0 04          	shl    $0x4,%rax
   42df1:	48 05 20 60 04 00    	add    $0x46020,%rax
   42df7:	48 8b 00             	mov    (%rax),%rax
   42dfa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42dfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e02:	8b 00                	mov    (%rax),%eax
   42e04:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42e09:	74 14                	je     42e1f <program_load+0x73>
   42e0b:	ba 6b 51 04 00       	mov    $0x4516b,%edx
   42e10:	be 39 00 00 00       	mov    $0x39,%esi
   42e15:	bf 60 51 04 00       	mov    $0x45160,%edi
   42e1a:	e8 d4 f7 ff ff       	callq  425f3 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42e1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e23:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42e27:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e2b:	48 01 d0             	add    %rdx,%rax
   42e2e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e32:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42e39:	e9 b5 00 00 00       	jmpq   42ef3 <program_load+0x147>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42e3e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e41:	48 63 d0             	movslq %eax,%rdx
   42e44:	48 89 d0             	mov    %rdx,%rax
   42e47:	48 c1 e0 03          	shl    $0x3,%rax
   42e4b:	48 29 d0             	sub    %rdx,%rax
   42e4e:	48 c1 e0 03          	shl    $0x3,%rax
   42e52:	48 89 c2             	mov    %rax,%rdx
   42e55:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e59:	48 01 d0             	add    %rdx,%rax
   42e5c:	8b 00                	mov    (%rax),%eax
   42e5e:	83 f8 01             	cmp    $0x1,%eax
   42e61:	0f 85 88 00 00 00    	jne    42eef <program_load+0x143>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42e67:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e6a:	48 63 d0             	movslq %eax,%rdx
   42e6d:	48 89 d0             	mov    %rdx,%rax
   42e70:	48 c1 e0 03          	shl    $0x3,%rax
   42e74:	48 29 d0             	sub    %rdx,%rax
   42e77:	48 c1 e0 03          	shl    $0x3,%rax
   42e7b:	48 89 c2             	mov    %rax,%rdx
   42e7e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e82:	48 01 d0             	add    %rdx,%rax
   42e85:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42e89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e8d:	48 01 d0             	add    %rdx,%rax
   42e90:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if(i == eh->e_phnum-1)
   42e94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e98:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42e9c:	0f b7 c0             	movzwl %ax,%eax
   42e9f:	83 e8 01             	sub    $0x1,%eax
   42ea2:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42ea5:	75 0a                	jne    42eb1 <program_load+0x105>
                x = 1;
   42ea7:	c7 05 4f 71 01 00 01 	movl   $0x1,0x1714f(%rip)        # 5a000 <x>
   42eae:	00 00 00 
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42eb1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42eb4:	48 63 d0             	movslq %eax,%rdx
   42eb7:	48 89 d0             	mov    %rdx,%rax
   42eba:	48 c1 e0 03          	shl    $0x3,%rax
   42ebe:	48 29 d0             	sub    %rdx,%rax
   42ec1:	48 c1 e0 03          	shl    $0x3,%rax
   42ec5:	48 89 c2             	mov    %rax,%rdx
   42ec8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ecc:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42ed0:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42ed4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42ed8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42edc:	48 89 c7             	mov    %rax,%rdi
   42edf:	e8 3d 00 00 00       	callq  42f21 <program_load_segment>
   42ee4:	85 c0                	test   %eax,%eax
   42ee6:	79 07                	jns    42eef <program_load+0x143>
                return -1;
   42ee8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42eed:	eb 30                	jmp    42f1f <program_load+0x173>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42eef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42ef3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ef7:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42efb:	0f b7 c0             	movzwl %ax,%eax
   42efe:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42f01:	0f 8c 37 ff ff ff    	jl     42e3e <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42f07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f0b:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42f0f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f13:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42f1a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f1f:	c9                   	leaveq 
   42f20:	c3                   	retq   

0000000000042f21 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42f21:	55                   	push   %rbp
   42f22:	48 89 e5             	mov    %rsp,%rbp
   42f25:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
   42f2c:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
   42f30:	48 89 75 80          	mov    %rsi,-0x80(%rbp)
   42f34:	48 89 95 78 ff ff ff 	mov    %rdx,-0x88(%rbp)
   42f3b:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42f42:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42f46:	48 8b 40 10          	mov    0x10(%rax),%rax
   42f4a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42f4e:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42f52:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42f56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f5a:	48 01 d0             	add    %rdx,%rax
   42f5d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42f61:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42f65:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42f69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f6d:	48 01 d0             	add    %rdx,%rax
   42f70:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42f74:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42f7b:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f80:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42f84:	eb 7c                	jmp    43002 <program_load_segment+0xe1>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42f86:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f8a:	8b 00                	mov    (%rax),%eax
   42f8c:	89 c7                	mov    %eax,%edi
   42f8e:	e8 e1 0b 00 00       	callq  43b74 <palloc>
   42f93:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42f97:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42f9c:	74 2a                	je     42fc8 <program_load_segment+0xa7>
   42f9e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42fa2:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42fa9:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   42fad:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42fb1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42fb7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42fbc:	48 89 c7             	mov    %rax,%rdi
   42fbf:	e8 2e f9 ff ff       	callq  428f2 <virtual_memory_map>
   42fc4:	85 c0                	test   %eax,%eax
   42fc6:	79 32                	jns    42ffa <program_load_segment+0xd9>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42fc8:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42fcc:	8b 00                	mov    (%rax),%eax
   42fce:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42fd2:	49 89 d0             	mov    %rdx,%r8
   42fd5:	89 c1                	mov    %eax,%ecx
   42fd7:	ba 88 51 04 00       	mov    $0x45188,%edx
   42fdc:	be 00 c0 00 00       	mov    $0xc000,%esi
   42fe1:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42fe6:	b8 00 00 00 00       	mov    $0x0,%eax
   42feb:	e8 ad 0a 00 00       	callq  43a9d <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ff5:	e9 67 01 00 00       	jmpq   43161 <program_load_segment+0x240>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ffa:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43001:	00 
   43002:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43006:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4300a:	0f 82 76 ff ff ff    	jb     42f86 <program_load_segment+0x65>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43010:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43014:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4301b:	48 89 c7             	mov    %rax,%rdi
   4301e:	e8 9e f7 ff ff       	callq  427c1 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43023:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43027:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4302b:	48 89 c2             	mov    %rax,%rdx
   4302e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43032:	48 8b 8d 78 ff ff ff 	mov    -0x88(%rbp),%rcx
   43039:	48 89 ce             	mov    %rcx,%rsi
   4303c:	48 89 c7             	mov    %rax,%rdi
   4303f:	e8 bb 01 00 00       	callq  431ff <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43044:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43048:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4304c:	48 89 c2             	mov    %rax,%rdx
   4304f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43053:	be 00 00 00 00       	mov    $0x0,%esi
   43058:	48 89 c7             	mov    %rax,%rdi
   4305b:	e8 08 02 00 00       	callq  43268 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43060:	48 8b 05 99 0f 01 00 	mov    0x10f99(%rip),%rax        # 54000 <kernel_pagetable>
   43067:	48 89 c7             	mov    %rax,%rdi
   4306a:	e8 52 f7 ff ff       	callq  427c1 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   4306f:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   43073:	8b 40 04             	mov    0x4(%rax),%eax
   43076:	83 e0 02             	and    $0x2,%eax
   43079:	85 c0                	test   %eax,%eax
   4307b:	75 60                	jne    430dd <program_load_segment+0x1bc>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4307d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43081:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43085:	eb 4c                	jmp    430d3 <program_load_segment+0x1b2>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43087:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4308b:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   43092:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   43096:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4309a:	48 89 ce             	mov    %rcx,%rsi
   4309d:	48 89 c7             	mov    %rax,%rdi
   430a0:	e8 10 fc ff ff       	callq  42cb5 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   430a5:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   430a9:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430ad:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   430b4:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   430b8:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   430be:	b9 00 10 00 00       	mov    $0x1000,%ecx
   430c3:	48 89 c7             	mov    %rax,%rdi
   430c6:	e8 27 f8 ff ff       	callq  428f2 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430cb:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   430d2:	00 
   430d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430d7:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   430db:	72 aa                	jb     43087 <program_load_segment+0x166>
                    PTE_P | PTE_U);
        }
    }
    if (x == 1)
   430dd:	8b 05 1d 6f 01 00    	mov    0x16f1d(%rip),%eax        # 5a000 <x>
   430e3:	83 f8 01             	cmp    $0x1,%eax
   430e6:	75 74                	jne    4315c <program_load_segment+0x23b>
    {
        p->program_break = (uintptr_t) ROUNDUP((uint8_t*) end_mem, PAGESIZE);
   430e8:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   430ef:	00 
   430f0:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   430f4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430f8:	48 01 d0             	add    %rdx,%rax
   430fb:	48 83 e8 01          	sub    $0x1,%rax
   430ff:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   43103:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43107:	ba 00 00 00 00       	mov    $0x0,%edx
   4310c:	48 f7 75 d0          	divq   -0x30(%rbp)
   43110:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43114:	48 29 d0             	sub    %rdx,%rax
   43117:	48 89 c2             	mov    %rax,%rdx
   4311a:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4311e:	48 89 50 08          	mov    %rdx,0x8(%rax)
        p->original_break = (uintptr_t) ROUNDUP((uint8_t*) end_mem, PAGESIZE);
   43122:	48 c7 45 c0 00 10 00 	movq   $0x1000,-0x40(%rbp)
   43129:	00 
   4312a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4312e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43132:	48 01 d0             	add    %rdx,%rax
   43135:	48 83 e8 01          	sub    $0x1,%rax
   43139:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4313d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43141:	ba 00 00 00 00       	mov    $0x0,%edx
   43146:	48 f7 75 c0          	divq   -0x40(%rbp)
   4314a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4314e:	48 29 d0             	sub    %rdx,%rax
   43151:	48 89 c2             	mov    %rax,%rdx
   43154:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43158:	48 89 50 10          	mov    %rdx,0x10(%rax)
    }
    return 0;
   4315c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43161:	c9                   	leaveq 
   43162:	c3                   	retq   

0000000000043163 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43163:	48 89 f9             	mov    %rdi,%rcx
   43166:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43168:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
   4316f:	00 
   43170:	72 08                	jb     4317a <console_putc+0x17>
        cp->cursor = console;
   43172:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
   43179:	00 
    }
    if (c == '\n') {
   4317a:	40 80 fe 0a          	cmp    $0xa,%sil
   4317e:	74 16                	je     43196 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   43180:	48 8b 41 08          	mov    0x8(%rcx),%rax
   43184:	48 8d 50 02          	lea    0x2(%rax),%rdx
   43188:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   4318c:	40 0f b6 f6          	movzbl %sil,%esi
   43190:	09 fe                	or     %edi,%esi
   43192:	66 89 30             	mov    %si,(%rax)
    }
}
   43195:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
   43196:	4c 8b 41 08          	mov    0x8(%rcx),%r8
   4319a:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
   431a1:	4c 89 c6             	mov    %r8,%rsi
   431a4:	48 d1 fe             	sar    %rsi
   431a7:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   431ae:	66 66 66 
   431b1:	48 89 f0             	mov    %rsi,%rax
   431b4:	48 f7 ea             	imul   %rdx
   431b7:	48 c1 fa 05          	sar    $0x5,%rdx
   431bb:	49 c1 f8 3f          	sar    $0x3f,%r8
   431bf:	4c 29 c2             	sub    %r8,%rdx
   431c2:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   431c6:	48 c1 e2 04          	shl    $0x4,%rdx
   431ca:	89 f0                	mov    %esi,%eax
   431cc:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
   431ce:	83 cf 20             	or     $0x20,%edi
   431d1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   431d5:	48 8d 72 02          	lea    0x2(%rdx),%rsi
   431d9:	48 89 71 08          	mov    %rsi,0x8(%rcx)
   431dd:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
   431e0:	83 c0 01             	add    $0x1,%eax
   431e3:	83 f8 50             	cmp    $0x50,%eax
   431e6:	75 e9                	jne    431d1 <console_putc+0x6e>
   431e8:	c3                   	retq   

00000000000431e9 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   431e9:	48 8b 47 08          	mov    0x8(%rdi),%rax
   431ed:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   431f1:	73 0b                	jae    431fe <string_putc+0x15>
        *sp->s++ = c;
   431f3:	48 8d 50 01          	lea    0x1(%rax),%rdx
   431f7:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   431fb:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   431fe:	c3                   	retq   

00000000000431ff <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   431ff:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43202:	48 85 d2             	test   %rdx,%rdx
   43205:	74 17                	je     4321e <memcpy+0x1f>
   43207:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   4320c:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   43211:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43215:	48 83 c1 01          	add    $0x1,%rcx
   43219:	48 39 d1             	cmp    %rdx,%rcx
   4321c:	75 ee                	jne    4320c <memcpy+0xd>
}
   4321e:	c3                   	retq   

000000000004321f <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   4321f:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   43222:	48 39 fe             	cmp    %rdi,%rsi
   43225:	72 1d                	jb     43244 <memmove+0x25>
        while (n-- > 0) {
   43227:	b9 00 00 00 00       	mov    $0x0,%ecx
   4322c:	48 85 d2             	test   %rdx,%rdx
   4322f:	74 12                	je     43243 <memmove+0x24>
            *d++ = *s++;
   43231:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   43235:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   43239:	48 83 c1 01          	add    $0x1,%rcx
   4323d:	48 39 ca             	cmp    %rcx,%rdx
   43240:	75 ef                	jne    43231 <memmove+0x12>
}
   43242:	c3                   	retq   
   43243:	c3                   	retq   
    if (s < d && s + n > d) {
   43244:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   43248:	48 39 cf             	cmp    %rcx,%rdi
   4324b:	73 da                	jae    43227 <memmove+0x8>
        while (n-- > 0) {
   4324d:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   43251:	48 85 d2             	test   %rdx,%rdx
   43254:	74 ec                	je     43242 <memmove+0x23>
            *--d = *--s;
   43256:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   4325a:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   4325d:	48 83 e9 01          	sub    $0x1,%rcx
   43261:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   43265:	75 ef                	jne    43256 <memmove+0x37>
   43267:	c3                   	retq   

0000000000043268 <memset>:
void* memset(void* v, int c, size_t n) {
   43268:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4326b:	48 85 d2             	test   %rdx,%rdx
   4326e:	74 12                	je     43282 <memset+0x1a>
   43270:	48 01 fa             	add    %rdi,%rdx
   43273:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
   43276:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43279:	48 83 c1 01          	add    $0x1,%rcx
   4327d:	48 39 ca             	cmp    %rcx,%rdx
   43280:	75 f4                	jne    43276 <memset+0xe>
}
   43282:	c3                   	retq   

0000000000043283 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   43283:	80 3f 00             	cmpb   $0x0,(%rdi)
   43286:	74 10                	je     43298 <strlen+0x15>
   43288:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   4328d:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   43291:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   43295:	75 f6                	jne    4328d <strlen+0xa>
   43297:	c3                   	retq   
   43298:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4329d:	c3                   	retq   

000000000004329e <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
   4329e:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   432a1:	ba 00 00 00 00       	mov    $0x0,%edx
   432a6:	48 85 f6             	test   %rsi,%rsi
   432a9:	74 11                	je     432bc <strnlen+0x1e>
   432ab:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
   432af:	74 0c                	je     432bd <strnlen+0x1f>
        ++n;
   432b1:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   432b5:	48 39 d0             	cmp    %rdx,%rax
   432b8:	75 f1                	jne    432ab <strnlen+0xd>
   432ba:	eb 04                	jmp    432c0 <strnlen+0x22>
   432bc:	c3                   	retq   
   432bd:	48 89 d0             	mov    %rdx,%rax
}
   432c0:	c3                   	retq   

00000000000432c1 <strcpy>:
char* strcpy(char* dst, const char* src) {
   432c1:	48 89 f8             	mov    %rdi,%rax
   432c4:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   432c9:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   432cd:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   432d0:	48 83 c2 01          	add    $0x1,%rdx
   432d4:	84 c9                	test   %cl,%cl
   432d6:	75 f1                	jne    432c9 <strcpy+0x8>
}
   432d8:	c3                   	retq   

00000000000432d9 <strcmp>:
    while (*a && *b && *a == *b) {
   432d9:	0f b6 07             	movzbl (%rdi),%eax
   432dc:	84 c0                	test   %al,%al
   432de:	74 1a                	je     432fa <strcmp+0x21>
   432e0:	0f b6 16             	movzbl (%rsi),%edx
   432e3:	38 c2                	cmp    %al,%dl
   432e5:	75 13                	jne    432fa <strcmp+0x21>
   432e7:	84 d2                	test   %dl,%dl
   432e9:	74 0f                	je     432fa <strcmp+0x21>
        ++a, ++b;
   432eb:	48 83 c7 01          	add    $0x1,%rdi
   432ef:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   432f3:	0f b6 07             	movzbl (%rdi),%eax
   432f6:	84 c0                	test   %al,%al
   432f8:	75 e6                	jne    432e0 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   432fa:	3a 06                	cmp    (%rsi),%al
   432fc:	0f 97 c0             	seta   %al
   432ff:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   43302:	83 d8 00             	sbb    $0x0,%eax
}
   43305:	c3                   	retq   

0000000000043306 <strchr>:
    while (*s && *s != (char) c) {
   43306:	0f b6 07             	movzbl (%rdi),%eax
   43309:	84 c0                	test   %al,%al
   4330b:	74 10                	je     4331d <strchr+0x17>
   4330d:	40 38 f0             	cmp    %sil,%al
   43310:	74 18                	je     4332a <strchr+0x24>
        ++s;
   43312:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   43316:	0f b6 07             	movzbl (%rdi),%eax
   43319:	84 c0                	test   %al,%al
   4331b:	75 f0                	jne    4330d <strchr+0x7>
        return NULL;
   4331d:	40 84 f6             	test   %sil,%sil
   43320:	b8 00 00 00 00       	mov    $0x0,%eax
   43325:	48 0f 44 c7          	cmove  %rdi,%rax
}
   43329:	c3                   	retq   
   4332a:	48 89 f8             	mov    %rdi,%rax
   4332d:	c3                   	retq   

000000000004332e <rand>:
    if (!rand_seed_set) {
   4332e:	83 3d d3 6c 01 00 00 	cmpl   $0x0,0x16cd3(%rip)        # 5a008 <rand_seed_set>
   43335:	74 1b                	je     43352 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43337:	69 05 c3 6c 01 00 0d 	imul   $0x19660d,0x16cc3(%rip),%eax        # 5a004 <rand_seed>
   4333e:	66 19 00 
   43341:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43346:	89 05 b8 6c 01 00    	mov    %eax,0x16cb8(%rip)        # 5a004 <rand_seed>
    return rand_seed & RAND_MAX;
   4334c:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43351:	c3                   	retq   
    rand_seed = seed;
   43352:	c7 05 a8 6c 01 00 9e 	movl   $0x30d4879e,0x16ca8(%rip)        # 5a004 <rand_seed>
   43359:	87 d4 30 
    rand_seed_set = 1;
   4335c:	c7 05 a2 6c 01 00 01 	movl   $0x1,0x16ca2(%rip)        # 5a008 <rand_seed_set>
   43363:	00 00 00 
}
   43366:	eb cf                	jmp    43337 <rand+0x9>

0000000000043368 <srand>:
    rand_seed = seed;
   43368:	89 3d 96 6c 01 00    	mov    %edi,0x16c96(%rip)        # 5a004 <rand_seed>
    rand_seed_set = 1;
   4336e:	c7 05 90 6c 01 00 01 	movl   $0x1,0x16c90(%rip)        # 5a008 <rand_seed_set>
   43375:	00 00 00 
}
   43378:	c3                   	retq   

0000000000043379 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43379:	55                   	push   %rbp
   4337a:	48 89 e5             	mov    %rsp,%rbp
   4337d:	41 57                	push   %r15
   4337f:	41 56                	push   %r14
   43381:	41 55                	push   %r13
   43383:	41 54                	push   %r12
   43385:	53                   	push   %rbx
   43386:	48 83 ec 58          	sub    $0x58,%rsp
   4338a:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   4338e:	0f b6 02             	movzbl (%rdx),%eax
   43391:	84 c0                	test   %al,%al
   43393:	0f 84 b0 06 00 00    	je     43a49 <printer_vprintf+0x6d0>
   43399:	49 89 fe             	mov    %rdi,%r14
   4339c:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   4339f:	41 89 f7             	mov    %esi,%r15d
   433a2:	e9 a4 04 00 00       	jmpq   4384b <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
   433a7:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   433ac:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   433b2:	45 84 e4             	test   %r12b,%r12b
   433b5:	0f 84 82 06 00 00    	je     43a3d <printer_vprintf+0x6c4>
        int flags = 0;
   433bb:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   433c1:	41 0f be f4          	movsbl %r12b,%esi
   433c5:	bf c1 53 04 00       	mov    $0x453c1,%edi
   433ca:	e8 37 ff ff ff       	callq  43306 <strchr>
   433cf:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   433d2:	48 85 c0             	test   %rax,%rax
   433d5:	74 55                	je     4342c <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
   433d7:	48 81 e9 c1 53 04 00 	sub    $0x453c1,%rcx
   433de:	b8 01 00 00 00       	mov    $0x1,%eax
   433e3:	d3 e0                	shl    %cl,%eax
   433e5:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   433e8:	48 83 c3 01          	add    $0x1,%rbx
   433ec:	44 0f b6 23          	movzbl (%rbx),%r12d
   433f0:	45 84 e4             	test   %r12b,%r12b
   433f3:	75 cc                	jne    433c1 <printer_vprintf+0x48>
   433f5:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   433f9:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   433ff:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   43406:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   43409:	0f 84 a9 00 00 00    	je     434b8 <printer_vprintf+0x13f>
        int length = 0;
   4340f:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   43414:	0f b6 13             	movzbl (%rbx),%edx
   43417:	8d 42 bd             	lea    -0x43(%rdx),%eax
   4341a:	3c 37                	cmp    $0x37,%al
   4341c:	0f 87 c4 04 00 00    	ja     438e6 <printer_vprintf+0x56d>
   43422:	0f b6 c0             	movzbl %al,%eax
   43425:	ff 24 c5 d0 51 04 00 	jmpq   *0x451d0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
   4342c:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
   43430:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   43435:	3c 08                	cmp    $0x8,%al
   43437:	77 2f                	ja     43468 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43439:	0f b6 03             	movzbl (%rbx),%eax
   4343c:	8d 50 d0             	lea    -0x30(%rax),%edx
   4343f:	80 fa 09             	cmp    $0x9,%dl
   43442:	77 5e                	ja     434a2 <printer_vprintf+0x129>
   43444:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   4344a:	48 83 c3 01          	add    $0x1,%rbx
   4344e:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   43453:	0f be c0             	movsbl %al,%eax
   43456:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4345b:	0f b6 03             	movzbl (%rbx),%eax
   4345e:	8d 50 d0             	lea    -0x30(%rax),%edx
   43461:	80 fa 09             	cmp    $0x9,%dl
   43464:	76 e4                	jbe    4344a <printer_vprintf+0xd1>
   43466:	eb 97                	jmp    433ff <printer_vprintf+0x86>
        } else if (*format == '*') {
   43468:	41 80 fc 2a          	cmp    $0x2a,%r12b
   4346c:	75 3f                	jne    434ad <printer_vprintf+0x134>
            width = va_arg(val, int);
   4346e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43472:	8b 07                	mov    (%rdi),%eax
   43474:	83 f8 2f             	cmp    $0x2f,%eax
   43477:	77 17                	ja     43490 <printer_vprintf+0x117>
   43479:	89 c2                	mov    %eax,%edx
   4347b:	48 03 57 10          	add    0x10(%rdi),%rdx
   4347f:	83 c0 08             	add    $0x8,%eax
   43482:	89 07                	mov    %eax,(%rdi)
   43484:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   43487:	48 83 c3 01          	add    $0x1,%rbx
   4348b:	e9 6f ff ff ff       	jmpq   433ff <printer_vprintf+0x86>
            width = va_arg(val, int);
   43490:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43494:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43498:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4349c:	48 89 41 08          	mov    %rax,0x8(%rcx)
   434a0:	eb e2                	jmp    43484 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   434a2:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   434a8:	e9 52 ff ff ff       	jmpq   433ff <printer_vprintf+0x86>
        int width = -1;
   434ad:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   434b3:	e9 47 ff ff ff       	jmpq   433ff <printer_vprintf+0x86>
            ++format;
   434b8:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   434bc:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   434c0:	8d 48 d0             	lea    -0x30(%rax),%ecx
   434c3:	80 f9 09             	cmp    $0x9,%cl
   434c6:	76 13                	jbe    434db <printer_vprintf+0x162>
            } else if (*format == '*') {
   434c8:	3c 2a                	cmp    $0x2a,%al
   434ca:	74 33                	je     434ff <printer_vprintf+0x186>
            ++format;
   434cc:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   434cf:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   434d6:	e9 34 ff ff ff       	jmpq   4340f <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   434db:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
   434e0:	48 83 c2 01          	add    $0x1,%rdx
   434e4:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
   434e7:	0f be c0             	movsbl %al,%eax
   434ea:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   434ee:	0f b6 02             	movzbl (%rdx),%eax
   434f1:	8d 70 d0             	lea    -0x30(%rax),%esi
   434f4:	40 80 fe 09          	cmp    $0x9,%sil
   434f8:	76 e6                	jbe    434e0 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
   434fa:	48 89 d3             	mov    %rdx,%rbx
   434fd:	eb 1c                	jmp    4351b <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
   434ff:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43503:	8b 07                	mov    (%rdi),%eax
   43505:	83 f8 2f             	cmp    $0x2f,%eax
   43508:	77 23                	ja     4352d <printer_vprintf+0x1b4>
   4350a:	89 c2                	mov    %eax,%edx
   4350c:	48 03 57 10          	add    0x10(%rdi),%rdx
   43510:	83 c0 08             	add    $0x8,%eax
   43513:	89 07                	mov    %eax,(%rdi)
   43515:	8b 0a                	mov    (%rdx),%ecx
                ++format;
   43517:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   4351b:	85 c9                	test   %ecx,%ecx
   4351d:	b8 00 00 00 00       	mov    $0x0,%eax
   43522:	0f 49 c1             	cmovns %ecx,%eax
   43525:	89 45 9c             	mov    %eax,-0x64(%rbp)
   43528:	e9 e2 fe ff ff       	jmpq   4340f <printer_vprintf+0x96>
                precision = va_arg(val, int);
   4352d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43531:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43535:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43539:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4353d:	eb d6                	jmp    43515 <printer_vprintf+0x19c>
        switch (*format) {
   4353f:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43544:	e9 f3 00 00 00       	jmpq   4363c <printer_vprintf+0x2c3>
            ++format;
   43549:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   4354d:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
   43552:	e9 bd fe ff ff       	jmpq   43414 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43557:	85 c9                	test   %ecx,%ecx
   43559:	74 55                	je     435b0 <printer_vprintf+0x237>
   4355b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4355f:	8b 07                	mov    (%rdi),%eax
   43561:	83 f8 2f             	cmp    $0x2f,%eax
   43564:	77 38                	ja     4359e <printer_vprintf+0x225>
   43566:	89 c2                	mov    %eax,%edx
   43568:	48 03 57 10          	add    0x10(%rdi),%rdx
   4356c:	83 c0 08             	add    $0x8,%eax
   4356f:	89 07                	mov    %eax,(%rdi)
   43571:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43574:	48 89 d0             	mov    %rdx,%rax
   43577:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   4357b:	49 89 d0             	mov    %rdx,%r8
   4357e:	49 f7 d8             	neg    %r8
   43581:	25 80 00 00 00       	and    $0x80,%eax
   43586:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   4358a:	0b 45 a8             	or     -0x58(%rbp),%eax
   4358d:	83 c8 60             	or     $0x60,%eax
   43590:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   43593:	41 bc c7 51 04 00    	mov    $0x451c7,%r12d
            break;
   43599:	e9 35 01 00 00       	jmpq   436d3 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4359e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   435a2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   435a6:	48 8d 42 08          	lea    0x8(%rdx),%rax
   435aa:	48 89 41 08          	mov    %rax,0x8(%rcx)
   435ae:	eb c1                	jmp    43571 <printer_vprintf+0x1f8>
   435b0:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   435b4:	8b 07                	mov    (%rdi),%eax
   435b6:	83 f8 2f             	cmp    $0x2f,%eax
   435b9:	77 10                	ja     435cb <printer_vprintf+0x252>
   435bb:	89 c2                	mov    %eax,%edx
   435bd:	48 03 57 10          	add    0x10(%rdi),%rdx
   435c1:	83 c0 08             	add    $0x8,%eax
   435c4:	89 07                	mov    %eax,(%rdi)
   435c6:	48 63 12             	movslq (%rdx),%rdx
   435c9:	eb a9                	jmp    43574 <printer_vprintf+0x1fb>
   435cb:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   435cf:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   435d3:	48 8d 42 08          	lea    0x8(%rdx),%rax
   435d7:	48 89 47 08          	mov    %rax,0x8(%rdi)
   435db:	eb e9                	jmp    435c6 <printer_vprintf+0x24d>
        int base = 10;
   435dd:	be 0a 00 00 00       	mov    $0xa,%esi
   435e2:	eb 58                	jmp    4363c <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   435e4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   435e8:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   435ec:	48 8d 42 08          	lea    0x8(%rdx),%rax
   435f0:	48 89 41 08          	mov    %rax,0x8(%rcx)
   435f4:	eb 60                	jmp    43656 <printer_vprintf+0x2dd>
   435f6:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   435fa:	8b 07                	mov    (%rdi),%eax
   435fc:	83 f8 2f             	cmp    $0x2f,%eax
   435ff:	77 10                	ja     43611 <printer_vprintf+0x298>
   43601:	89 c2                	mov    %eax,%edx
   43603:	48 03 57 10          	add    0x10(%rdi),%rdx
   43607:	83 c0 08             	add    $0x8,%eax
   4360a:	89 07                	mov    %eax,(%rdi)
   4360c:	44 8b 02             	mov    (%rdx),%r8d
   4360f:	eb 48                	jmp    43659 <printer_vprintf+0x2e0>
   43611:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43615:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43619:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4361d:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43621:	eb e9                	jmp    4360c <printer_vprintf+0x293>
   43623:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   43626:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   4362d:	bf b0 53 04 00       	mov    $0x453b0,%edi
   43632:	e9 e2 02 00 00       	jmpq   43919 <printer_vprintf+0x5a0>
            base = 16;
   43637:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4363c:	85 c9                	test   %ecx,%ecx
   4363e:	74 b6                	je     435f6 <printer_vprintf+0x27d>
   43640:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43644:	8b 01                	mov    (%rcx),%eax
   43646:	83 f8 2f             	cmp    $0x2f,%eax
   43649:	77 99                	ja     435e4 <printer_vprintf+0x26b>
   4364b:	89 c2                	mov    %eax,%edx
   4364d:	48 03 51 10          	add    0x10(%rcx),%rdx
   43651:	83 c0 08             	add    $0x8,%eax
   43654:	89 01                	mov    %eax,(%rcx)
   43656:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   43659:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   4365d:	85 f6                	test   %esi,%esi
   4365f:	79 c2                	jns    43623 <printer_vprintf+0x2aa>
        base = -base;
   43661:	41 89 f1             	mov    %esi,%r9d
   43664:	f7 de                	neg    %esi
   43666:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   4366d:	bf 90 53 04 00       	mov    $0x45390,%edi
   43672:	e9 a2 02 00 00       	jmpq   43919 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
   43677:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4367b:	8b 07                	mov    (%rdi),%eax
   4367d:	83 f8 2f             	cmp    $0x2f,%eax
   43680:	77 1c                	ja     4369e <printer_vprintf+0x325>
   43682:	89 c2                	mov    %eax,%edx
   43684:	48 03 57 10          	add    0x10(%rdi),%rdx
   43688:	83 c0 08             	add    $0x8,%eax
   4368b:	89 07                	mov    %eax,(%rdi)
   4368d:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43690:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   43697:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   4369c:	eb c3                	jmp    43661 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
   4369e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   436a2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   436a6:	48 8d 42 08          	lea    0x8(%rdx),%rax
   436aa:	48 89 41 08          	mov    %rax,0x8(%rcx)
   436ae:	eb dd                	jmp    4368d <printer_vprintf+0x314>
            data = va_arg(val, char*);
   436b0:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   436b4:	8b 01                	mov    (%rcx),%eax
   436b6:	83 f8 2f             	cmp    $0x2f,%eax
   436b9:	0f 87 a5 01 00 00    	ja     43864 <printer_vprintf+0x4eb>
   436bf:	89 c2                	mov    %eax,%edx
   436c1:	48 03 51 10          	add    0x10(%rcx),%rdx
   436c5:	83 c0 08             	add    $0x8,%eax
   436c8:	89 01                	mov    %eax,(%rcx)
   436ca:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   436cd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   436d3:	8b 45 a8             	mov    -0x58(%rbp),%eax
   436d6:	83 e0 20             	and    $0x20,%eax
   436d9:	89 45 8c             	mov    %eax,-0x74(%rbp)
   436dc:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   436e2:	0f 85 21 02 00 00    	jne    43909 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   436e8:	8b 45 a8             	mov    -0x58(%rbp),%eax
   436eb:	89 45 88             	mov    %eax,-0x78(%rbp)
   436ee:	83 e0 60             	and    $0x60,%eax
   436f1:	83 f8 60             	cmp    $0x60,%eax
   436f4:	0f 84 54 02 00 00    	je     4394e <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   436fa:	8b 45 a8             	mov    -0x58(%rbp),%eax
   436fd:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   43700:	48 c7 45 a0 c7 51 04 	movq   $0x451c7,-0x60(%rbp)
   43707:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43708:	83 f8 21             	cmp    $0x21,%eax
   4370b:	0f 84 79 02 00 00    	je     4398a <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43711:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   43714:	89 f8                	mov    %edi,%eax
   43716:	f7 d0                	not    %eax
   43718:	c1 e8 1f             	shr    $0x1f,%eax
   4371b:	89 45 84             	mov    %eax,-0x7c(%rbp)
   4371e:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43722:	0f 85 9e 02 00 00    	jne    439c6 <printer_vprintf+0x64d>
   43728:	84 c0                	test   %al,%al
   4372a:	0f 84 96 02 00 00    	je     439c6 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
   43730:	48 63 f7             	movslq %edi,%rsi
   43733:	4c 89 e7             	mov    %r12,%rdi
   43736:	e8 63 fb ff ff       	callq  4329e <strnlen>
   4373b:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   4373e:	8b 45 88             	mov    -0x78(%rbp),%eax
   43741:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   43744:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   4374b:	83 f8 22             	cmp    $0x22,%eax
   4374e:	0f 84 aa 02 00 00    	je     439fe <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
   43754:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43758:	e8 26 fb ff ff       	callq  43283 <strlen>
   4375d:	8b 55 9c             	mov    -0x64(%rbp),%edx
   43760:	03 55 98             	add    -0x68(%rbp),%edx
   43763:	44 89 e9             	mov    %r13d,%ecx
   43766:	29 d1                	sub    %edx,%ecx
   43768:	29 c1                	sub    %eax,%ecx
   4376a:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
   4376d:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43770:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   43774:	75 2d                	jne    437a3 <printer_vprintf+0x42a>
   43776:	85 c9                	test   %ecx,%ecx
   43778:	7e 29                	jle    437a3 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
   4377a:	44 89 fa             	mov    %r15d,%edx
   4377d:	be 20 00 00 00       	mov    $0x20,%esi
   43782:	4c 89 f7             	mov    %r14,%rdi
   43785:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43788:	41 83 ed 01          	sub    $0x1,%r13d
   4378c:	45 85 ed             	test   %r13d,%r13d
   4378f:	7f e9                	jg     4377a <printer_vprintf+0x401>
   43791:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   43794:	85 ff                	test   %edi,%edi
   43796:	b8 01 00 00 00       	mov    $0x1,%eax
   4379b:	0f 4f c7             	cmovg  %edi,%eax
   4379e:	29 c7                	sub    %eax,%edi
   437a0:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   437a3:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   437a7:	0f b6 07             	movzbl (%rdi),%eax
   437aa:	84 c0                	test   %al,%al
   437ac:	74 22                	je     437d0 <printer_vprintf+0x457>
   437ae:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   437b2:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
   437b5:	0f b6 f0             	movzbl %al,%esi
   437b8:	44 89 fa             	mov    %r15d,%edx
   437bb:	4c 89 f7             	mov    %r14,%rdi
   437be:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
   437c1:	48 83 c3 01          	add    $0x1,%rbx
   437c5:	0f b6 03             	movzbl (%rbx),%eax
   437c8:	84 c0                	test   %al,%al
   437ca:	75 e9                	jne    437b5 <printer_vprintf+0x43c>
   437cc:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   437d0:	8b 45 9c             	mov    -0x64(%rbp),%eax
   437d3:	85 c0                	test   %eax,%eax
   437d5:	7e 1d                	jle    437f4 <printer_vprintf+0x47b>
   437d7:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   437db:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   437dd:	44 89 fa             	mov    %r15d,%edx
   437e0:	be 30 00 00 00       	mov    $0x30,%esi
   437e5:	4c 89 f7             	mov    %r14,%rdi
   437e8:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
   437eb:	83 eb 01             	sub    $0x1,%ebx
   437ee:	75 ed                	jne    437dd <printer_vprintf+0x464>
   437f0:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   437f4:	8b 45 98             	mov    -0x68(%rbp),%eax
   437f7:	85 c0                	test   %eax,%eax
   437f9:	7e 27                	jle    43822 <printer_vprintf+0x4a9>
   437fb:	89 c0                	mov    %eax,%eax
   437fd:	4c 01 e0             	add    %r12,%rax
   43800:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43804:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   43807:	41 0f b6 34 24       	movzbl (%r12),%esi
   4380c:	44 89 fa             	mov    %r15d,%edx
   4380f:	4c 89 f7             	mov    %r14,%rdi
   43812:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
   43815:	49 83 c4 01          	add    $0x1,%r12
   43819:	49 39 dc             	cmp    %rbx,%r12
   4381c:	75 e9                	jne    43807 <printer_vprintf+0x48e>
   4381e:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   43822:	45 85 ed             	test   %r13d,%r13d
   43825:	7e 14                	jle    4383b <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
   43827:	44 89 fa             	mov    %r15d,%edx
   4382a:	be 20 00 00 00       	mov    $0x20,%esi
   4382f:	4c 89 f7             	mov    %r14,%rdi
   43832:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
   43835:	41 83 ed 01          	sub    $0x1,%r13d
   43839:	75 ec                	jne    43827 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
   4383b:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   4383f:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43843:	84 c0                	test   %al,%al
   43845:	0f 84 fe 01 00 00    	je     43a49 <printer_vprintf+0x6d0>
        if (*format != '%') {
   4384b:	3c 25                	cmp    $0x25,%al
   4384d:	0f 84 54 fb ff ff    	je     433a7 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
   43853:	0f b6 f0             	movzbl %al,%esi
   43856:	44 89 fa             	mov    %r15d,%edx
   43859:	4c 89 f7             	mov    %r14,%rdi
   4385c:	41 ff 16             	callq  *(%r14)
            continue;
   4385f:	4c 89 e3             	mov    %r12,%rbx
   43862:	eb d7                	jmp    4383b <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
   43864:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43868:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   4386c:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43870:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43874:	e9 51 fe ff ff       	jmpq   436ca <printer_vprintf+0x351>
            color = va_arg(val, int);
   43879:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4387d:	8b 07                	mov    (%rdi),%eax
   4387f:	83 f8 2f             	cmp    $0x2f,%eax
   43882:	77 10                	ja     43894 <printer_vprintf+0x51b>
   43884:	89 c2                	mov    %eax,%edx
   43886:	48 03 57 10          	add    0x10(%rdi),%rdx
   4388a:	83 c0 08             	add    $0x8,%eax
   4388d:	89 07                	mov    %eax,(%rdi)
   4388f:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   43892:	eb a7                	jmp    4383b <printer_vprintf+0x4c2>
            color = va_arg(val, int);
   43894:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43898:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4389c:	48 8d 42 08          	lea    0x8(%rdx),%rax
   438a0:	48 89 41 08          	mov    %rax,0x8(%rcx)
   438a4:	eb e9                	jmp    4388f <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
   438a6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   438aa:	8b 01                	mov    (%rcx),%eax
   438ac:	83 f8 2f             	cmp    $0x2f,%eax
   438af:	77 23                	ja     438d4 <printer_vprintf+0x55b>
   438b1:	89 c2                	mov    %eax,%edx
   438b3:	48 03 51 10          	add    0x10(%rcx),%rdx
   438b7:	83 c0 08             	add    $0x8,%eax
   438ba:	89 01                	mov    %eax,(%rcx)
   438bc:	8b 02                	mov    (%rdx),%eax
   438be:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   438c1:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   438c5:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   438c9:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   438cf:	e9 ff fd ff ff       	jmpq   436d3 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
   438d4:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   438d8:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   438dc:	48 8d 42 08          	lea    0x8(%rdx),%rax
   438e0:	48 89 47 08          	mov    %rax,0x8(%rdi)
   438e4:	eb d6                	jmp    438bc <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
   438e6:	84 d2                	test   %dl,%dl
   438e8:	0f 85 39 01 00 00    	jne    43a27 <printer_vprintf+0x6ae>
   438ee:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   438f2:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   438f6:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   438fa:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   438fe:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43904:	e9 ca fd ff ff       	jmpq   436d3 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
   43909:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   4390f:	bf b0 53 04 00       	mov    $0x453b0,%edi
        if (flags & FLAG_NUMERIC) {
   43914:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   43919:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   4391d:	4c 89 c1             	mov    %r8,%rcx
   43920:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   43924:	48 63 f6             	movslq %esi,%rsi
   43927:	49 83 ec 01          	sub    $0x1,%r12
   4392b:	48 89 c8             	mov    %rcx,%rax
   4392e:	ba 00 00 00 00       	mov    $0x0,%edx
   43933:	48 f7 f6             	div    %rsi
   43936:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   4393a:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   4393e:	48 89 ca             	mov    %rcx,%rdx
   43941:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   43944:	48 39 d6             	cmp    %rdx,%rsi
   43947:	76 de                	jbe    43927 <printer_vprintf+0x5ae>
   43949:	e9 9a fd ff ff       	jmpq   436e8 <printer_vprintf+0x36f>
                prefix = "-";
   4394e:	48 c7 45 a0 c4 51 04 	movq   $0x451c4,-0x60(%rbp)
   43955:	00 
            if (flags & FLAG_NEGATIVE) {
   43956:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43959:	a8 80                	test   $0x80,%al
   4395b:	0f 85 b0 fd ff ff    	jne    43711 <printer_vprintf+0x398>
                prefix = "+";
   43961:	48 c7 45 a0 bf 51 04 	movq   $0x451bf,-0x60(%rbp)
   43968:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43969:	a8 10                	test   $0x10,%al
   4396b:	0f 85 a0 fd ff ff    	jne    43711 <printer_vprintf+0x398>
                prefix = " ";
   43971:	a8 08                	test   $0x8,%al
   43973:	ba c7 51 04 00       	mov    $0x451c7,%edx
   43978:	b8 c6 51 04 00       	mov    $0x451c6,%eax
   4397d:	48 0f 44 c2          	cmove  %rdx,%rax
   43981:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43985:	e9 87 fd ff ff       	jmpq   43711 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
   4398a:	41 8d 41 10          	lea    0x10(%r9),%eax
   4398e:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   43993:	0f 85 78 fd ff ff    	jne    43711 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
   43999:	4d 85 c0             	test   %r8,%r8
   4399c:	75 0d                	jne    439ab <printer_vprintf+0x632>
   4399e:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   439a5:	0f 84 66 fd ff ff    	je     43711 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
   439ab:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   439af:	ba c8 51 04 00       	mov    $0x451c8,%edx
   439b4:	b8 c1 51 04 00       	mov    $0x451c1,%eax
   439b9:	48 0f 44 c2          	cmove  %rdx,%rax
   439bd:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   439c1:	e9 4b fd ff ff       	jmpq   43711 <printer_vprintf+0x398>
            len = strlen(data);
   439c6:	4c 89 e7             	mov    %r12,%rdi
   439c9:	e8 b5 f8 ff ff       	callq  43283 <strlen>
   439ce:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   439d1:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   439d5:	0f 84 63 fd ff ff    	je     4373e <printer_vprintf+0x3c5>
   439db:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   439df:	0f 84 59 fd ff ff    	je     4373e <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
   439e5:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   439e8:	89 ca                	mov    %ecx,%edx
   439ea:	29 c2                	sub    %eax,%edx
   439ec:	39 c1                	cmp    %eax,%ecx
   439ee:	b8 00 00 00 00       	mov    $0x0,%eax
   439f3:	0f 4e d0             	cmovle %eax,%edx
   439f6:	89 55 9c             	mov    %edx,-0x64(%rbp)
   439f9:	e9 56 fd ff ff       	jmpq   43754 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
   439fe:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43a02:	e8 7c f8 ff ff       	callq  43283 <strlen>
   43a07:	8b 7d 98             	mov    -0x68(%rbp),%edi
   43a0a:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   43a0d:	44 89 e9             	mov    %r13d,%ecx
   43a10:	29 f9                	sub    %edi,%ecx
   43a12:	29 c1                	sub    %eax,%ecx
   43a14:	44 39 ea             	cmp    %r13d,%edx
   43a17:	b8 00 00 00 00       	mov    $0x0,%eax
   43a1c:	0f 4d c8             	cmovge %eax,%ecx
   43a1f:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
   43a22:	e9 2d fd ff ff       	jmpq   43754 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
   43a27:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   43a2a:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43a2e:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43a32:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43a38:	e9 96 fc ff ff       	jmpq   436d3 <printer_vprintf+0x35a>
        int flags = 0;
   43a3d:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   43a44:	e9 b0 f9 ff ff       	jmpq   433f9 <printer_vprintf+0x80>
}
   43a49:	48 83 c4 58          	add    $0x58,%rsp
   43a4d:	5b                   	pop    %rbx
   43a4e:	41 5c                	pop    %r12
   43a50:	41 5d                	pop    %r13
   43a52:	41 5e                	pop    %r14
   43a54:	41 5f                	pop    %r15
   43a56:	5d                   	pop    %rbp
   43a57:	c3                   	retq   

0000000000043a58 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43a58:	55                   	push   %rbp
   43a59:	48 89 e5             	mov    %rsp,%rbp
   43a5c:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   43a60:	48 c7 45 f0 63 31 04 	movq   $0x43163,-0x10(%rbp)
   43a67:	00 
        cpos = 0;
   43a68:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   43a6e:	b8 00 00 00 00       	mov    $0x0,%eax
   43a73:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   43a76:	48 63 ff             	movslq %edi,%rdi
   43a79:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   43a80:	00 
   43a81:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43a85:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   43a89:	e8 eb f8 ff ff       	callq  43379 <printer_vprintf>
    return cp.cursor - console;
   43a8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a92:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43a98:	48 d1 f8             	sar    %rax
}
   43a9b:	c9                   	leaveq 
   43a9c:	c3                   	retq   

0000000000043a9d <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   43a9d:	55                   	push   %rbp
   43a9e:	48 89 e5             	mov    %rsp,%rbp
   43aa1:	48 83 ec 50          	sub    $0x50,%rsp
   43aa5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43aa9:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43aad:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   43ab1:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43ab8:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43abc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43ac0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43ac4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43ac8:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43acc:	e8 87 ff ff ff       	callq  43a58 <console_vprintf>
}
   43ad1:	c9                   	leaveq 
   43ad2:	c3                   	retq   

0000000000043ad3 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43ad3:	55                   	push   %rbp
   43ad4:	48 89 e5             	mov    %rsp,%rbp
   43ad7:	53                   	push   %rbx
   43ad8:	48 83 ec 28          	sub    $0x28,%rsp
   43adc:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   43adf:	48 c7 45 d8 e9 31 04 	movq   $0x431e9,-0x28(%rbp)
   43ae6:	00 
    sp.s = s;
   43ae7:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   43aeb:	48 85 f6             	test   %rsi,%rsi
   43aee:	75 0b                	jne    43afb <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   43af0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43af3:	29 d8                	sub    %ebx,%eax
}
   43af5:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43af9:	c9                   	leaveq 
   43afa:	c3                   	retq   
        sp.end = s + size - 1;
   43afb:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   43b00:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43b04:	be 00 00 00 00       	mov    $0x0,%esi
   43b09:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   43b0d:	e8 67 f8 ff ff       	callq  43379 <printer_vprintf>
        *sp.s = 0;
   43b12:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43b16:	c6 00 00             	movb   $0x0,(%rax)
   43b19:	eb d5                	jmp    43af0 <vsnprintf+0x1d>

0000000000043b1b <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43b1b:	55                   	push   %rbp
   43b1c:	48 89 e5             	mov    %rsp,%rbp
   43b1f:	48 83 ec 50          	sub    $0x50,%rsp
   43b23:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43b27:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43b2b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43b2f:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43b36:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43b3a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43b3e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43b42:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   43b46:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43b4a:	e8 84 ff ff ff       	callq  43ad3 <vsnprintf>
    va_end(val);
    return n;
}
   43b4f:	c9                   	leaveq 
   43b50:	c3                   	retq   

0000000000043b51 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43b51:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   43b56:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   43b5b:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43b60:	48 83 c0 02          	add    $0x2,%rax
   43b64:	48 39 d0             	cmp    %rdx,%rax
   43b67:	75 f2                	jne    43b5b <console_clear+0xa>
    }
    cursorpos = 0;
   43b69:	c7 05 89 54 07 00 00 	movl   $0x0,0x75489(%rip)        # b8ffc <cursorpos>
   43b70:	00 00 00 
}
   43b73:	c3                   	retq   

0000000000043b74 <palloc>:
   43b74:	55                   	push   %rbp
   43b75:	48 89 e5             	mov    %rsp,%rbp
   43b78:	48 83 ec 20          	sub    $0x20,%rsp
   43b7c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43b7f:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43b86:	00 
   43b87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b8b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43b8f:	e9 95 00 00 00       	jmpq   43c29 <palloc+0xb5>
   43b94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b98:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43b9c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43ba3:	00 
   43ba4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ba8:	48 c1 e8 0c          	shr    $0xc,%rax
   43bac:	48 98                	cltq   
   43bae:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   43bb5:	00 
   43bb6:	84 c0                	test   %al,%al
   43bb8:	75 6f                	jne    43c29 <palloc+0xb5>
   43bba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bbe:	48 c1 e8 0c          	shr    $0xc,%rax
   43bc2:	48 98                	cltq   
   43bc4:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43bcb:	00 
   43bcc:	84 c0                	test   %al,%al
   43bce:	75 59                	jne    43c29 <palloc+0xb5>
   43bd0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bd4:	48 c1 e8 0c          	shr    $0xc,%rax
   43bd8:	89 c2                	mov    %eax,%edx
   43bda:	48 63 c2             	movslq %edx,%rax
   43bdd:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43be4:	00 
   43be5:	83 c0 01             	add    $0x1,%eax
   43be8:	89 c1                	mov    %eax,%ecx
   43bea:	48 63 c2             	movslq %edx,%rax
   43bed:	88 8c 00 21 1f 05 00 	mov    %cl,0x51f21(%rax,%rax,1)
   43bf4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bf8:	48 c1 e8 0c          	shr    $0xc,%rax
   43bfc:	89 c1                	mov    %eax,%ecx
   43bfe:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c01:	89 c2                	mov    %eax,%edx
   43c03:	48 63 c1             	movslq %ecx,%rax
   43c06:	88 94 00 20 1f 05 00 	mov    %dl,0x51f20(%rax,%rax,1)
   43c0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c11:	ba 00 10 00 00       	mov    $0x1000,%edx
   43c16:	be cc 00 00 00       	mov    $0xcc,%esi
   43c1b:	48 89 c7             	mov    %rax,%rdi
   43c1e:	e8 45 f6 ff ff       	callq  43268 <memset>
   43c23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c27:	eb 2c                	jmp    43c55 <palloc+0xe1>
   43c29:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43c30:	00 
   43c31:	0f 86 5d ff ff ff    	jbe    43b94 <palloc+0x20>
   43c37:	ba c8 53 04 00       	mov    $0x453c8,%edx
   43c3c:	be 00 0c 00 00       	mov    $0xc00,%esi
   43c41:	bf 80 07 00 00       	mov    $0x780,%edi
   43c46:	b8 00 00 00 00       	mov    $0x0,%eax
   43c4b:	e8 4d fe ff ff       	callq  43a9d <console_printf>
   43c50:	b8 00 00 00 00       	mov    $0x0,%eax
   43c55:	c9                   	leaveq 
   43c56:	c3                   	retq   

0000000000043c57 <palloc_target>:
   43c57:	55                   	push   %rbp
   43c58:	48 89 e5             	mov    %rsp,%rbp
   43c5b:	48 8b 05 ae 63 01 00 	mov    0x163ae(%rip),%rax        # 5a010 <palloc_target_proc>
   43c62:	48 85 c0             	test   %rax,%rax
   43c65:	75 14                	jne    43c7b <palloc_target+0x24>
   43c67:	ba e1 53 04 00       	mov    $0x453e1,%edx
   43c6c:	be 27 00 00 00       	mov    $0x27,%esi
   43c71:	bf fc 53 04 00       	mov    $0x453fc,%edi
   43c76:	e8 78 e9 ff ff       	callq  425f3 <assert_fail>
   43c7b:	48 8b 05 8e 63 01 00 	mov    0x1638e(%rip),%rax        # 5a010 <palloc_target_proc>
   43c82:	8b 00                	mov    (%rax),%eax
   43c84:	89 c7                	mov    %eax,%edi
   43c86:	e8 e9 fe ff ff       	callq  43b74 <palloc>
   43c8b:	5d                   	pop    %rbp
   43c8c:	c3                   	retq   

0000000000043c8d <process_free>:
   43c8d:	55                   	push   %rbp
   43c8e:	48 89 e5             	mov    %rsp,%rbp
   43c91:	48 83 ec 60          	sub    $0x60,%rsp
   43c95:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43c98:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43c9b:	48 63 d0             	movslq %eax,%rdx
   43c9e:	48 89 d0             	mov    %rdx,%rax
   43ca1:	48 c1 e0 04          	shl    $0x4,%rax
   43ca5:	48 29 d0             	sub    %rdx,%rax
   43ca8:	48 c1 e0 04          	shl    $0x4,%rax
   43cac:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   43cb2:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43cb8:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43cbf:	00 
   43cc0:	e9 ad 00 00 00       	jmpq   43d72 <process_free+0xe5>
   43cc5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43cc8:	48 63 d0             	movslq %eax,%rdx
   43ccb:	48 89 d0             	mov    %rdx,%rax
   43cce:	48 c1 e0 04          	shl    $0x4,%rax
   43cd2:	48 29 d0             	sub    %rdx,%rax
   43cd5:	48 c1 e0 04          	shl    $0x4,%rax
   43cd9:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   43cdf:	48 8b 08             	mov    (%rax),%rcx
   43ce2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   43ce6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43cea:	48 89 ce             	mov    %rcx,%rsi
   43ced:	48 89 c7             	mov    %rax,%rdi
   43cf0:	e8 c0 ef ff ff       	callq  42cb5 <virtual_memory_lookup>
   43cf5:	8b 45 c8             	mov    -0x38(%rbp),%eax
   43cf8:	48 98                	cltq   
   43cfa:	83 e0 01             	and    $0x1,%eax
   43cfd:	48 85 c0             	test   %rax,%rax
   43d00:	74 68                	je     43d6a <process_free+0xdd>
   43d02:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43d05:	48 63 d0             	movslq %eax,%rdx
   43d08:	0f b6 94 12 21 1f 05 	movzbl 0x51f21(%rdx,%rdx,1),%edx
   43d0f:	00 
   43d10:	83 ea 01             	sub    $0x1,%edx
   43d13:	48 98                	cltq   
   43d15:	88 94 00 21 1f 05 00 	mov    %dl,0x51f21(%rax,%rax,1)
   43d1c:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43d1f:	48 98                	cltq   
   43d21:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43d28:	00 
   43d29:	84 c0                	test   %al,%al
   43d2b:	75 0f                	jne    43d3c <process_free+0xaf>
   43d2d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43d30:	48 98                	cltq   
   43d32:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43d39:	00 
   43d3a:	eb 2e                	jmp    43d6a <process_free+0xdd>
   43d3c:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43d3f:	48 98                	cltq   
   43d41:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   43d48:	00 
   43d49:	0f be c0             	movsbl %al,%eax
   43d4c:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43d4f:	75 19                	jne    43d6a <process_free+0xdd>
   43d51:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43d55:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43d58:	48 89 c6             	mov    %rax,%rsi
   43d5b:	bf 08 54 04 00       	mov    $0x45408,%edi
   43d60:	b8 00 00 00 00       	mov    $0x0,%eax
   43d65:	e8 6b e5 ff ff       	callq  422d5 <log_printf>
   43d6a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43d71:	00 
   43d72:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43d79:	00 
   43d7a:	0f 86 45 ff ff ff    	jbe    43cc5 <process_free+0x38>
   43d80:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43d83:	48 63 d0             	movslq %eax,%rdx
   43d86:	48 89 d0             	mov    %rdx,%rax
   43d89:	48 c1 e0 04          	shl    $0x4,%rax
   43d8d:	48 29 d0             	sub    %rdx,%rax
   43d90:	48 c1 e0 04          	shl    $0x4,%rax
   43d94:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   43d9a:	48 8b 00             	mov    (%rax),%rax
   43d9d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43da1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43da5:	48 8b 00             	mov    (%rax),%rax
   43da8:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43dae:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43db2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43db6:	48 8b 00             	mov    (%rax),%rax
   43db9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43dbf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43dc3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43dc7:	48 8b 00             	mov    (%rax),%rax
   43dca:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43dd0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43dd4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43dd8:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ddc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43de2:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43de6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43dea:	48 c1 e8 0c          	shr    $0xc,%rax
   43dee:	48 98                	cltq   
   43df0:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43df7:	00 
   43df8:	3c 01                	cmp    $0x1,%al
   43dfa:	74 14                	je     43e10 <process_free+0x183>
   43dfc:	ba 40 54 04 00       	mov    $0x45440,%edx
   43e01:	be 4f 00 00 00       	mov    $0x4f,%esi
   43e06:	bf fc 53 04 00       	mov    $0x453fc,%edi
   43e0b:	e8 e3 e7 ff ff       	callq  425f3 <assert_fail>
   43e10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e14:	48 c1 e8 0c          	shr    $0xc,%rax
   43e18:	48 98                	cltq   
   43e1a:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43e21:	00 
   43e22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e26:	48 c1 e8 0c          	shr    $0xc,%rax
   43e2a:	48 98                	cltq   
   43e2c:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43e33:	00 
   43e34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e38:	48 c1 e8 0c          	shr    $0xc,%rax
   43e3c:	48 98                	cltq   
   43e3e:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43e45:	00 
   43e46:	3c 01                	cmp    $0x1,%al
   43e48:	74 14                	je     43e5e <process_free+0x1d1>
   43e4a:	ba 68 54 04 00       	mov    $0x45468,%edx
   43e4f:	be 52 00 00 00       	mov    $0x52,%esi
   43e54:	bf fc 53 04 00       	mov    $0x453fc,%edi
   43e59:	e8 95 e7 ff ff       	callq  425f3 <assert_fail>
   43e5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e62:	48 c1 e8 0c          	shr    $0xc,%rax
   43e66:	48 98                	cltq   
   43e68:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43e6f:	00 
   43e70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e74:	48 c1 e8 0c          	shr    $0xc,%rax
   43e78:	48 98                	cltq   
   43e7a:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43e81:	00 
   43e82:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43e86:	48 c1 e8 0c          	shr    $0xc,%rax
   43e8a:	48 98                	cltq   
   43e8c:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43e93:	00 
   43e94:	3c 01                	cmp    $0x1,%al
   43e96:	74 14                	je     43eac <process_free+0x21f>
   43e98:	ba 90 54 04 00       	mov    $0x45490,%edx
   43e9d:	be 55 00 00 00       	mov    $0x55,%esi
   43ea2:	bf fc 53 04 00       	mov    $0x453fc,%edi
   43ea7:	e8 47 e7 ff ff       	callq  425f3 <assert_fail>
   43eac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43eb0:	48 c1 e8 0c          	shr    $0xc,%rax
   43eb4:	48 98                	cltq   
   43eb6:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43ebd:	00 
   43ebe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ec2:	48 c1 e8 0c          	shr    $0xc,%rax
   43ec6:	48 98                	cltq   
   43ec8:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43ecf:	00 
   43ed0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43ed4:	48 c1 e8 0c          	shr    $0xc,%rax
   43ed8:	48 98                	cltq   
   43eda:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43ee1:	00 
   43ee2:	3c 01                	cmp    $0x1,%al
   43ee4:	74 14                	je     43efa <process_free+0x26d>
   43ee6:	ba b8 54 04 00       	mov    $0x454b8,%edx
   43eeb:	be 58 00 00 00       	mov    $0x58,%esi
   43ef0:	bf fc 53 04 00       	mov    $0x453fc,%edi
   43ef5:	e8 f9 e6 ff ff       	callq  425f3 <assert_fail>
   43efa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43efe:	48 c1 e8 0c          	shr    $0xc,%rax
   43f02:	48 98                	cltq   
   43f04:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43f0b:	00 
   43f0c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43f10:	48 c1 e8 0c          	shr    $0xc,%rax
   43f14:	48 98                	cltq   
   43f16:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43f1d:	00 
   43f1e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43f22:	48 c1 e8 0c          	shr    $0xc,%rax
   43f26:	48 98                	cltq   
   43f28:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43f2f:	00 
   43f30:	3c 01                	cmp    $0x1,%al
   43f32:	74 14                	je     43f48 <process_free+0x2bb>
   43f34:	ba e0 54 04 00       	mov    $0x454e0,%edx
   43f39:	be 5b 00 00 00       	mov    $0x5b,%esi
   43f3e:	bf fc 53 04 00       	mov    $0x453fc,%edi
   43f43:	e8 ab e6 ff ff       	callq  425f3 <assert_fail>
   43f48:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43f4c:	48 c1 e8 0c          	shr    $0xc,%rax
   43f50:	48 98                	cltq   
   43f52:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43f59:	00 
   43f5a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43f5e:	48 c1 e8 0c          	shr    $0xc,%rax
   43f62:	48 98                	cltq   
   43f64:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43f6b:	00 
   43f6c:	90                   	nop
   43f6d:	c9                   	leaveq 
   43f6e:	c3                   	retq   

0000000000043f6f <process_config_tables>:
   43f6f:	55                   	push   %rbp
   43f70:	48 89 e5             	mov    %rsp,%rbp
   43f73:	48 83 ec 40          	sub    $0x40,%rsp
   43f77:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43f7a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43f7d:	89 c7                	mov    %eax,%edi
   43f7f:	e8 f0 fb ff ff       	callq  43b74 <palloc>
   43f84:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43f88:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43f8b:	89 c7                	mov    %eax,%edi
   43f8d:	e8 e2 fb ff ff       	callq  43b74 <palloc>
   43f92:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43f96:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43f99:	89 c7                	mov    %eax,%edi
   43f9b:	e8 d4 fb ff ff       	callq  43b74 <palloc>
   43fa0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43fa4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43fa7:	89 c7                	mov    %eax,%edi
   43fa9:	e8 c6 fb ff ff       	callq  43b74 <palloc>
   43fae:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43fb2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43fb5:	89 c7                	mov    %eax,%edi
   43fb7:	e8 b8 fb ff ff       	callq  43b74 <palloc>
   43fbc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43fc0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43fc5:	74 20                	je     43fe7 <process_config_tables+0x78>
   43fc7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43fcc:	74 19                	je     43fe7 <process_config_tables+0x78>
   43fce:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43fd3:	74 12                	je     43fe7 <process_config_tables+0x78>
   43fd5:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43fda:	74 0b                	je     43fe7 <process_config_tables+0x78>
   43fdc:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43fe1:	0f 85 e1 00 00 00    	jne    440c8 <process_config_tables+0x159>
   43fe7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43fec:	74 24                	je     44012 <process_config_tables+0xa3>
   43fee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ff2:	48 c1 e8 0c          	shr    $0xc,%rax
   43ff6:	48 98                	cltq   
   43ff8:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43fff:	00 
   44000:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44004:	48 c1 e8 0c          	shr    $0xc,%rax
   44008:	48 98                	cltq   
   4400a:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44011:	00 
   44012:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   44017:	74 24                	je     4403d <process_config_tables+0xce>
   44019:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4401d:	48 c1 e8 0c          	shr    $0xc,%rax
   44021:	48 98                	cltq   
   44023:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   4402a:	00 
   4402b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4402f:	48 c1 e8 0c          	shr    $0xc,%rax
   44033:	48 98                	cltq   
   44035:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   4403c:	00 
   4403d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   44042:	74 24                	je     44068 <process_config_tables+0xf9>
   44044:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44048:	48 c1 e8 0c          	shr    $0xc,%rax
   4404c:	48 98                	cltq   
   4404e:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44055:	00 
   44056:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4405a:	48 c1 e8 0c          	shr    $0xc,%rax
   4405e:	48 98                	cltq   
   44060:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44067:	00 
   44068:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4406d:	74 24                	je     44093 <process_config_tables+0x124>
   4406f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44073:	48 c1 e8 0c          	shr    $0xc,%rax
   44077:	48 98                	cltq   
   44079:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44080:	00 
   44081:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44085:	48 c1 e8 0c          	shr    $0xc,%rax
   44089:	48 98                	cltq   
   4408b:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44092:	00 
   44093:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44098:	74 24                	je     440be <process_config_tables+0x14f>
   4409a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4409e:	48 c1 e8 0c          	shr    $0xc,%rax
   440a2:	48 98                	cltq   
   440a4:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   440ab:	00 
   440ac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   440b0:	48 c1 e8 0c          	shr    $0xc,%rax
   440b4:	48 98                	cltq   
   440b6:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   440bd:	00 
   440be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   440c3:	e9 f3 01 00 00       	jmpq   442bb <process_config_tables+0x34c>
   440c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440cc:	ba 00 10 00 00       	mov    $0x1000,%edx
   440d1:	be 00 00 00 00       	mov    $0x0,%esi
   440d6:	48 89 c7             	mov    %rax,%rdi
   440d9:	e8 8a f1 ff ff       	callq  43268 <memset>
   440de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440e2:	ba 00 10 00 00       	mov    $0x1000,%edx
   440e7:	be 00 00 00 00       	mov    $0x0,%esi
   440ec:	48 89 c7             	mov    %rax,%rdi
   440ef:	e8 74 f1 ff ff       	callq  43268 <memset>
   440f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440f8:	ba 00 10 00 00       	mov    $0x1000,%edx
   440fd:	be 00 00 00 00       	mov    $0x0,%esi
   44102:	48 89 c7             	mov    %rax,%rdi
   44105:	e8 5e f1 ff ff       	callq  43268 <memset>
   4410a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4410e:	ba 00 10 00 00       	mov    $0x1000,%edx
   44113:	be 00 00 00 00       	mov    $0x0,%esi
   44118:	48 89 c7             	mov    %rax,%rdi
   4411b:	e8 48 f1 ff ff       	callq  43268 <memset>
   44120:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44124:	ba 00 10 00 00       	mov    $0x1000,%edx
   44129:	be 00 00 00 00       	mov    $0x0,%esi
   4412e:	48 89 c7             	mov    %rax,%rdi
   44131:	e8 32 f1 ff ff       	callq  43268 <memset>
   44136:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4413a:	48 83 c8 07          	or     $0x7,%rax
   4413e:	48 89 c2             	mov    %rax,%rdx
   44141:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44145:	48 89 10             	mov    %rdx,(%rax)
   44148:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4414c:	48 83 c8 07          	or     $0x7,%rax
   44150:	48 89 c2             	mov    %rax,%rdx
   44153:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44157:	48 89 10             	mov    %rdx,(%rax)
   4415a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4415e:	48 83 c8 07          	or     $0x7,%rax
   44162:	48 89 c2             	mov    %rax,%rdx
   44165:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44169:	48 89 10             	mov    %rdx,(%rax)
   4416c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44170:	48 83 c8 07          	or     $0x7,%rax
   44174:	48 89 c2             	mov    %rax,%rdx
   44177:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4417b:	48 89 50 08          	mov    %rdx,0x8(%rax)
   4417f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44183:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44189:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   4418f:	b9 00 00 10 00       	mov    $0x100000,%ecx
   44194:	ba 00 00 00 00       	mov    $0x0,%edx
   44199:	be 00 00 00 00       	mov    $0x0,%esi
   4419e:	48 89 c7             	mov    %rax,%rdi
   441a1:	e8 4c e7 ff ff       	callq  428f2 <virtual_memory_map>
   441a6:	85 c0                	test   %eax,%eax
   441a8:	75 2f                	jne    441d9 <process_config_tables+0x26a>
   441aa:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   441af:	be 00 80 0b 00       	mov    $0xb8000,%esi
   441b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441b8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   441be:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   441c4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   441c9:	48 89 c7             	mov    %rax,%rdi
   441cc:	e8 21 e7 ff ff       	callq  428f2 <virtual_memory_map>
   441d1:	85 c0                	test   %eax,%eax
   441d3:	0f 84 bb 00 00 00    	je     44294 <process_config_tables+0x325>
   441d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441dd:	48 c1 e8 0c          	shr    $0xc,%rax
   441e1:	48 98                	cltq   
   441e3:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   441ea:	00 
   441eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441ef:	48 c1 e8 0c          	shr    $0xc,%rax
   441f3:	48 98                	cltq   
   441f5:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   441fc:	00 
   441fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44201:	48 c1 e8 0c          	shr    $0xc,%rax
   44205:	48 98                	cltq   
   44207:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   4420e:	00 
   4420f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44213:	48 c1 e8 0c          	shr    $0xc,%rax
   44217:	48 98                	cltq   
   44219:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44220:	00 
   44221:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44225:	48 c1 e8 0c          	shr    $0xc,%rax
   44229:	48 98                	cltq   
   4422b:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44232:	00 
   44233:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44237:	48 c1 e8 0c          	shr    $0xc,%rax
   4423b:	48 98                	cltq   
   4423d:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44244:	00 
   44245:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44249:	48 c1 e8 0c          	shr    $0xc,%rax
   4424d:	48 98                	cltq   
   4424f:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44256:	00 
   44257:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4425b:	48 c1 e8 0c          	shr    $0xc,%rax
   4425f:	48 98                	cltq   
   44261:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44268:	00 
   44269:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4426d:	48 c1 e8 0c          	shr    $0xc,%rax
   44271:	48 98                	cltq   
   44273:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   4427a:	00 
   4427b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4427f:	48 c1 e8 0c          	shr    $0xc,%rax
   44283:	48 98                	cltq   
   44285:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   4428c:	00 
   4428d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44292:	eb 27                	jmp    442bb <process_config_tables+0x34c>
   44294:	8b 45 cc             	mov    -0x34(%rbp),%eax
   44297:	48 63 d0             	movslq %eax,%rdx
   4429a:	48 89 d0             	mov    %rdx,%rax
   4429d:	48 c1 e0 04          	shl    $0x4,%rax
   442a1:	48 29 d0             	sub    %rdx,%rax
   442a4:	48 c1 e0 04          	shl    $0x4,%rax
   442a8:	48 8d 90 e0 10 05 00 	lea    0x510e0(%rax),%rdx
   442af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442b3:	48 89 02             	mov    %rax,(%rdx)
   442b6:	b8 00 00 00 00       	mov    $0x0,%eax
   442bb:	c9                   	leaveq 
   442bc:	c3                   	retq   

00000000000442bd <process_load>:
   442bd:	55                   	push   %rbp
   442be:	48 89 e5             	mov    %rsp,%rbp
   442c1:	48 83 ec 20          	sub    $0x20,%rsp
   442c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   442c9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   442cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   442d0:	48 89 05 39 5d 01 00 	mov    %rax,0x15d39(%rip)        # 5a010 <palloc_target_proc>
   442d7:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   442da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   442de:	ba 57 3c 04 00       	mov    $0x43c57,%edx
   442e3:	89 ce                	mov    %ecx,%esi
   442e5:	48 89 c7             	mov    %rax,%rdi
   442e8:	e8 bf ea ff ff       	callq  42dac <program_load>
   442ed:	89 45 fc             	mov    %eax,-0x4(%rbp)
   442f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   442f3:	c9                   	leaveq 
   442f4:	c3                   	retq   

00000000000442f5 <process_setup_stack>:
   442f5:	55                   	push   %rbp
   442f6:	48 89 e5             	mov    %rsp,%rbp
   442f9:	48 83 ec 20          	sub    $0x20,%rsp
   442fd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44301:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44305:	8b 00                	mov    (%rax),%eax
   44307:	89 c7                	mov    %eax,%edi
   44309:	e8 66 f8 ff ff       	callq  43b74 <palloc>
   4430e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44312:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44316:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   4431d:	00 00 30 00 
   44321:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44325:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4432c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44330:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44336:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4433c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44341:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   44346:	48 89 c7             	mov    %rax,%rdi
   44349:	e8 a4 e5 ff ff       	callq  428f2 <virtual_memory_map>
   4434e:	90                   	nop
   4434f:	c9                   	leaveq 
   44350:	c3                   	retq   

0000000000044351 <find_free_pid>:
   44351:	55                   	push   %rbp
   44352:	48 89 e5             	mov    %rsp,%rbp
   44355:	48 83 ec 10          	sub    $0x10,%rsp
   44359:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44360:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   44367:	eb 24                	jmp    4438d <find_free_pid+0x3c>
   44369:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4436c:	48 63 d0             	movslq %eax,%rdx
   4436f:	48 89 d0             	mov    %rdx,%rax
   44372:	48 c1 e0 04          	shl    $0x4,%rax
   44376:	48 29 d0             	sub    %rdx,%rax
   44379:	48 c1 e0 04          	shl    $0x4,%rax
   4437d:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   44383:	8b 00                	mov    (%rax),%eax
   44385:	85 c0                	test   %eax,%eax
   44387:	74 0c                	je     44395 <find_free_pid+0x44>
   44389:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4438d:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   44391:	7e d6                	jle    44369 <find_free_pid+0x18>
   44393:	eb 01                	jmp    44396 <find_free_pid+0x45>
   44395:	90                   	nop
   44396:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4439a:	74 05                	je     443a1 <find_free_pid+0x50>
   4439c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4439f:	eb 05                	jmp    443a6 <find_free_pid+0x55>
   443a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   443a6:	c9                   	leaveq 
   443a7:	c3                   	retq   

00000000000443a8 <process_fork>:
   443a8:	55                   	push   %rbp
   443a9:	48 89 e5             	mov    %rsp,%rbp
   443ac:	48 83 ec 40          	sub    $0x40,%rsp
   443b0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   443b4:	b8 00 00 00 00       	mov    $0x0,%eax
   443b9:	e8 93 ff ff ff       	callq  44351 <find_free_pid>
   443be:	89 45 f4             	mov    %eax,-0xc(%rbp)
   443c1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   443c5:	75 0a                	jne    443d1 <process_fork+0x29>
   443c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   443cc:	e9 67 02 00 00       	jmpq   44638 <process_fork+0x290>
   443d1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   443d4:	48 63 d0             	movslq %eax,%rdx
   443d7:	48 89 d0             	mov    %rdx,%rax
   443da:	48 c1 e0 04          	shl    $0x4,%rax
   443de:	48 29 d0             	sub    %rdx,%rax
   443e1:	48 c1 e0 04          	shl    $0x4,%rax
   443e5:	48 05 00 10 05 00    	add    $0x51000,%rax
   443eb:	be 00 00 00 00       	mov    $0x0,%esi
   443f0:	48 89 c7             	mov    %rax,%rdi
   443f3:	e8 33 da ff ff       	callq  41e2b <process_init>
   443f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   443fb:	89 c7                	mov    %eax,%edi
   443fd:	e8 6d fb ff ff       	callq  43f6f <process_config_tables>
   44402:	83 f8 ff             	cmp    $0xffffffff,%eax
   44405:	75 0a                	jne    44411 <process_fork+0x69>
   44407:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4440c:	e9 27 02 00 00       	jmpq   44638 <process_fork+0x290>
   44411:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   44418:	00 
   44419:	e9 79 01 00 00       	jmpq   44597 <process_fork+0x1ef>
   4441e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44422:	8b 00                	mov    (%rax),%eax
   44424:	48 63 d0             	movslq %eax,%rdx
   44427:	48 89 d0             	mov    %rdx,%rax
   4442a:	48 c1 e0 04          	shl    $0x4,%rax
   4442e:	48 29 d0             	sub    %rdx,%rax
   44431:	48 c1 e0 04          	shl    $0x4,%rax
   44435:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   4443b:	48 8b 08             	mov    (%rax),%rcx
   4443e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44442:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44446:	48 89 ce             	mov    %rcx,%rsi
   44449:	48 89 c7             	mov    %rax,%rdi
   4444c:	e8 64 e8 ff ff       	callq  42cb5 <virtual_memory_lookup>
   44451:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44454:	48 98                	cltq   
   44456:	83 e0 07             	and    $0x7,%eax
   44459:	48 83 f8 07          	cmp    $0x7,%rax
   4445d:	0f 85 a1 00 00 00    	jne    44504 <process_fork+0x15c>
   44463:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44466:	89 c7                	mov    %eax,%edi
   44468:	e8 07 f7 ff ff       	callq  43b74 <palloc>
   4446d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   44471:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   44476:	75 14                	jne    4448c <process_fork+0xe4>
   44478:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4447b:	89 c7                	mov    %eax,%edi
   4447d:	e8 0b f8 ff ff       	callq  43c8d <process_free>
   44482:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44487:	e9 ac 01 00 00       	jmpq   44638 <process_fork+0x290>
   4448c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44490:	48 89 c1             	mov    %rax,%rcx
   44493:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44497:	ba 00 10 00 00       	mov    $0x1000,%edx
   4449c:	48 89 ce             	mov    %rcx,%rsi
   4449f:	48 89 c7             	mov    %rax,%rdi
   444a2:	e8 58 ed ff ff       	callq  431ff <memcpy>
   444a7:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   444ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
   444ae:	48 63 d0             	movslq %eax,%rdx
   444b1:	48 89 d0             	mov    %rdx,%rax
   444b4:	48 c1 e0 04          	shl    $0x4,%rax
   444b8:	48 29 d0             	sub    %rdx,%rax
   444bb:	48 c1 e0 04          	shl    $0x4,%rax
   444bf:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   444c5:	48 8b 00             	mov    (%rax),%rax
   444c8:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   444cc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   444d2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   444d8:	b9 00 10 00 00       	mov    $0x1000,%ecx
   444dd:	48 89 fa             	mov    %rdi,%rdx
   444e0:	48 89 c7             	mov    %rax,%rdi
   444e3:	e8 0a e4 ff ff       	callq  428f2 <virtual_memory_map>
   444e8:	85 c0                	test   %eax,%eax
   444ea:	0f 84 9f 00 00 00    	je     4458f <process_fork+0x1e7>
   444f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   444f3:	89 c7                	mov    %eax,%edi
   444f5:	e8 93 f7 ff ff       	callq  43c8d <process_free>
   444fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   444ff:	e9 34 01 00 00       	jmpq   44638 <process_fork+0x290>
   44504:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44507:	48 98                	cltq   
   44509:	83 e0 05             	and    $0x5,%eax
   4450c:	48 83 f8 05          	cmp    $0x5,%rax
   44510:	75 7d                	jne    4458f <process_fork+0x1e7>
   44512:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   44516:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44519:	48 63 d0             	movslq %eax,%rdx
   4451c:	48 89 d0             	mov    %rdx,%rax
   4451f:	48 c1 e0 04          	shl    $0x4,%rax
   44523:	48 29 d0             	sub    %rdx,%rax
   44526:	48 c1 e0 04          	shl    $0x4,%rax
   4452a:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   44530:	48 8b 00             	mov    (%rax),%rax
   44533:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   44537:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4453d:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   44543:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44548:	48 89 fa             	mov    %rdi,%rdx
   4454b:	48 89 c7             	mov    %rax,%rdi
   4454e:	e8 9f e3 ff ff       	callq  428f2 <virtual_memory_map>
   44553:	85 c0                	test   %eax,%eax
   44555:	74 14                	je     4456b <process_fork+0x1c3>
   44557:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4455a:	89 c7                	mov    %eax,%edi
   4455c:	e8 2c f7 ff ff       	callq  43c8d <process_free>
   44561:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44566:	e9 cd 00 00 00       	jmpq   44638 <process_fork+0x290>
   4456b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4456f:	48 c1 e8 0c          	shr    $0xc,%rax
   44573:	89 c2                	mov    %eax,%edx
   44575:	48 63 c2             	movslq %edx,%rax
   44578:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   4457f:	00 
   44580:	83 c0 01             	add    $0x1,%eax
   44583:	89 c1                	mov    %eax,%ecx
   44585:	48 63 c2             	movslq %edx,%rax
   44588:	88 8c 00 21 1f 05 00 	mov    %cl,0x51f21(%rax,%rax,1)
   4458f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   44596:	00 
   44597:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4459e:	00 
   4459f:	0f 86 79 fe ff ff    	jbe    4441e <process_fork+0x76>
   445a5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   445a9:	8b 08                	mov    (%rax),%ecx
   445ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
   445ae:	48 63 d0             	movslq %eax,%rdx
   445b1:	48 89 d0             	mov    %rdx,%rax
   445b4:	48 c1 e0 04          	shl    $0x4,%rax
   445b8:	48 29 d0             	sub    %rdx,%rax
   445bb:	48 c1 e0 04          	shl    $0x4,%rax
   445bf:	48 8d b0 10 10 05 00 	lea    0x51010(%rax),%rsi
   445c6:	48 63 d1             	movslq %ecx,%rdx
   445c9:	48 89 d0             	mov    %rdx,%rax
   445cc:	48 c1 e0 04          	shl    $0x4,%rax
   445d0:	48 29 d0             	sub    %rdx,%rax
   445d3:	48 c1 e0 04          	shl    $0x4,%rax
   445d7:	48 8d 90 10 10 05 00 	lea    0x51010(%rax),%rdx
   445de:	48 8d 46 08          	lea    0x8(%rsi),%rax
   445e2:	48 83 c2 08          	add    $0x8,%rdx
   445e6:	b9 18 00 00 00       	mov    $0x18,%ecx
   445eb:	48 89 c7             	mov    %rax,%rdi
   445ee:	48 89 d6             	mov    %rdx,%rsi
   445f1:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   445f4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   445f7:	48 63 d0             	movslq %eax,%rdx
   445fa:	48 89 d0             	mov    %rdx,%rax
   445fd:	48 c1 e0 04          	shl    $0x4,%rax
   44601:	48 29 d0             	sub    %rdx,%rax
   44604:	48 c1 e0 04          	shl    $0x4,%rax
   44608:	48 05 18 10 05 00    	add    $0x51018,%rax
   4460e:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   44615:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44618:	48 63 d0             	movslq %eax,%rdx
   4461b:	48 89 d0             	mov    %rdx,%rax
   4461e:	48 c1 e0 04          	shl    $0x4,%rax
   44622:	48 29 d0             	sub    %rdx,%rax
   44625:	48 c1 e0 04          	shl    $0x4,%rax
   44629:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   4462f:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   44635:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44638:	c9                   	leaveq 
   44639:	c3                   	retq   

000000000004463a <process_page_alloc>:
   4463a:	55                   	push   %rbp
   4463b:	48 89 e5             	mov    %rsp,%rbp
   4463e:	48 83 ec 20          	sub    $0x20,%rsp
   44642:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44646:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4464a:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   44651:	00 
   44652:	77 07                	ja     4465b <process_page_alloc+0x21>
   44654:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44659:	eb 4b                	jmp    446a6 <process_page_alloc+0x6c>
   4465b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4465f:	8b 00                	mov    (%rax),%eax
   44661:	89 c7                	mov    %eax,%edi
   44663:	e8 0c f5 ff ff       	callq  43b74 <palloc>
   44668:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4466c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   44671:	74 2e                	je     446a1 <process_page_alloc+0x67>
   44673:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44677:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4467b:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   44682:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   44686:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4468c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   44692:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44697:	48 89 c7             	mov    %rax,%rdi
   4469a:	e8 53 e2 ff ff       	callq  428f2 <virtual_memory_map>
   4469f:	eb 05                	jmp    446a6 <process_page_alloc+0x6c>
   446a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   446a6:	c9                   	leaveq 
   446a7:	c3                   	retq   
