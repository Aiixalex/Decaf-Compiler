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
	callq	foo1
	movl	%eax, %edi
	callq	print_int
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	foo1                    # -- Begin function foo1
	.p2align	4, 0x90
	.type	foo1,@function
foo1:                                   # @foo1
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	foo2
	incl	%eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	foo1, .Lfunc_end1-foo1
	.cfi_endproc
                                        # -- End function
	.globl	foo2                    # -- Begin function foo2
	.p2align	4, 0x90
	.type	foo2,@function
foo2:                                   # @foo2
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	foo3
	notb	%al
	movzbl	%al, %edi
	andl	$1, %edi
	callq	intcast
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	foo2, .Lfunc_end2-foo2
	.cfi_endproc
                                        # -- End function
	.globl	foo3                    # -- Begin function foo3
	.p2align	4, 0x90
	.type	foo3,@function
foo3:                                   # @foo3
	.cfi_startproc
# %bb.0:                                # %entry
	xorl	%eax, %eax
	retq
.Lfunc_end3:
	.size	foo3, .Lfunc_end3-foo3
	.cfi_endproc
                                        # -- End function
	.globl	intcast                 # -- Begin function intcast
	.p2align	4, 0x90
	.type	intcast,@function
intcast:                                # @intcast
	.cfi_startproc
# %bb.0:                                # %entry
	movl	%edi, -4(%rsp)
	movl	%edi, %eax
	retq
.Lfunc_end4:
	.size	intcast, .Lfunc_end4-intcast
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
