	.text
	.file	"DecafComp"
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
	movb	$0, -1(%rbp)
	movl	$1, -8(%rbp)
	.p2align	4, 0x90
.LBB0_1:                                # %whilestart
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$9, -8(%rbp)
	jg	.LBB0_3
# %bb.2:                                # %whiletrue
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movb	$1, -16(%rax)
	movl	-8(%rbp), %eax
	incl	%eax
	movl	%eax, -8(%rbp)
	cmpl	$6, %eax
	jl	.LBB0_1
.LBB0_3:                                # %whileend
	movl	-8(%rbp), %edi
	callq	print_int
	movzbl	-1(%rbp), %edi
	callq	print_int
	xorl	%eax, %eax
	movq	%rbp, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
