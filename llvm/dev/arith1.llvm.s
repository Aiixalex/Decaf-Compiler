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
	movb	$0, 3(%rsp)
	movb	$0, 1(%rsp)
	movl	$0, 4(%rsp)
	movb	$1, 2(%rsp)
	movb	$1, (%rsp)
	movb	2(%rsp), %al
	testb	%al, %al
	jne	.LBB0_2
# %bb.1:                                # %noskct
	movb	1(%rsp), %al
	testb	%al, %al
	je	.LBB0_2
# %bb.5:                                # %noskct2
	movb	(%rsp), %al
	xorb	$1, %al
.LBB0_2:                                # %skctend
	andb	$1, %al
	movb	%al, 3(%rsp)
	movl	$0, 4(%rsp)
	movb	$1, %al
	testb	%al, %al
	je	.LBB0_4
# %bb.3:                                # %iftrue
	movl	4(%rsp), %edi
	callq	print_int
.LBB0_4:                                # %iffalse
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
