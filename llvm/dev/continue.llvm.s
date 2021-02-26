	.text
	.file	"DecafComp"
	.globl	f                       # -- Begin function f
	.p2align	4, 0x90
	.type	f,@function
f:                                      # @f
	.cfi_startproc
# %bb.0:                                # %entry
	.p2align	4, 0x90
.LBB0_1:                                # %whilestart
                                        # =>This Inner Loop Header: Depth=1
	jmp	.LBB0_1
.Lfunc_end0:
	.size	f, .Lfunc_end0-f
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
