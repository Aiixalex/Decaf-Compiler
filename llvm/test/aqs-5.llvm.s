	.text
	.file	"Test"
	.globl	initList                # -- Begin function initList
	.p2align	4, 0x90
	.type	initList,@function
initList:                               # @initList
	.cfi_startproc
# %bb.0:                                # %entry
	movl	%edi, -8(%rsp)
	retq
.Lfunc_end0:
	.size	initList, .Lfunc_end0-initList
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
