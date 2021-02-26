	.text
	.file	"DecafComp"
	.globl	five                    # -- Begin function five
	.p2align	4, 0x90
	.type	five,@function
five:                                   # @five
	.cfi_startproc
# %bb.0:                                # %entry
	movl	$5, %eax
	retq
.Lfunc_end0:
	.size	five, .Lfunc_end0-five
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
	movl	$0, 4(%rsp)
	movl	$.Lglobalstring, %edi
	callq	print_string
	movl	$0, 4(%rsp)
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
	.asciz	"hello\n"
	.size	.Lglobalstring, 7


	.section	".note.GNU-stack","",@progbits
