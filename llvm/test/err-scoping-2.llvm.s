	.text
	.file	"DecafComp"
	.globl	foo.1                   # -- Begin function foo.1
	.p2align	4, 0x90
	.type	foo.1,@function
foo.1:                                  # @foo.1
	.cfi_startproc
# %bb.0:                                # %entry
	movl	%edi, -4(%rsp)
	movl	$0, -8(%rsp)
	retq
.Lfunc_end0:
	.size	foo.1, .Lfunc_end0-foo.1
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
	movl	$1, %edi
	callq	foo.1
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
