	.text
	.file	"DecafComp"
	.globl	sqrt                    # -- Begin function sqrt
	.p2align	4, 0x90
	.type	sqrt,@function
sqrt:                                   # @sqrt
	.cfi_startproc
# %bb.0:                                # %entry
	movl	%edi, -4(%rsp)
	movl	$0, -16(%rsp)
	movl	%edi, -8(%rsp)
	movl	$1073741824, -12(%rsp)  # imm = 0x40000000
	cmpl	$0, -12(%rsp)
	jne	.LBB0_2
	jmp	.LBB0_5
	.p2align	4, 0x90
.LBB0_4:                                # %iffalse
                                        #   in Loop: Header=BB0_2 Depth=1
	shrl	-16(%rsp)
	shrl	$2, -12(%rsp)
	cmpl	$0, -12(%rsp)
	je	.LBB0_5
.LBB0_2:                                # %whiletrue
                                        # =>This Inner Loop Header: Depth=1
	movl	-16(%rsp), %eax
	addl	-12(%rsp), %eax
	cmpl	%eax, -8(%rsp)
	jl	.LBB0_4
# %bb.3:                                # %iftrue
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	-16(%rsp), %eax
	movl	-12(%rsp), %ecx
	leal	(%rax,%rcx), %edx
	subl	%edx, -8(%rsp)
	leal	(%rax,%rcx,2), %eax
	movl	%eax, -16(%rsp)
	jmp	.LBB0_4
.LBB0_5:                                # %whileend
	movl	-16(%rsp), %eax
	retq
.Lfunc_end0:
	.size	sqrt, .Lfunc_end0-sqrt
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
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movl	$0, -20(%rbp)
	movl	$.Lglobalstring, %edi
	callq	print_string
	movl	$1, -20(%rbp)
	cmpl	$19, -20(%rbp)
	jg	.LBB1_3
	.p2align	4, 0x90
.LBB1_2:                                # %fortrue
                                        # =>This Inner Loop Header: Depth=1
	movq	%rsp, %r14
	leaq	-16(%r14), %rsp
	movl	$0, -16(%r14)
	movl	-20(%rbp), %eax
	movl	%eax, %ecx
	imull	%ecx, %ecx
	leal	(,%rcx,8), %ebx
	subl	%ecx, %ebx
	addl	$3, %ebx
	leal	(%rcx,%rcx,2), %ecx
	leal	1(%rcx,%rax,2), %edi
	callq	sqrt
	subl	%eax, %ebx
	movl	-20(%rbp), %ecx
	addl	%ecx, %ecx
	movl	%ebx, %eax
	cltd
	idivl	%ecx
	movl	%eax, -16(%r14)
	movl	%eax, %edi
	callq	print_int
	movl	$.Lglobalstring.1, %edi
	callq	print_string
	incl	-20(%rbp)
	cmpl	$19, -20(%rbp)
	jle	.LBB1_2
.LBB1_3:                                # %forend
	xorl	%eax, %eax
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r14
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
	.asciz	"hello\n"
	.size	.Lglobalstring, 7

	.type	.Lglobalstring.1,@object # @globalstring.1
.Lglobalstring.1:
	.asciz	"\n"
	.size	.Lglobalstring.1, 2


	.section	".note.GNU-stack","",@progbits
