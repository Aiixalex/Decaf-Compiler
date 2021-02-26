	.text
	.file	"DecafComp"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	$0, 12(%rsp)
	movl	a(%rip), %edi
	movl	%edi, 20(%rsp)
	movl	b(%rip), %esi
	movl	%esi, 16(%rsp)
	callq	gcd
	movl	%eax, 12(%rsp)
	movl	%eax, %edi
	callq	print_int
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	gcd                     # -- Begin function gcd
	.p2align	4, 0x90
	.type	gcd,@function
gcd:                                    # @gcd
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%edi, 4(%rsp)
	movl	%esi, (%rsp)
	cmpl	$0, (%rsp)
	je	.LBB1_1
# %bb.2:                                # %iffalse
	movl	(%rsp), %edi
	movl	4(%rsp), %eax
	cltd
	idivl	%edi
	movl	%edx, %esi
	callq	gcd
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB1_1:                                # %iftrue
	.cfi_def_cfa_offset 16
	movl	4(%rsp), %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	gcd, .Lfunc_end1-gcd
	.cfi_endproc
                                        # -- End function
	.type	a,@object               # @a
	.data
	.p2align	2
a:
	.long	10                      # 0xa
	.size	a, 4

	.type	b,@object               # @b
	.p2align	2
b:
	.long	20                      # 0x14
	.size	b, 4


	.section	".note.GNU-stack","",@progbits
