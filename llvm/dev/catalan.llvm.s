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
	callq	read_int
	movl	%eax, %edi
	callq	cat
	movl	%eax, %edi
	callq	print_int
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	fact                    # -- Begin function fact
	.p2align	4, 0x90
	.type	fact,@function
fact:                                   # @fact
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -16
	movl	%edi, 12(%rsp)
	cmpl	$1, 12(%rsp)
	jne	.LBB1_3
# %bb.1:                                # %iftrue
	movl	$1, %eax
	jmp	.LBB1_2
.LBB1_3:                                # %iffalse
	movl	12(%rsp), %ebx
	leal	-1(%rbx), %edi
	callq	fact
	imull	%ebx, %eax
.LBB1_2:                                # %iftrue
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	fact, .Lfunc_end1-fact
	.cfi_endproc
                                        # -- End function
	.globl	choose                  # -- Begin function choose
	.p2align	4, 0x90
	.type	choose,@function
choose:                                 # @choose
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %rbp, -16
	movl	%edi, 4(%rsp)
	movl	%esi, (%rsp)
	callq	fact
	movl	%eax, %ebx
	movl	(%rsp), %edi
	callq	fact
	movl	%eax, %ebp
	movl	4(%rsp), %edi
	subl	(%rsp), %edi
	callq	fact
	movl	%eax, %ecx
	imull	%ebp, %ecx
	movl	%ebx, %eax
	cltd
	idivl	%ecx
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	choose, .Lfunc_end2-choose
	.cfi_endproc
                                        # -- End function
	.globl	cat                     # -- Begin function cat
	.p2align	4, 0x90
	.type	cat,@function
cat:                                    # @cat
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%edi, %eax
	movl	%edi, 4(%rsp)
	leal	(%rax,%rax), %edi
	movl	%eax, %esi
	callq	choose
	movl	4(%rsp), %ecx
	incl	%ecx
	cltd
	idivl	%ecx
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	cat, .Lfunc_end3-cat
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
