	.text
	.globl	_factorial
_factorial:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$8, %rsp
	movq	%rdi, %r10
	movq	%r10, (%rsp)
	subq	$32, %rsp
	movq	$0, %rcx
	movq	-16(%rbp), %rax
	cmpq	%rcx, %rax
	sete	-24(%rbp)
	andq	$1, -24(%rbp)
	movq	-24(%rbp), %rdx
	cmpq	$1, %rdx
	jne	factorial._recurse
	.text
factorial.ret1:
	movq	$1, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
factorial.recurse:
	movq	$1, %rcx
	movq	-16(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %r11
	movq	%r11, %rdi
	subq	$8, %rsp
	leaq	_factorial(%rip), %rax
	callq	*%rax
	movq	%rax, -40(%rbp)
	addq	$8, %rsp
	movq	-40(%rbp), %rcx
	movq	-16(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
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
	subq	$8, %rsp
	movq	$5, %r11
	movq	%r11, %rdi
	subq	$8, %rsp
	leaq	_factorial(%rip), %rax
	callq	*%rax
	movq	%rax, -32(%rbp)
	addq	$8, %rsp
	movq	-32(%rbp), %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	