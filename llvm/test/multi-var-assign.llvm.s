	.text
	.file	"DecafComp"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	a,@object               # @a
	.data
	.p2align	2
a:
	.long	3                       # 0x3
	.size	a, 4

	.type	b,@object               # @b
	.p2align	2
b:
	.long	3                       # 0x3
	.size	b, 4

	.type	c,@object               # @c
	.p2align	2
c:
	.long	3                       # 0x3
	.size	c, 4


	.section	".note.GNU-stack","",@progbits
