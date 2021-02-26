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
	movl	$1, 20(%rsp)
	movl	$100, (%rsp)
	movl	$1, %edi
	callq	print_int
	movl	(%rsp), %edi
	callq	print_int
	movl	$2, 16(%rsp)
	movl	$2, %edi
	callq	print_int
	movl	(%rsp), %edi
	callq	print_int
	movl	$3, 12(%rsp)
	movl	$3, %edi
	callq	print_int
	movl	(%rsp), %edi
	callq	print_int
	movl	$4, 8(%rsp)
	movl	$4, %edi
	callq	print_int
	movl	(%rsp), %edi
	callq	print_int
	movl	$5, 4(%rsp)
	movl	$5, %edi
	callq	print_int
	movl	(%rsp), %edi
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
