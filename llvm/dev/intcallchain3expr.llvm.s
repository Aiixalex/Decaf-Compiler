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
	movl	%edi, 4(%rsp)
	callq	print_int
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
	movl	%edi, 4(%rsp)
	callq	print_int
	movl	4(%rsp), %edi
	incl	%edi
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
	movl	%edi, 4(%rsp)
	callq	print_int
	movl	4(%rsp), %edi
	incl	%edi
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
