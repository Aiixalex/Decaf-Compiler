	.text
	.file	"DecafComp"
	.globl	test                    # -- Begin function test
	.p2align	4, 0x90
	.type	test,@function
test:                                   # @test
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	andb	$1, %dil
	movb	%dil, 7(%rsp)
	jne	.LBB0_1
# %bb.2:                                # %iffalse
	cmpb	$0, 7(%rsp)
	je	.LBB0_3
.LBB0_4:                                # %iffalse5
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.LBB0_1:                                # %iftrue
	.cfi_def_cfa_offset 16
	movl	$1, %edi
	callq	print_int
	cmpb	$0, 7(%rsp)
	jne	.LBB0_4
.LBB0_3:                                # %iftrue4
	movl	$2, %edi
	callq	print_int
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	test, .Lfunc_end0-test
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
	callq	test
	xorl	%edi, %edi
	callq	test
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
