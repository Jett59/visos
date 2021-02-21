	.text
	.code16
	.file	"kernel16.c"
	.globl	initialise_video_segment        # -- Begin function initialise_video_segment
	.p2align	4, 0x90
	.type	initialise_video_segment,@function
initialise_video_segment:               # @initialise_video_segment
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	#APP
	movw	$47104, %di                     # imm = 0xB800
	#NO_APP
	#APP
	movw	%di, %es
	#NO_APP
	popl	%ebp
	retl
.Lfunc_end0:
	.size	initialise_video_segment, .Lfunc_end0-initialise_video_segment
                                        # -- End function
	.globl	callaa                          # -- Begin function callaa
	.p2align	4, 0x90
	.type	callaa,@function
callaa:                                 # @callaa
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movb	8(%ebp), %al
	movb	%al, -1(%ebp)                   # 1-byte Spill
	calll	_kern16_cls
	addl	$8, %esp
	popl	%ebp
	retl
.Lfunc_end1:
	.size	callaa, .Lfunc_end1-callaa
                                        # -- End function
	.globl	kernel_entry                    # -- Begin function kernel_entry
	.p2align	4, 0x90
	.type	kernel_entry,@function
kernel_entry:                           # @kernel_entry
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	calll	initialise_video_segment
	calll	_kern16_cls
	movl	$65, (%esp)
	calll	callaa
	addl	$8, %esp
	popl	%ebp
	retl
.Lfunc_end2:
	.size	kernel_entry, .Lfunc_end2-kernel_entry
                                        # -- End function
	.ident	"clang version 11.0.0"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym initialise_video_segment
	.addrsig_sym callaa
	.addrsig_sym _kern16_cls
