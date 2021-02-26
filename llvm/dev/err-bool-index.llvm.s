	.text
	.file	"DecafComp"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	movl	xs-4(%rip), %eax
	movl	%eax, -4(%rsp)
	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	xs,@object              # @xs
	.bss
	.globl	xs
	.p2align	4
xs:
	.zero	40
	.size	xs, 40


	.section	".note.GNU-stack","",@progbits
