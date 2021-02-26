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
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB0_2
# %bb.1:                                # %noskct3
	xorl	%eax, %eax
.LBB0_2:                                # %skctend4
	xorl	%ecx, %ecx
	testb	%cl, %cl
	jne	.LBB0_4
# %bb.3:                                # %noskct1
	xorl	%eax, %eax
.LBB0_4:                                # %skctend2
	xorl	%ecx, %ecx
	testb	%cl, %cl
	jne	.LBB0_6
# %bb.5:                                # %noskct
	movb	$1, %al
.LBB0_6:                                # %skctend
	testb	%al, %al
	je	.LBB0_9
# %bb.7:                                # %iftrue
	movl	$.Lglobalstring, %edi
	callq	print_string
	xorl	%eax, %eax
	testb	%al, %al
	je	.LBB0_9
# %bb.8:                                # %iftrue26
	movl	$.Lglobalstring.1, %edi
	callq	print_string
.LBB0_9:                                # %iffalse
	movl	$.Lglobalstring.2, %edi
	callq	print_string
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
	.asciz	"O"
	.size	.Lglobalstring, 2

	.type	.Lglobalstring.1,@object # @globalstring.1
.Lglobalstring.1:
	.asciz	"NO"
	.size	.Lglobalstring.1, 3

	.type	.Lglobalstring.2,@object # @globalstring.2
.Lglobalstring.2:
	.asciz	"K"
	.size	.Lglobalstring.2, 2


	.section	".note.GNU-stack","",@progbits
