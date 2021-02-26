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
	movb	%dil, 3(%rsp)
	movl	%esi, 4(%rsp)
	movl	%esi, %edi
	callq	print_int
	movzbl	3(%rsp), %edi
	callq	print_int
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	test3, .Lfunc_end0-test3
	.cfi_endproc
                                        # -- End function
	.globl	test2b                  # -- Begin function test2b
	.p2align	4, 0x90
	.type	test2b,@function
test2b:                                 # @test2b
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%edi, 4(%rsp)
	andl	$1, %esi
	movb	%sil, 3(%rsp)
	callq	print_int
	movzbl	3(%rsp), %edi
	callq	print_int
	movl	4(%rsp), %esi
	movzbl	3(%rsp), %edi
	callq	test3
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	test2b, .Lfunc_end1-test2b
	.cfi_endproc
                                        # -- End function
	.globl	test2a                  # -- Begin function test2a
	.p2align	4, 0x90
	.type	test2a,@function
test2a:                                 # @test2a
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%edi, 4(%rsp)
	andl	$1, %esi
	movb	%sil, 3(%rsp)
	callq	print_int
	movzbl	3(%rsp), %edi
	callq	print_int
	movb	3(%rsp), %al
	xorb	$1, %al
	movl	4(%rsp), %esi
	incl	%esi
	movzbl	%al, %edi
	callq	test3
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	test2a, .Lfunc_end2-test2a
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
	movb	%dil, 3(%rsp)
	movl	%esi, 4(%rsp)
	movl	%esi, %edi
	callq	print_int
	movzbl	3(%rsp), %edi
	callq	print_int
	movl	4(%rsp), %edi
	incl	%edi
	movb	3(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %esi
	callq	test2a
	movl	4(%rsp), %edi
	incl	%edi
	movb	3(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %esi
	callq	test2b
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	test1, .Lfunc_end3-test1
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
	movl	$1, %esi
	callq	test1
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
