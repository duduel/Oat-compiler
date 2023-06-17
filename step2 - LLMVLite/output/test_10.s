	.data
	.globl	_toofew
_toofew:
	.asciz	"argc < 3"
	.data
	.globl	_toomany
_toomany:
	.asciz	"argc > 3"
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
	subq	$96, %rsp
	movq	$3, %rcx
	movq	-16(%rbp), %rax
	cmpq	%rcx, %rax
	setl	-32(%rbp)
	andq	$1, -32(%rbp)
	movq	-32(%rbp), %rdx
	cmpq	$1, %rdx
	jne	main._else
	.text
main.few:
	leaq	_toofew(%rip), %r9 
	movq	$0, %rdx
	movq	$0, %rcx
	imulq	%rcx, %rdx
	addq	%rdx, %r9 
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %r9 
	movq	%r9 , -40(%rbp)
	movq	-40(%rbp), %r11
	movq	%r11, %rdi
	subq	$8, %rsp
	leaq	_ll_puts(%rip), %rax
	callq	*%rax
	movq	%rax, -48(%rbp)
	addq	$8, %rsp
	movq	$0, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.else:
	movq	$3, %rcx
	movq	-16(%rbp), %rax
	cmpq	%rcx, %rax
	setg	-56(%rbp)
	andq	$1, -56(%rbp)
	movq	-56(%rbp), %rdx
	cmpq	$1, %rdx
	jne	main._right
	.text
main.many:
	leaq	_toomany(%rip), %r9 
	movq	$0, %rdx
	movq	$0, %rcx
	imulq	%rcx, %rdx
	addq	%rdx, %r9 
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %r9 
	movq	%r9 , -64(%rbp)
	movq	-64(%rbp), %r11
	movq	%r11, %rdi
	subq	$8, %rsp
	leaq	_ll_puts(%rip), %rax
	callq	*%rax
	movq	%rax, -72(%rbp)
	addq	$8, %rsp
	movq	$0, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.right:
	movq	-24(%rbp), %r9 
	movq	$8, %rdx
	movq	$1, %rcx
	imulq	%rcx, %rdx
	addq	%rdx, %r9 
	movq	%r9 , -80(%rbp)
	movq	-80(%rbp), %rcx
	movq	(%rcx), %rax
	movq	%rax, -88(%rbp)
	movq	-24(%rbp), %r9 
	movq	$8, %rdx
	movq	$2, %rcx
	imulq	%rcx, %rdx
	addq	%rdx, %r9 
	movq	%r9 , -96(%rbp)
	movq	-96(%rbp), %rcx
	movq	(%rcx), %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %r11
	movq	%r11, %rsi
	movq	-88(%rbp), %r11
	movq	%r11, %rdi
	subq	$8, %rsp
	leaq	_ll_strcat(%rip), %rax
	callq	*%rax
	movq	%rax, -112(%rbp)
	addq	$8, %rsp
	movq	-112(%rbp), %r11
	movq	%r11, %rdi
	subq	$8, %rsp
	leaq	_ll_puts(%rip), %rax
	callq	*%rax
	movq	%rax, -120(%rbp)
	addq	$8, %rsp
	movq	$0, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	