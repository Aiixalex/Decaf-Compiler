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
	cmpl	$9, 4(%rsp)
	jle	.LBB0_2
	jmp	.LBB0_3
	.p2align	4, 0x90
.LBB0_4:                                # %iffalse
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	4(%rsp), %edi
	callq	print_int
	incl	4(%rsp)
	cmpl	$9, 4(%rsp)
	jg	.LBB0_3
.LBB0_2:                                # %fortrue
                                        # =>This Inner Loop Header: Depth=1
	movl	4(%rsp), %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	cmpl	%ecx, %eax
	jne	.LBB0_4
.LBB0_3:                                # %forend
	xorl	%edi, %edi
	callq	print_int
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
