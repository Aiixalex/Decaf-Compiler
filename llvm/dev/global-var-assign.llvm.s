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
	movl	foo(%rip), %edi
	callq	print_int
	movzbl	bar(%rip), %edi
	callq	print_int
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	foo,@object             # @foo
	.data
	.p2align	2
foo:
	.long	42                      # 0x2a
	.size	foo, 4

	.type	bar,@object             # @bar
bar:
	.byte	1                       # 0x1
	.size	bar, 1


	.section	".note.GNU-stack","",@progbits
