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
	movq	$12, %rcx
	movq	$5, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	jmp	main._next
	.text
main.next:
	jmp	main._end
	.text
main.end:
	movq	-32(%rbp), %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	