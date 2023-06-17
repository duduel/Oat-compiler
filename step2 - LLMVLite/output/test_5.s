	.text
	.globl	_foo
_foo:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	movq	$42, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	_bar
_bar:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	movq	$0, %rax
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
	subq	$88, %rsp
	subq	$8, %rsp
	movq	%rsp, -32(%rbp)
	subq	$8, %rsp
	movq	%rsp, -40(%rbp)
	movq	$0, %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, (%rax)
	movq	$100, %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, (%rax)
	movq	-40(%rbp), %rcx
	movq	(%rcx), %rax
	movq	%rax, -64(%rbp)
	movq	$0, %rcx
	movq	-64(%rbp), %rax
	cmpq	%rcx, %rax
	setne	-72(%rbp)
	andq	$1, -72(%rbp)
	movq	-72(%rbp), %rdx
	cmpq	$1, %rdx
	jne	main._else
	.text
main.then:
	subq	$8, %rsp
	leaq	_foo(%rip), %rax
	callq	*%rax
	movq	%rax, -80(%rbp)
	addq	$8, %rsp
	movq	-80(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, (%rax)
	jmp	main._end
	.text
main.else:
	subq	$8, %rsp
	leaq	_bar(%rip), %rax
	callq	*%rax
	movq	%rax, -96(%rbp)
	addq	$8, %rsp
	movq	-96(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, (%rax)
	jmp	main._end
	.text
main.end:
	movq	-32(%rbp), %rcx
	movq	(%rcx), %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	