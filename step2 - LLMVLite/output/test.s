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
	jmp	main._end
	.text
main.end:
	movq	$9, %rax
	movq	-8(%rbp), %rbx
	movq	%rbp, %rsp
	popq	%rbp
	retq	