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
	jmp	.LBB0_1
	.p2align	4, 0x90
.LBB0_3:                                # %iffalse
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	4(%rsp), %edi
	callq	print_int
.LBB0_1:                                # %whilestart
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$9, 4(%rsp)
	jg	.LBB0_4
# %bb.2:                                # %whiletrue
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	4(%rsp), %eax
	leal	1(%rax), %ecx
	movl	%ecx, 4(%rsp)
	movl	%ecx, %edx
	shrl	$31, %edx
	leal	1(%rax,%rdx), %eax
	andl	$-2, %eax
	cmpl	%eax, %ecx
	jne	.LBB0_1
	jmp	.LBB0_3
.LBB0_4:                                # %whileend
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
