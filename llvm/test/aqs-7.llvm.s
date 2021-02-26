	.text
	.file	"Test"
	.globl	quickSort               # -- Begin function quickSort
	.p2align	4, 0x90
	.type	quickSort,@function
quickSort:                              # @quickSort
	.cfi_startproc
# %bb.0:                                # %entry
	movl	%edi, -4(%rsp)
	movl	%esi, -8(%rsp)
	retq
.Lfunc_end0:
	.size	quickSort, .Lfunc_end0-quickSort
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
