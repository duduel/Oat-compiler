	.text
	.globl	_f1
_f1:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$8, %rsp
	movq	%rdi, %r10
	movq	%r10, (%rsp)
	subq	$8, %rsp
	jmp	f1._start
	.text
f1.start:
	movq	$10, %rcx
	movq	-16(%rbp), %rax
	cmpq	%rcx, %rax
	setg	-24(%rbp)
	andq	$1, -24(%rbp)
	movq	-24(%rbp), %rdx
	cmpq	$1, %rdx
	jne	f1._end
	.text
f1.then:
	movq	$1, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
f1.end:
	movq	$0, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	_f2
_f2:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$8, %rsp
	movq	%rdi, %r10
	movq	%r10, (%rsp)
	subq	$8, %rsp
	jmp	f2._start
	.text
f2.start:
	movq	$10, %rcx
	movq	-16(%rbp), %rax
	cmpq	%rcx, %rax
	setg	-24(%rbp)
	andq	$1, -24(%rbp)
	movq	-24(%rbp), %rdx
	cmpq	$1, %rdx
	jne	f2._end
	.text
f2.then:
	movq	$1, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
f2.end:
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
	subq	$24, %rsp
	movq	$0, %r11
	movq	%r11, %rdi
	subq	$8, %rsp
	leaq	_f1(%rip), %rax
	callq	*%rax
	movq	%rax, -32(%rbp)
	addq	$8, %rsp
	movq	$15, %r11
	movq	%r11, %rdi
	subq	$8, %rsp
	leaq	_f2(%rip), %rax
	callq	*%rax
	movq	%rax, -40(%rbp)
	addq	$8, %rsp
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	