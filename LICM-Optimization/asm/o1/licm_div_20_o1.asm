	.text
	.file	"licm_div_20.cpp"
	.globl	_Z4funciiiiiiiiiiiiiiii         # -- Begin function _Z4funciiiiiiiiiiiiiiii
	.p2align	4, 0x90
	.type	_Z4funciiiiiiiiiiiiiiii,@function
_Z4funciiiiiiiiiiiiiiii:                # @_Z4funciiiiiiiiiiiiiiii
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%ecx, %ebx
	movl	%edx, %ecx
	movl	%esi, %ebp
	movl	%edi, %r12d
	movl	72(%rsp), %r10d
	movl	64(%rsp), %esi
	movl	56(%rsp), %edi
	movl	%r12d, %eax
	cltd
	idivl	%ebp
	movl	%eax, -4(%rsp)                  # 4-byte Spill
	movl	%ebp, %eax
	cltd
	movl	%ecx, -32(%rsp)                 # 4-byte Spill
	idivl	%ecx
	movl	%eax, -8(%rsp)                  # 4-byte Spill
	movl	%ecx, %eax
	cltd
	idivl	%ebx
	movl	%eax, -12(%rsp)                 # 4-byte Spill
	movl	%ebx, %eax
	cltd
	movl	%r8d, -36(%rsp)                 # 4-byte Spill
	idivl	%r8d
	movl	%eax, -16(%rsp)                 # 4-byte Spill
	movl	%r8d, %eax
	cltd
	idivl	%r9d
	movl	%eax, -20(%rsp)                 # 4-byte Spill
	movl	%r9d, %eax
	cltd
	idivl	%edi
	movl	%eax, -24(%rsp)                 # 4-byte Spill
	movl	%edi, %eax
	cltd
	idivl	%esi
	movl	%eax, -28(%rsp)                 # 4-byte Spill
	movl	%esi, %eax
	cltd
	idivl	%r10d
	movl	%eax, %edi
	movl	%r10d, %eax
	cltd
	movl	80(%rsp), %esi
	idivl	%esi
	movl	%eax, %ecx
	movl	%esi, %eax
	cltd
	movl	88(%rsp), %esi
	idivl	%esi
	movl	%eax, %r9d
	movl	%esi, %eax
	cltd
	movl	96(%rsp), %esi
	idivl	%esi
	movl	%eax, %r11d
	movl	%esi, %eax
	cltd
	movl	104(%rsp), %esi
	idivl	%esi
	movl	%eax, %r14d
	movl	%esi, %eax
	cltd
	movl	112(%rsp), %esi
	idivl	%esi
	movl	%eax, %r15d
	movl	%esi, %eax
	cltd
	movl	120(%rsp), %esi
	idivl	%esi
	movl	%eax, %r8d
	movl	%esi, %eax
	cltd
	movl	128(%rsp), %esi
	idivl	%esi
	movl	%eax, %r10d
	movl	%esi, %eax
	cltd
	idivl	%r12d
	movl	%eax, %r12d
	movl	%esi, %eax
	cltd
	idivl	%ebp
	movl	%eax, %r13d
	movl	%esi, %eax
	movl	%esi, %ebp
	cltd
	idivl	-32(%rsp)                       # 4-byte Folded Reload
	movl	%eax, %esi
	movl	%ebp, %eax
	cltd
	idivl	%ebx
	movl	%eax, %ebx
	movl	%ebp, %eax
	cltd
	idivl	-36(%rsp)                       # 4-byte Folded Reload
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rsp), %ebp                  # 4-byte Reload
	movl	%ebp, b1+4(%rdx)
	movl	-8(%rsp), %ebp                  # 4-byte Reload
	movl	%ebp, b2+4(%rdx)
	movl	-12(%rsp), %ebp                 # 4-byte Reload
	movl	%ebp, b3+4(%rdx)
	movl	-16(%rsp), %ebp                 # 4-byte Reload
	movl	%ebp, b4+4(%rdx)
	movl	-20(%rsp), %ebp                 # 4-byte Reload
	movl	%ebp, b5+4(%rdx)
	movl	-24(%rsp), %ebp                 # 4-byte Reload
	movl	%ebp, b6+4(%rdx)
	movl	-28(%rsp), %ebp                 # 4-byte Reload
	movl	%ebp, b7+4(%rdx)
	movl	%edi, b8+4(%rdx)
	movl	%ecx, b9+4(%rdx)
	movl	%r9d, b10+4(%rdx)
	movl	%r11d, b11+4(%rdx)
	movl	%r14d, b12+4(%rdx)
	movl	%r15d, b13+4(%rdx)
	movl	%r8d, b14+4(%rdx)
	movl	%r10d, b15+4(%rdx)
	movl	%r12d, b16+4(%rdx)
	movl	%r13d, b17+4(%rdx)
	movl	%esi, b18+4(%rdx)
	movl	%ebx, b19+4(%rdx)
	movl	%eax, b20+4(%rdx)
	addq	$4, %rdx
	cmpq	$399996, %rdx                   # imm = 0x61A7C
	jne	.LBB0_1
# %bb.2:                                # %for.end
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
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
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
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
	movl	b1(%rip), %edi
	movl	b2(%rip), %esi
	movl	b3(%rip), %edx
	movl	b4(%rip), %ecx
	movl	b5(%rip), %r8d
	movl	b6(%rip), %r9d
	movl	b7(%rip), %r10d
	movl	b8(%rip), %r11d
	movl	b9(%rip), %r14d
	movl	b10(%rip), %r15d
	movl	b11(%rip), %r12d
	movl	b12(%rip), %eax
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	pushq	%r12
	.cfi_adjust_cfa_offset 8
	pushq	%r15
	.cfi_adjust_cfa_offset 8
	pushq	%r14
	.cfi_adjust_cfa_offset 8
	pushq	%r11
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	callq	_Z4funciiiiiiiiiiiiiiii
	addq	$80, %rsp
	.cfi_adjust_cfa_offset -80
	addl	$-1, %ebx
	jne	.LBB1_1
# %bb.2:                                # %for.cond.cleanup
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
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
