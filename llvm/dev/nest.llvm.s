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
	movl	$0, 4(%rsp)
	movl	$0, 8(%rsp)
	movl	$0, 12(%rsp)
	movl	$0, 16(%rsp)
	movl	$0, 20(%rsp)
	movl	$.Lglobalstring, %edi
	callq	print_string
	movl	$0, 20(%rsp)
	movl	$0, 4(%rsp)
	cmpl	$9, 4(%rsp)
	jle	.LBB0_2
	jmp	.LBB0_11
	.p2align	4, 0x90
.LBB0_3:                                # %fornext
                                        #   in Loop: Header=BB0_2 Depth=1
	incl	4(%rsp)
	cmpl	$9, 4(%rsp)
	jg	.LBB0_11
.LBB0_2:                                # %fortrue
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_6 Depth 2
                                        #       Child Loop BB0_14 Depth 3
                                        #         Child Loop BB0_22 Depth 4
	cmpl	$5, 4(%rsp)
	je	.LBB0_3
# %bb.4:                                # %iffalse
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	$0, 8(%rsp)
	cmpl	$9, 8(%rsp)
	jle	.LBB0_6
	jmp	.LBB0_10
	.p2align	4, 0x90
.LBB0_9:                                # %fornext5
                                        #   in Loop: Header=BB0_6 Depth=2
	incl	8(%rsp)
	cmpl	$9, 8(%rsp)
	jg	.LBB0_10
.LBB0_6:                                # %fortrue4
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_14 Depth 3
                                        #         Child Loop BB0_22 Depth 4
	cmpl	$2, 4(%rsp)
	sete	%al
	jne	.LBB0_8
# %bb.7:                                # %noskct
                                        #   in Loop: Header=BB0_6 Depth=2
	cmpl	$4, 8(%rsp)
	sete	%al
.LBB0_8:                                # %skctend
                                        #   in Loop: Header=BB0_6 Depth=2
	testb	%al, %al
	jne	.LBB0_9
# %bb.12:                               # %iffalse11
                                        #   in Loop: Header=BB0_6 Depth=2
	movl	$0, 12(%rsp)
	cmpl	$9, 12(%rsp)
	jle	.LBB0_14
	jmp	.LBB0_37
	.p2align	4, 0x90
.LBB0_19:                               # %fornext18
                                        #   in Loop: Header=BB0_14 Depth=3
	incl	12(%rsp)
	cmpl	$9, 12(%rsp)
	jg	.LBB0_37
.LBB0_14:                               # %fortrue17
                                        #   Parent Loop BB0_2 Depth=1
                                        #     Parent Loop BB0_6 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_22 Depth 4
	cmpl	$8, 4(%rsp)
	sete	%al
	je	.LBB0_15
# %bb.16:                               # %skctend28
                                        #   in Loop: Header=BB0_14 Depth=3
	testb	%al, %al
	jne	.LBB0_17
.LBB0_18:                               # %skctend26
                                        #   in Loop: Header=BB0_14 Depth=3
	testb	%al, %al
	jne	.LBB0_19
	jmp	.LBB0_20
	.p2align	4, 0x90
.LBB0_15:                               # %noskct27
                                        #   in Loop: Header=BB0_14 Depth=3
	cmpl	$1, 8(%rsp)
	sete	%al
	testb	%al, %al
	je	.LBB0_18
.LBB0_17:                               # %noskct25
                                        #   in Loop: Header=BB0_14 Depth=3
	cmpl	$3, 12(%rsp)
	sete	%al
	testb	%al, %al
	jne	.LBB0_19
.LBB0_20:                               # %iffalse24
                                        #   in Loop: Header=BB0_14 Depth=3
	movl	$0, 16(%rsp)
	cmpl	$9, 16(%rsp)
	jle	.LBB0_22
	jmp	.LBB0_32
	.p2align	4, 0x90
.LBB0_29:                               # %fornext39
                                        #   in Loop: Header=BB0_22 Depth=4
	incl	16(%rsp)
	cmpl	$9, 16(%rsp)
	jg	.LBB0_32
.LBB0_22:                               # %fortrue38
                                        #   Parent Loop BB0_2 Depth=1
                                        #     Parent Loop BB0_6 Depth=2
                                        #       Parent Loop BB0_14 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cmpl	$1, 4(%rsp)
	sete	%al
	je	.LBB0_23
# %bb.24:                               # %skctend51
                                        #   in Loop: Header=BB0_22 Depth=4
	testb	%al, %al
	jne	.LBB0_25
.LBB0_26:                               # %skctend49
                                        #   in Loop: Header=BB0_22 Depth=4
	testb	%al, %al
	jne	.LBB0_27
.LBB0_28:                               # %skctend47
                                        #   in Loop: Header=BB0_22 Depth=4
	testb	%al, %al
	jne	.LBB0_29
	jmp	.LBB0_42
	.p2align	4, 0x90
.LBB0_23:                               # %noskct50
                                        #   in Loop: Header=BB0_22 Depth=4
	cmpl	$7, 8(%rsp)
	sete	%al
	testb	%al, %al
	je	.LBB0_26
.LBB0_25:                               # %noskct48
                                        #   in Loop: Header=BB0_22 Depth=4
	cmpl	$4, 12(%rsp)
	sete	%al
	testb	%al, %al
	je	.LBB0_28
.LBB0_27:                               # %noskct46
                                        #   in Loop: Header=BB0_22 Depth=4
	cmpl	$1, 16(%rsp)
	sete	%al
	testb	%al, %al
	jne	.LBB0_29
.LBB0_42:                               # %iffalse45
                                        #   in Loop: Header=BB0_22 Depth=4
	incl	20(%rsp)
	cmpl	$3, 4(%rsp)
	sete	%al
	jne	.LBB0_44
# %bb.43:                               # %noskct71
                                        #   in Loop: Header=BB0_22 Depth=4
	cmpl	$2, 8(%rsp)
	sete	%al
.LBB0_44:                               # %skctend72
                                        #   in Loop: Header=BB0_22 Depth=4
	testb	%al, %al
	je	.LBB0_41
# %bb.40:                               # %noskct69
                                        #   in Loop: Header=BB0_22 Depth=4
	cmpl	$6, 12(%rsp)
	sete	%al
.LBB0_41:                               # %skctend70
                                        #   in Loop: Header=BB0_22 Depth=4
	testb	%al, %al
	je	.LBB0_31
# %bb.30:                               # %noskct67
                                        #   in Loop: Header=BB0_22 Depth=4
	cmpl	$4, 16(%rsp)
	sete	%al
.LBB0_31:                               # %skctend68
                                        #   in Loop: Header=BB0_22 Depth=4
	testb	%al, %al
	je	.LBB0_29
.LBB0_32:                               # %forend40
                                        #   in Loop: Header=BB0_14 Depth=3
	cmpl	$2, 4(%rsp)
	sete	%al
	je	.LBB0_33
# %bb.34:                               # %skctend92
                                        #   in Loop: Header=BB0_14 Depth=3
	testb	%al, %al
	jne	.LBB0_35
.LBB0_36:                               # %skctend90
                                        #   in Loop: Header=BB0_14 Depth=3
	testb	%al, %al
	je	.LBB0_19
	jmp	.LBB0_37
	.p2align	4, 0x90
.LBB0_33:                               # %noskct91
                                        #   in Loop: Header=BB0_14 Depth=3
	cmpl	$7, 8(%rsp)
	sete	%al
	testb	%al, %al
	je	.LBB0_36
.LBB0_35:                               # %noskct89
                                        #   in Loop: Header=BB0_14 Depth=3
	cmpl	$2, 12(%rsp)
	sete	%al
	testb	%al, %al
	je	.LBB0_19
	.p2align	4, 0x90
.LBB0_37:                               # %forend19
                                        #   in Loop: Header=BB0_6 Depth=2
	cmpl	$9, 4(%rsp)
	sete	%al
	jne	.LBB0_39
# %bb.38:                               # %noskct106
                                        #   in Loop: Header=BB0_6 Depth=2
	cmpl	$1, 8(%rsp)
	sete	%al
.LBB0_39:                               # %skctend107
                                        #   in Loop: Header=BB0_6 Depth=2
	testb	%al, %al
	je	.LBB0_9
.LBB0_10:                               # %forend6
                                        #   in Loop: Header=BB0_2 Depth=1
	cmpl	$9, 4(%rsp)
	jne	.LBB0_3
.LBB0_11:                               # %forend
	movl	20(%rsp), %edi
	callq	print_int
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.Lglobalstring,@object  # @globalstring
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lglobalstring:
	.asciz	"hello\n"
	.size	.Lglobalstring, 7


	.section	".note.GNU-stack","",@progbits
