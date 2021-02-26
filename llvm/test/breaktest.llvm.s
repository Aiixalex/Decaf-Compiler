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
	movl	$0, 4(%rsp)
	cmpl	$19, 4(%rsp)
	jle	.LBB0_2
	jmp	.LBB0_9
	.p2align	4, 0x90
.LBB0_3:                                # %fornext
                                        #   in Loop: Header=BB0_2 Depth=1
	incl	4(%rsp)
	cmpl	$19, 4(%rsp)
	jg	.LBB0_9
.LBB0_2:                                # %fortrue
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$1, 4(%rsp)
	jle	.LBB0_3
# %bb.4:                                # %iftrue
                                        #   in Loop: Header=BB0_2 Depth=1
	cmpl	$3, 4(%rsp)
	jl	.LBB0_3
# %bb.5:                                # %iftrue4
                                        #   in Loop: Header=BB0_2 Depth=1
	cmpl	$4, 4(%rsp)
	jl	.LBB0_3
# %bb.6:                                # %iftrue9
                                        #   in Loop: Header=BB0_2 Depth=1
	cmpl	$10, 4(%rsp)
	jl	.LBB0_3
# %bb.7:                                # %iffalse15
                                        #   in Loop: Header=BB0_2 Depth=1
	cmpl	$14, 4(%rsp)
	jg	.LBB0_3
# %bb.8:                                # %iftrue19
	movl	4(%rsp), %edi
	callq	print_int
.LBB0_9:                                # %forend
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
