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
	movl	$0, 20(%rsp)
	movl	$0, 16(%rsp)
	movl	$0, 12(%rsp)
	movl	$0, 8(%rsp)
	xorl	%edi, %edi
	callq	print_int
	movl	16(%rsp), %edi
	callq	print_int
	movl	12(%rsp), %edi
	callq	print_int
	movl	8(%rsp), %edi
	callq	print_int
	movl	$1, 20(%rsp)
	movl	$1, 16(%rsp)
	movl	$1, 12(%rsp)
	movl	$1, 8(%rsp)
	movl	$1, %edi
	callq	print_int
	movl	16(%rsp), %edi
	callq	print_int
	movl	12(%rsp), %edi
	callq	print_int
	movl	8(%rsp), %edi
	callq	print_int
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
