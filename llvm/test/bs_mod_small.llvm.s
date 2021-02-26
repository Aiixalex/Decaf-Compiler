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
	movl	$4, 20(%rsp)
	movl	$3, 16(%rsp)
	movb	16(%rsp), %cl
	movl	$4, %edi
	shll	%cl, %edi
	movl	%edi, 12(%rsp)
	shrl	$2, %edi
	callq	print_int
	movl	$.Lglobalstring, %edi
	callq	print_string
	movl	12(%rsp), %edi
	shrl	$5, %edi
	callq	print_int
	movl	$.Lglobalstring.1, %edi
	callq	print_string
	movl	12(%rsp), %edi
	shrl	$6, %edi
	callq	print_int
	movl	$.Lglobalstring.2, %edi
	callq	print_string
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
	.asciz	"\n"
	.size	.Lglobalstring, 2

	.type	.Lglobalstring.1,@object # @globalstring.1
.Lglobalstring.1:
	.asciz	"\n"
	.size	.Lglobalstring.1, 2

	.type	.Lglobalstring.2,@object # @globalstring.2
.Lglobalstring.2:
	.asciz	"\n"
	.size	.Lglobalstring.2, 2


	.section	".note.GNU-stack","",@progbits
