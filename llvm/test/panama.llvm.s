	.text
	.file	"DecafComp"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movl	$1, %edi
	callq	a
                                        # kill: def $al killed $al def $eax
	testb	$1, %al
	jne	.LBB0_2
# %bb.1:                                # %noskct
	callq	man
                                        # kill: def $al killed $al def $eax
	testb	$1, %al
	je	.LBB0_2
# %bb.29:                               # %noskct3
	xorl	%eax, %eax
.LBB0_2:                                # %skctend
	testb	$1, %al
	je	.LBB0_6
# %bb.3:                                # %iftrue
	movl	$.Lglobalstring, %edi
	jmp	.LBB0_4
.LBB0_6:                                # %iffalse
	movl	$.Lglobalstring.1, %edi
	callq	print_string
	xorl	%edi, %edi
	callq	a
	testb	$1, %al
	je	.LBB0_8
# %bb.7:                                # %noskct11
	callq	canal
.LBB0_8:                                # %skctend12
	testb	$1, %al
	je	.LBB0_10
# %bb.9:                                # %iftrue9
	movl	$.Lglobalstring.2, %edi
.LBB0_4:                                # %end
	callq	print_string
.LBB0_5:                                # %end
	xorl	%eax, %eax
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB0_10:                               # %iffalse10
	.cfi_def_cfa %rbp, 16
	movb	$1, %al
	testb	%al, %al
	je	.LBB0_5
# %bb.11:                               # %iftrue18
	callq	plan
	testb	$1, %al
	je	.LBB0_17
# %bb.12:                               # %iftrue25
	movq	%rsp, %rax
	leaq	-16(%rax), %rbx
	movq	%rbx, %rsp
	movb	$1, -16(%rax)
	jmp	.LBB0_13
	.p2align	4, 0x90
.LBB0_16:                               # %whiletrue
                                        #   in Loop: Header=BB0_13 Depth=1
	movl	$.Lglobalstring.3, %edi
	callq	print_string
	movb	$0, (%rbx)
.LBB0_13:                               # %whilestart
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx), %eax
	testb	%al, %al
	je	.LBB0_15
# %bb.14:                               # %noskct34
                                        #   in Loop: Header=BB0_13 Depth=1
	callq	canal
.LBB0_15:                               # %skctend35
                                        #   in Loop: Header=BB0_13 Depth=1
	testb	$1, %al
	jne	.LBB0_16
	jmp	.LBB0_5
.LBB0_17:                               # %iffalse26
	movl	$.Lglobalstring.4, %edi
	callq	print_string
	xorl	%edi, %edi
	callq	a
                                        # kill: def $al killed $al def $eax
	testb	$1, %al
	jne	.LBB0_19
# %bb.18:                               # %noskct43
	xorl	%eax, %eax
.LBB0_19:                               # %skctend44
	testb	$1, %al
	je	.LBB0_21
# %bb.20:                               # %iftrue41
	movl	$.Lglobalstring.5, %edi
	jmp	.LBB0_4
.LBB0_21:                               # %iffalse42
	callq	canal
	testb	$1, %al
	jne	.LBB0_23
# %bb.22:                               # %noskct54
	callq	man
.LBB0_23:                               # %skctend55
	testb	$1, %al
	je	.LBB0_5
# %bb.24:                               # %iftrue52
	movq	%rsp, %r14
	leaq	-16(%r14), %rbx
	movq	%rbx, %rsp
	movb	$0, -16(%r14)
	movl	$.Lglobalstring.6, %edi
	callq	print_string
	movb	$1, -16(%r14)
	jmp	.LBB0_25
	.p2align	4, 0x90
.LBB0_28:                               # %whiletrue67
                                        #   in Loop: Header=BB0_25 Depth=1
	movb	$0, (%rbx)
	movl	$.Lglobalstring.7, %edi
	callq	print_string
.LBB0_25:                               # %whilestart66
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx), %eax
	testb	%al, %al
	je	.LBB0_27
# %bb.26:                               # %noskct69
                                        #   in Loop: Header=BB0_25 Depth=1
	callq	panama
.LBB0_27:                               # %skctend70
                                        #   in Loop: Header=BB0_25 Depth=1
	testb	$1, %al
	jne	.LBB0_28
	jmp	.LBB0_5
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	man                     # -- Begin function man
	.p2align	4, 0x90
	.type	man,@function
man:                                    # @man
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$.Lglobalstring.8, %edi
	callq	print_string
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	man, .Lfunc_end1-man
	.cfi_endproc
                                        # -- End function
	.globl	plan                    # -- Begin function plan
	.p2align	4, 0x90
	.type	plan,@function
plan:                                   # @plan
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$.Lglobalstring.9, %edi
	callq	print_string
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	plan, .Lfunc_end2-plan
	.cfi_endproc
                                        # -- End function
	.globl	a                       # -- Begin function a
	.p2align	4, 0x90
	.type	a,@function
a:                                      # @a
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	andl	$1, %edi
	movb	%dil, 7(%rsp)
	cmpb	$1, 7(%rsp)
	jne	.LBB3_2
# %bb.1:                                # %iftrue
	movl	$.Lglobalstring.10, %edi
	jmp	.LBB3_3
.LBB3_2:                                # %iffalse
	movl	$.Lglobalstring.11, %edi
.LBB3_3:                                # %end
	callq	print_string
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	a, .Lfunc_end3-a
	.cfi_endproc
                                        # -- End function
	.globl	canal                   # -- Begin function canal
	.p2align	4, 0x90
	.type	canal,@function
canal:                                  # @canal
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$.Lglobalstring.12, %edi
	callq	print_string
	movb	$1, %al
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	canal, .Lfunc_end4-canal
	.cfi_endproc
                                        # -- End function
	.globl	panama                  # -- Begin function panama
	.p2align	4, 0x90
	.type	panama,@function
panama:                                 # @panama
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$.Lglobalstring.13, %edi
	callq	print_string
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	panama, .Lfunc_end5-panama
	.cfi_endproc
                                        # -- End function
	.type	.Lglobalstring,@object  # @globalstring
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lglobalstring:
	.asciz	"wat"
	.size	.Lglobalstring, 4

	.type	.Lglobalstring.1,@object # @globalstring.1
.Lglobalstring.1:
	.asciz	", "
	.size	.Lglobalstring.1, 3

	.type	.Lglobalstring.2,@object # @globalstring.2
.Lglobalstring.2:
	.asciz	"foo"
	.size	.Lglobalstring.2, 4

	.type	.Lglobalstring.3,@object # @globalstring.3
.Lglobalstring.3:
	.asciz	"bar"
	.size	.Lglobalstring.3, 4

	.type	.Lglobalstring.4,@object # @globalstring.4
.Lglobalstring.4:
	.asciz	", "
	.size	.Lglobalstring.4, 3

	.type	.Lglobalstring.5,@object # @globalstring.5
.Lglobalstring.5:
	.asciz	"bash"
	.size	.Lglobalstring.5, 5

	.type	.Lglobalstring.6,@object # @globalstring.6
.Lglobalstring.6:
	.asciz	"--"
	.size	.Lglobalstring.6, 3

	.type	.Lglobalstring.7,@object # @globalstring.7
.Lglobalstring.7:
	.asciz	"!"
	.size	.Lglobalstring.7, 2

	.type	.Lglobalstring.8,@object # @globalstring.8
.Lglobalstring.8:
	.asciz	"man"
	.size	.Lglobalstring.8, 4

	.type	.Lglobalstring.9,@object # @globalstring.9
.Lglobalstring.9:
	.asciz	"plan"
	.size	.Lglobalstring.9, 5

	.type	.Lglobalstring.10,@object # @globalstring.10
.Lglobalstring.10:
	.asciz	"A "
	.size	.Lglobalstring.10, 3

	.type	.Lglobalstring.11,@object # @globalstring.11
.Lglobalstring.11:
	.asciz	"a "
	.size	.Lglobalstring.11, 3

	.type	.Lglobalstring.12,@object # @globalstring.12
.Lglobalstring.12:
	.asciz	"canal"
	.size	.Lglobalstring.12, 6

	.type	.Lglobalstring.13,@object # @globalstring.13
.Lglobalstring.13:
	.asciz	"Panama"
	.size	.Lglobalstring.13, 7


	.section	".note.GNU-stack","",@progbits
