	.text
	.file	"DecafComp"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1, 4(%rsp)
	cmpl	$9, 4(%rsp)
	jg	.LBB0_3
	.p2align	4, 0x90
.LBB0_2:                                # %whiletrue
                                        # =>This Inner Loop Header: Depth=1
	movl	4(%rsp), %edi
	callq	print_int
	incl	4(%rsp)
	cmpl	$9, 4(%rsp)
	jle	.LBB0_2
.LBB0_3:                                # %whileend
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
