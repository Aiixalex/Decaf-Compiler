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
	movl	$0, (%rsp)
	movl	$.Lglobalstring, %edi
	callq	print_string
	movl	$0, 4(%rsp)
	jmp	.LBB0_1
	.p2align	4, 0x90
.LBB0_4:                                # %iftrue5
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$100, 4(%rsp)
.LBB0_1:                                # %whilestart
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_6 Depth 2
	cmpl	$9, 4(%rsp)
	jg	.LBB0_12
# %bb.2:                                # %whiletrue
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	4(%rsp), %eax
	incl	%eax
	movl	%eax, 4(%rsp)
	cmpl	$5, %eax
	je	.LBB0_1
# %bb.3:                                # %iffalse
                                        #   in Loop: Header=BB0_1 Depth=1
	cmpl	$7, 4(%rsp)
	je	.LBB0_4
# %bb.5:                                # %iffalse6
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$0, (%rsp)
	jmp	.LBB0_6
	.p2align	4, 0x90
.LBB0_11:                               # %iffalse24
                                        #   in Loop: Header=BB0_6 Depth=2
	movl	4(%rsp), %edi
	callq	print_int
	movl	$.Lglobalstring.1, %edi
	callq	print_string
	movl	(%rsp), %edi
	callq	print_int
	movl	$.Lglobalstring.2, %edi
	callq	print_string
.LBB0_6:                                # %whilestart9
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$9, (%rsp)
	jg	.LBB0_1
# %bb.7:                                # %whiletrue10
                                        #   in Loop: Header=BB0_6 Depth=2
	movl	(%rsp), %eax
	incl	%eax
	movl	%eax, (%rsp)
	cmpl	$3, %eax
	setg	%al
	jle	.LBB0_9
# %bb.8:                                # %noskct
                                        #   in Loop: Header=BB0_6 Depth=2
	cmpl	$5, (%rsp)
	setl	%al
.LBB0_9:                                # %skctend
                                        #   in Loop: Header=BB0_6 Depth=2
	testb	%al, %al
	jne	.LBB0_6
# %bb.10:                               # %iffalse18
                                        #   in Loop: Header=BB0_6 Depth=2
	cmpl	$7, (%rsp)
	jne	.LBB0_11
	jmp	.LBB0_1
.LBB0_12:                               # %whileend
	xorl	%eax, %eax
	popq	%rcx
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

	.type	.Lglobalstring.1,@object # @globalstring.1
.Lglobalstring.1:
	.asciz	","
	.size	.Lglobalstring.1, 2

	.type	.Lglobalstring.2,@object # @globalstring.2
.Lglobalstring.2:
	.asciz	"\n"
	.size	.Lglobalstring.2, 2


	.section	".note.GNU-stack","",@progbits
