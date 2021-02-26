	.text
	.file	"DecafComp"
	.globl	foo                     # -- Begin function foo
	.p2align	4, 0x90
	.type	foo,@function
foo:                                    # @foo
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%edi, 4(%rsp)
	movl	$.Lglobalstring, %edi
	callq	print_string
	cmpl	$200, 4(%rsp)
	setg	%al
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	foo, .Lfunc_end0-foo
	.cfi_endproc
                                        # -- End function
	.globl	bar                     # -- Begin function bar
	.p2align	4, 0x90
	.type	bar,@function
bar:                                    # @bar
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%edi, 4(%rsp)
	movl	%esi, (%rsp)
	movl	$.Lglobalstring.1, %edi
	callq	print_string
	movl	4(%rsp), %eax
	cmpl	(%rsp), %eax
	setne	%al
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	bar, .Lfunc_end1-bar
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movb	$0, 15(%rsp)
	movl	$99, 16(%rsp)
	movl	$201, 20(%rsp)
	movb	$1, %al
	testb	%al, %al
	jne	.LBB2_2
# %bb.1:                                # %noskct1
	movl	16(%rsp), %edi
	callq	foo
                                        # kill: def $al killed $al def $eax
	testb	$1, %al
	je	.LBB2_2
# %bb.5:                                # %noskct4
	movl	16(%rsp), %edi
	movl	20(%rsp), %esi
	callq	bar
                                        # kill: def $al killed $al def $eax
.LBB2_2:                                # %skctend2
	testb	$1, %al
	jne	.LBB2_4
# %bb.3:                                # %noskct
	xorl	%eax, %eax
.LBB2_4:                                # %skctend
	andb	$1, %al
	movb	%al, 15(%rsp)
	movzbl	15(%rsp), %edi
	callq	print_int
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	.Lglobalstring,@object  # @globalstring
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lglobalstring:
	.asciz	"foo"
	.size	.Lglobalstring, 4

	.type	.Lglobalstring.1,@object # @globalstring.1
.Lglobalstring.1:
	.asciz	"bar"
	.size	.Lglobalstring.1, 4


	.section	".note.GNU-stack","",@progbits
