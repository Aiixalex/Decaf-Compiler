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
	andl	$1, %edi
	movb	%dil, 6(%rsp)
	andl	$1, %esi
	movb	%sil, 7(%rsp)
	cmpb	$1, 6(%rsp)
	jne	.LBB0_2
# %bb.1:                                # %iftrue
	movl	$2, %edi
	callq	print_int
.LBB0_2:                                # %iffalse
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
	xorl	%esi, %esi
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
