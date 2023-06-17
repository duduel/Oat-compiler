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
	movq	$0, %rcx
	movq	$3, %rax
	cmpq	%rcx, %rax
	setg	-32(%rbp)
	andq	$1, -32(%rbp)
	movq	-32(%rbp), %rdx
	cmpq	$1, %rdx
	jne	main._else
	.text
main.then:
	movq	$7, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.else:
	movq	$9, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	