	.text
	.file	"DecafComp"
	.globl	f                       # -- Begin function f
	.p2align	4, 0x90
	.type	f,@function
f:                                      # @f
	.cfi_startproc
# %bb.0:                                # %entry
	movl	$0, -4(%rsp)
	movl	$0, -8(%rsp)
	movl	$100, size(%rip)
	retq
.Lfunc_end0:
	.size	f, .Lfunc_end0-f
	.cfi_endproc
                                        # -- End function
	.type	x,@object               # @x
	.local	x
	.comm	x,4,4
	.type	size,@object            # @size
	.local	size
	.comm	size,4,4

	.section	".note.GNU-stack","",@progbits
