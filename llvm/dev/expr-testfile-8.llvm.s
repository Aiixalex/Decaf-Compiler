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
	movb	$0, 11(%rsp)
	movl	$958, 12(%rsp)          # imm = 0x3BE
	movl	$80, 20(%rsp)
	movl	$-80, 16(%rsp)
	cmpb	$0, 11(%rsp)
	jne	.LBB0_2
# %bb.1:                                # %iftrue
	movl	12(%rsp), %edi
	callq	print_int
.LBB0_2:                                # %iffalse
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
