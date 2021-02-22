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
	.globl	puts                            # -- Begin function puts
	.p2align	4, 0x90
	.type	puts,@function
puts:                                   # @puts
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	%ecx, -4(%ebp)
	#APP
	movw	%cx, %si
	#NO_APP
	calll	_kern16_puts
	addl	$8, %esp
	popl	%ebp
	retl
.Lfunc_end1:
	.size	puts, .Lfunc_end1-puts
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
	leal	.L.str, %ecx
	calll	puts
	addl	$8, %esp
	popl	%ebp
	retl
.Lfunc_end2:
	.size	kernel_entry, .Lfunc_end2-kernel_entry
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Hello!"
	.size	.L.str, 7

	.ident	"clang version 11.0.0"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym initialise_video_segment
	.addrsig_sym puts
	.addrsig_sym _kern16_puts
	.addrsig_sym _kern16_cls
