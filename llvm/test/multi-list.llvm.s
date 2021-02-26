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
	.bss
	.globl	a
	.p2align	4
a:
	.zero	400
	.size	a, 400

	.type	b,@object               # @b
	.globl	b
	.p2align	4
b:
	.zero	400
	.size	b, 400

	.type	c,@object               # @c
	.globl	c
	.p2align	4
c:
	.zero	400
	.size	c, 400


	.section	".note.GNU-stack","",@progbits
