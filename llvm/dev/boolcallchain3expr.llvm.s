	.text
	.file	"DecafComp"
	.globl	test3                   # -- Begin function test3
	.p2align	4, 0x90
	.type	test3,@function
test3:                                  # @test3
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	andl	$1, %edi
	movb	%dil, 7(%rsp)
	cmpb	$1, 7(%rsp)
	jne	.LBB0_2
# %bb.1:                                # %iftrue
	movzbl	7(%rsp), %edi
	callq	print_int
.LBB0_2:                                # %iffalse
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	test3, .Lfunc_end0-test3
	.cfi_endproc
                                        # -- End function
	.globl	test2                   # -- Begin function test2
	.p2align	4, 0x90
	.type	test2,@function
test2:                                  # @test2
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	andl	$1, %edi
	movb	%dil, 7(%rsp)
	movzbl	7(%rsp), %edi
	callq	print_int
	movb	7(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %edi
	callq	test3
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	test2, .Lfunc_end1-test2
	.cfi_endproc
                                        # -- End function
	.globl	test1                   # -- Begin function test1
	.p2align	4, 0x90
	.type	test1,@function
test1:                                  # @test1
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	andl	$1, %edi
	movb	%dil, 7(%rsp)
	movzbl	7(%rsp), %edi
	callq	print_int
	movb	7(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %edi
	callq	test2
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	test1, .Lfunc_end2-test1
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
	callq	test1
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
