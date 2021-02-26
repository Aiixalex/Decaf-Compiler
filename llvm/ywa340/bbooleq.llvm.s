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
	movb	$0, 6(%rsp)
	movb	$0, 5(%rsp)
	movb	$1, 7(%rsp)
	movb	$1, 4(%rsp)
	xorl	%eax, %eax
	testb	%al, %al
	je	.LBB0_1
# %bb.2:                                # %iffalse
	cmpb	$1, 6(%rsp)
	je	.LBB0_3
.LBB0_4:                                # %iffalse5
	cmpb	$1, 5(%rsp)
	je	.LBB0_5
.LBB0_6:                                # %iffalse11
	cmpb	$1, 4(%rsp)
	jne	.LBB0_8
.LBB0_7:                                # %iftrue16
	movzbl	4(%rsp), %edi
	callq	print_int
.LBB0_8:                                # %iffalse17
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB0_1:                                # %iftrue
	.cfi_def_cfa_offset 16
	movzbl	7(%rsp), %edi
	callq	print_int
	cmpb	$1, 6(%rsp)
	jne	.LBB0_4
.LBB0_3:                                # %iftrue4
	movzbl	6(%rsp), %edi
	callq	print_int
	cmpb	$1, 5(%rsp)
	jne	.LBB0_6
.LBB0_5:                                # %iftrue10
	movzbl	5(%rsp), %edi
	callq	print_int
	cmpb	$1, 4(%rsp)
	je	.LBB0_7
	jmp	.LBB0_8
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
