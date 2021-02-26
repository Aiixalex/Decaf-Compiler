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
	.type	list,@object            # @list
	.bss
	.globl	list
	.p2align	4
list:
	.zero	400
	.size	list, 400


	.section	".note.GNU-stack","",@progbits
