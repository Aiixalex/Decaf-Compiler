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
	movl	$1, %edi
	callq	print_int
	movl	$2, %edi
	callq	print_int
	xorl	%edi, %edi
	callq	print_int
	movl	$.Lglobalstring, %edi
	callq	print_string
	movl	$-1, %edi
	callq	print_int
	movl	$-2, %edi
	callq	print_int
	xorl	%edi, %edi
	callq	print_int
	movl	$.Lglobalstring.1, %edi
	callq	print_string
	movl	$1, %edi
	callq	print_int
	movl	$2, %edi
	callq	print_int
	xorl	%edi, %edi
	callq	print_int
	movl	$.Lglobalstring.2, %edi
	callq	print_string
	movl	$-1, %edi
	callq	print_int
	movl	$-2, %edi
	callq	print_int
	xorl	%edi, %edi
	callq	print_int
	movl	$.Lglobalstring.3, %edi
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

	.type	.Lglobalstring.3,@object # @globalstring.3
.Lglobalstring.3:
	.asciz	"\n"
	.size	.Lglobalstring.3, 2


	.section	".note.GNU-stack","",@progbits
