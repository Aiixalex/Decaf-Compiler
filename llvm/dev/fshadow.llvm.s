	.text
	.file	"DecafComp"
	.globl	i                       # -- Begin function i
	.p2align	4, 0x90
	.type	i,@function
i:                                      # @i
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -8(%rbp)
	movl	$0, -4(%rbp)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB0_2
# %bb.1:                                # %iftrue
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movl	$2, -16(%rax)
.LBB0_2:                                # %iffalse
	cmpl	$2, -4(%rbp)
	jg	.LBB0_4
# %bb.3:                                # %iffalse7
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movl	$6, -16(%rax)
.LBB0_4:                                # %end
	movl	-4(%rbp), %edi
	callq	print_int
	movl	$.Lglobalstring, %edi
	callq	print_string
	xorl	%eax, %eax
	movq	%rbp, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	i, .Lfunc_end0-i
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$.Lglobalstring.1, %edi
	callq	print_string
	movl	$0, -4(%rbp)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB1_2
# %bb.1:                                # %iftrue
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movl	$2, -16(%rax)
.LBB1_2:                                # %iffalse
	cmpl	$2, -4(%rbp)
	jg	.LBB1_4
# %bb.3:                                # %iffalse5
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movl	$6, -16(%rax)
.LBB1_4:                                # %end
	movl	-4(%rbp), %edi
	callq	print_int
	movl	$.Lglobalstring.2, %edi
	callq	print_string
	xorl	%eax, %eax
	movq	%rbp, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	.Lglobalstring,@object  # @globalstring
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lglobalstring:
	.asciz	",\r\n"
	.size	.Lglobalstring, 4

	.type	.Lglobalstring.1,@object # @globalstring.1
.Lglobalstring.1:
	.asciz	"hello\n"
	.size	.Lglobalstring.1, 7

	.type	.Lglobalstring.2,@object # @globalstring.2
.Lglobalstring.2:
	.asciz	",\r\n"
	.size	.Lglobalstring.2, 4


	.section	".note.GNU-stack","",@progbits
