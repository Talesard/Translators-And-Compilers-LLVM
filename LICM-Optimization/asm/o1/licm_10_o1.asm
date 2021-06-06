	.text
	.file	"licm_10.cpp"
	.globl	_Z4funciiiiiiiiiiiiiiii         # -- Begin function _Z4funciiiiiiiiiiiiiiii
	.p2align	4, 0x90
	.type	_Z4funciiiiiiiiiiiiiiii,@function
_Z4funciiiiiiiiiiiiiiii:                # @_Z4funciiiiiiiiiiiiiiii
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset %rbx, -24
	.cfi_offset %rbp, -16
	movl	48(%rsp), %r10d
	movl	40(%rsp), %r11d
	movl	32(%rsp), %ebp
	movl	24(%rsp), %ebx
	addl	%esi, %edi
	addl	%edx, %esi
	addl	%ecx, %edx
	addl	%r8d, %ecx
	addl	%r9d, %r8d
	addl	%ebx, %r9d
	addl	%ebp, %ebx
	addl	%r11d, %ebp
	addl	%r10d, %r11d
	addl	56(%rsp), %r10d
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	%edi, b1(%rax)
	movl	%esi, b2(%rax)
	movl	%edx, b3(%rax)
	movl	%ecx, b4(%rax)
	movl	%r8d, b5(%rax)
	movl	%r9d, b6(%rax)
	movl	%ebx, b7(%rax)
	movl	%ebp, b8(%rax)
	movl	%r11d, b9(%rax)
	movl	%r10d, b10(%rax)
	addq	$4, %rax
	cmpq	$800000, %rax                   # imm = 0xC3500
	jne	.LBB0_1
# %bb.2:                                # %for.end
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	_Z4funciiiiiiiiiiiiiiii, .Lfunc_end0-_Z4funciiiiiiiiiiiiiiii
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movl	$42, b1(%rip)
	movl	$43, b2(%rip)
	movl	$44, b3(%rip)
	movl	$45, b4(%rip)
	movl	$46, b5(%rip)
	movl	$47, b6(%rip)
	movl	$48, b7(%rip)
	movl	$49, b8(%rip)
	movl	$50, b9(%rip)
	movl	$51, b10(%rip)
	movl	$52, b11(%rip)
	movl	$53, b12(%rip)
	movl	$54, b13(%rip)
	movl	$55, b14(%rip)
	movl	$56, b15(%rip)
	movl	$57, b16(%rip)
	movl	$1000, %ebx                     # imm = 0x3E8
	.p2align	4, 0x90
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	b1(%rip), %ecx
	subq	$40, %rsp
	.cfi_adjust_cfa_offset 40
	movl	%ecx, %edi
	movl	%ecx, %esi
	movl	%ecx, %edx
	movl	%ecx, %r8d
	movl	%ecx, %r9d
	pushq	%rcx
	.cfi_adjust_cfa_offset 8
	pushq	%rcx
	.cfi_adjust_cfa_offset 8
	pushq	%rcx
	.cfi_adjust_cfa_offset 8
	pushq	%rcx
	.cfi_adjust_cfa_offset 8
	pushq	%rcx
	.cfi_adjust_cfa_offset 8
	callq	_Z4funciiiiiiiiiiiiiiii
	addq	$80, %rsp
	.cfi_adjust_cfa_offset -80
	addl	$-1, %ebx
	jne	.LBB1_1
# %bb.2:                                # %for.cond.cleanup
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	b1,@object                      # @b1
	.bss
	.globl	b1
	.p2align	4
b1:
	.zero	400000
	.size	b1, 400000

	.type	b2,@object                      # @b2
	.globl	b2
	.p2align	4
b2:
	.zero	400000
	.size	b2, 400000

	.type	b3,@object                      # @b3
	.globl	b3
	.p2align	4
b3:
	.zero	400000
	.size	b3, 400000

	.type	b4,@object                      # @b4
	.globl	b4
	.p2align	4
b4:
	.zero	400000
	.size	b4, 400000

	.type	b5,@object                      # @b5
	.globl	b5
	.p2align	4
b5:
	.zero	400000
	.size	b5, 400000

	.type	b6,@object                      # @b6
	.globl	b6
	.p2align	4
b6:
	.zero	400000
	.size	b6, 400000

	.type	b7,@object                      # @b7
	.globl	b7
	.p2align	4
b7:
	.zero	400000
	.size	b7, 400000

	.type	b8,@object                      # @b8
	.globl	b8
	.p2align	4
b8:
	.zero	400000
	.size	b8, 400000

	.type	b9,@object                      # @b9
	.globl	b9
	.p2align	4
b9:
	.zero	400000
	.size	b9, 400000

	.type	b10,@object                     # @b10
	.globl	b10
	.p2align	4
b10:
	.zero	400000
	.size	b10, 400000

	.type	b11,@object                     # @b11
	.globl	b11
	.p2align	4
b11:
	.zero	400000
	.size	b11, 400000

	.type	b12,@object                     # @b12
	.globl	b12
	.p2align	4
b12:
	.zero	400000
	.size	b12, 400000

	.type	b13,@object                     # @b13
	.globl	b13
	.p2align	4
b13:
	.zero	400000
	.size	b13, 400000

	.type	b14,@object                     # @b14
	.globl	b14
	.p2align	4
b14:
	.zero	400000
	.size	b14, 400000

	.type	b15,@object                     # @b15
	.globl	b15
	.p2align	4
b15:
	.zero	400000
	.size	b15, 400000

	.type	b16,@object                     # @b16
	.globl	b16
	.p2align	4
b16:
	.zero	400000
	.size	b16, 400000

	.type	b17,@object                     # @b17
	.globl	b17
	.p2align	4
b17:
	.zero	400000
	.size	b17, 400000

	.type	b18,@object                     # @b18
	.globl	b18
	.p2align	4
b18:
	.zero	400000
	.size	b18, 400000

	.type	b19,@object                     # @b19
	.globl	b19
	.p2align	4
b19:
	.zero	400000
	.size	b19, 400000

	.type	b20,@object                     # @b20
	.globl	b20
	.p2align	4
b20:
	.zero	400000
	.size	b20, 400000

	.ident	"clang version 11.1.0 (https://github.com/llvm/llvm-project.git 1fdec59bffc11ae37eb51a1b9869f0696bfd5312)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
