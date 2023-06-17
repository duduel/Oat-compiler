	.text
	.globl	_factorial
_factorial:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$8, %rsp
	movq	%rdi, %r10
	movq	%r10, (%rsp)
	subq	$112, %rsp
	subq	$8, %rsp
	movq	%rsp, -24(%rbp)
	subq	$8, %rsp
	movq	%rsp, -32(%rbp)
	movq	-16(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, (%rax)
	movq	$1, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, (%rax)
	jmp	factorial._start
	.text
factorial.start:
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rax
	movq	%rax, -56(%rbp)
	movq	$0, %rcx
	movq	-56(%rbp), %rax
	cmpq	%rcx, %rax
	setg	-64(%rbp)
	andq	$1, -64(%rbp)
	movq	-64(%rbp), %rdx
	cmpq	$1, %rdx
	jne	factorial._end
	.text
factorial.then:
	movq	-32(%rbp), %rcx
	movq	(%rcx), %rax
	movq	%rax, -72(%rbp)
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rcx
	movq	-72(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rax
	movq	%rax, -104(%rbp)
	movq	$1, %rcx
	movq	-104(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, (%rax)
	jmp	factorial._start
	.text
factorial.end:
	movq	-32(%rbp), %rcx
	movq	(%rcx), %rax
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	_main
_main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$8, %rsp
	movq	%rdi, %r10
	movq	%r10, (%rsp)
	subq	$8, %rsp
	movq	%rsi, %r10
	movq	%r10, (%rsp)
	subq	$24, %rsp
	subq	$8, %rsp
	movq	%rsp, -32(%rbp)
	movq	$0, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, (%rax)
	movq	$5, %r11
	movq	%r11, %rdi
	subq	$8, %rsp
	leaq	_factorial(%rip), %rax
	callq	*%rax
	movq	%rax, -48(%rbp)
	addq	$8, %rsp
	movq	-48(%rbp), %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	