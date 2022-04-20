	.file	"test.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -72(%rbp)
	jmp	.L2
.L5:
	movl	$0, -68(%rbp)
	jmp	.L3
.L4:
	movl	-68(%rbp), %eax
	movslq	%eax, %rdx
	movl	-72(%rbp), %eax
	cltq
	addq	%rax, %rax
	addq	%rdx, %rax
	movl	-64(%rbp,%rax,4), %edx
	movl	-68(%rbp), %eax
	movslq	%eax, %rcx
	movl	-72(%rbp), %eax
	cltq
	addq	%rax, %rax
	addq	%rcx, %rax
	movl	-48(%rbp,%rax,4), %eax
	addl	%eax, %edx
	movl	-68(%rbp), %eax
	movslq	%eax, %rcx
	movl	-72(%rbp), %eax
	cltq
	addq	%rax, %rax
	addq	%rcx, %rax
	movl	%edx, -32(%rbp,%rax,4)
	addl	$1, -68(%rbp)
.L3:
	cmpl	$1, -68(%rbp)
	jle	.L4
	addl	$1, -72(%rbp)
.L2:
	cmpl	$1, -72(%rbp)
	jle	.L5
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L6
	call	__stack_chk_fail@PLT
.L6:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-7ubuntu2) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
