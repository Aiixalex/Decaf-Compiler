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
	movl	$0, 4(%rsp)
	movl	$5, (%rsp)
	movb	$1, %al
	testb	%al, %al
	jne	.LBB0_2
# %bb.1:                                # %noskct
	movl	(%rsp), %eax
	cltd
	idivl	4(%rsp)
	testl	%eax, %eax
	sete	%al
.LBB0_2:                                # %skctend
	testb	%al, %al
	je	.LBB0_4
# %bb.3:                                # %iftrue
	movl	(%rsp), %edi
	callq	print_int
.LBB0_4:                                # %iffalse
	cmpl	$5, (%rsp)
	setl	%al
	jge	.LBB0_6
# %bb.5:                                # %noskct8
                                        # implicit-def: $al
.LBB0_6:                                # %skctend9
	testb	$1, %al
	je	.LBB0_8
# %bb.7:                                # %iftrue6
	movl	4(%rsp), %edi
	callq	print_int
.LBB0_8:                                # %iffalse7
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
