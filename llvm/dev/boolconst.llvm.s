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
	movl	$0, 4(%rsp)
	movl	$1, %edi
	callq	print_int
	xorl	%edi, %edi
	callq	print_int
	movl	$3, 4(%rsp)
	cmpl	$3, 4(%rsp)
	jne	.LBB0_2
# %bb.1:                                # %iftrue
	movl	4(%rsp), %edi
	callq	print_int
.LBB0_2:                                # %iffalse
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
