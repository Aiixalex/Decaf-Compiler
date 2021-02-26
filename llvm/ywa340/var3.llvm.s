	.text
	.file	"DecafComp"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	$0, 8(%rsp)
	movl	$0, 16(%rsp)
	movl	$0, 12(%rsp)
	movl	$0, 20(%rsp)
	cmpl	$0, 8(%rsp)
	jne	.LBB0_2
# %bb.1:                                # %iftrue
	movl	8(%rsp), %edi
	callq	print_int
	movl	16(%rsp), %edi
	callq	print_int
	movl	12(%rsp), %edi
	callq	print_int
	movl	20(%rsp), %edi
	callq	print_int
.LBB0_2:                                # %iffalse
	movl	$1, 8(%rsp)
	movl	$1, 16(%rsp)
	movl	$1, 12(%rsp)
	cmpl	$1, 8(%rsp)
	jne	.LBB0_4
# %bb.3:                                # %iftrue7
	movl	8(%rsp), %edi
	callq	print_int
	movl	16(%rsp), %edi
	callq	print_int
	movl	12(%rsp), %edi
	callq	print_int
.LBB0_4:                                # %iffalse8
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
