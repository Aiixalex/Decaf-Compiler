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
	callq	d
	movl	%eax, %edi
	callq	c
	movl	%eax, %edi
	callq	k
	movl	%eax, %edi
	callq	x
	movl	%eax, %edi
	callq	print_int
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	x                       # -- Begin function x
	.p2align	4, 0x90
	.type	x,@function
x:                                      # @x
	.cfi_startproc
# %bb.0:                                # %entry
                                        # kill: def $edi killed $edi def $rdi
	movl	%edi, -4(%rsp)
	leal	(%rdi,%rdi), %eax
	retq
.Lfunc_end1:
	.size	x, .Lfunc_end1-x
	.cfi_endproc
                                        # -- End function
	.globl	k                       # -- Begin function k
	.p2align	4, 0x90
	.type	k,@function
k:                                      # @k
	.cfi_startproc
# %bb.0:                                # %entry
                                        # kill: def $edi killed $edi def $rdi
	movl	%edi, -4(%rsp)
	leal	(%rdi,%rdi,2), %eax
	retq
.Lfunc_end2:
	.size	k, .Lfunc_end2-k
	.cfi_endproc
                                        # -- End function
	.globl	c                       # -- Begin function c
	.p2align	4, 0x90
	.type	c,@function
c:                                      # @c
	.cfi_startproc
# %bb.0:                                # %entry
                                        # kill: def $edi killed $edi def $rdi
	movl	%edi, -4(%rsp)
	leal	4(%rdi), %eax
	retq
.Lfunc_end3:
	.size	c, .Lfunc_end3-c
	.cfi_endproc
                                        # -- End function
	.globl	d                       # -- Begin function d
	.p2align	4, 0x90
	.type	d,@function
d:                                      # @d
	.cfi_startproc
# %bb.0:                                # %entry
	movl	$3, %eax
	retq
.Lfunc_end4:
	.size	d, .Lfunc_end4-d
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
