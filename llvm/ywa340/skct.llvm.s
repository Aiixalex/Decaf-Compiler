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
	movl	$.Lglobalstring, %edi
	callq	print_string
	movl	$.Lglobalstring.1, %edi
	callq	print_string
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	foo, .Lfunc_end0-foo
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movb	$0, 7(%rsp)
	callq	foo
	xorb	$1, %al
	testb	$1, %al
	je	.LBB1_2
# %bb.1:                                # %noskct1
	callq	foo
.LBB1_2:                                # %skctend
	andb	$1, %al
	movb	%al, 7(%rsp)
	movzbl	7(%rsp), %edi
	callq	print_int
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	.Lglobalstring,@object  # @globalstring
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lglobalstring:
	.asciz	"foo"
	.size	.Lglobalstring, 4

	.type	.Lglobalstring.1,@object # @globalstring.1
.Lglobalstring.1:
	.asciz	"skct"
	.size	.Lglobalstring.1, 5


	.section	".note.GNU-stack","",@progbits
