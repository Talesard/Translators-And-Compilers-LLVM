	.text
	.file	"licm_div_10.cpp"
	.globl	_Z4funciiiiiiiiiiiiiiii         # -- Begin function _Z4funciiiiiiiiiiiiiiii
	.p2align	4, 0x90
	.type	_Z4funciiiiiiiiiiiiiiii,@function
_Z4funciiiiiiiiiiiiiiii:                # @_Z4funciiiiiiiiiiiiiiii
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movl	88(%rbp), %eax
	movl	80(%rbp), %r10d
	movl	72(%rbp), %r11d
	movl	64(%rbp), %ebx
	movl	56(%rbp), %r14d
	movl	48(%rbp), %r15d
	movl	40(%rbp), %r12d
	movl	32(%rbp), %r13d
	movl	%eax, -72(%rbp)                 # 4-byte Spill
	movl	24(%rbp), %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
	movl	16(%rbp), %eax
	movl	%edi, -44(%rbp)
	movl	%esi, -48(%rbp)
	movl	%edx, -52(%rbp)
	movl	%ecx, -56(%rbp)
	movl	%r8d, -60(%rbp)
	movl	%r9d, -64(%rbp)
	movl	$1, -68(%rbp)
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movslq	-68(%rbp), %rax
	cmpq	$100000, %rax                   # imm = 0x186A0
	jge	.LBB0_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	-44(%rbp), %eax
	cltd
	idivl	-48(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b1(,%rcx,4)
	movl	-48(%rbp), %eax
	cltd
	idivl	-52(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b2(,%rcx,4)
	movl	-52(%rbp), %eax
	cltd
	idivl	-56(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b3(,%rcx,4)
	movl	-56(%rbp), %eax
	cltd
	idivl	-60(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b4(,%rcx,4)
	movl	-60(%rbp), %eax
	cltd
	idivl	-64(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b5(,%rcx,4)
	movl	-64(%rbp), %eax
	cltd
	idivl	16(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b6(,%rcx,4)
	movl	16(%rbp), %eax
	cltd
	idivl	24(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b7(,%rcx,4)
	movl	24(%rbp), %eax
	cltd
	idivl	32(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b8(,%rcx,4)
	movl	32(%rbp), %eax
	cltd
	idivl	40(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b9(,%rcx,4)
	movl	40(%rbp), %eax
	cltd
	idivl	48(%rbp)
	movslq	-68(%rbp), %rcx
	movl	%eax, b10(,%rcx,4)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB0_1
.LBB0_4:                                # %for.end
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movl	$0, -44(%rbp)
	movl	$42, b1
	movl	b1, %eax
	addl	$1, %eax
	movl	%eax, b2
	movl	b1, %eax
	addl	$2, %eax
	movl	%eax, b3
	movl	b1, %eax
	addl	$3, %eax
	movl	%eax, b4
	movl	b1, %eax
	addl	$4, %eax
	movl	%eax, b5
	movl	b1, %eax
	addl	$5, %eax
	movl	%eax, b6
	movl	b1, %eax
	addl	$6, %eax
	movl	%eax, b7
	movl	b1, %eax
	addl	$7, %eax
	movl	%eax, b8
	movl	b1, %eax
	addl	$8, %eax
	movl	%eax, b9
	movl	b1, %eax
	addl	$9, %eax
	movl	%eax, b10
	movl	b1, %eax
	addl	$10, %eax
	movl	%eax, b11
	movl	b1, %eax
	addl	$11, %eax
	movl	%eax, b12
	movl	b1, %eax
	addl	$12, %eax
	movl	%eax, b13
	movl	b1, %eax
	addl	$13, %eax
	movl	%eax, b14
	movl	b1, %eax
	addl	$14, %eax
	movl	%eax, b15
	movl	b1, %eax
	addl	$15, %eax
	movl	%eax, b16
	movl	$0, -48(%rbp)
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$1000, -48(%rbp)                # imm = 0x3E8
	jge	.LBB1_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	movl	b1, %edi
	movl	b2, %esi
	movl	b3, %edx
	movl	b4, %ecx
	movl	b5, %r8d
	movl	b6, %r9d
	movl	b7, %eax
	movl	b8, %r10d
	movl	b9, %r11d
	movl	b10, %ebx
	movl	b11, %r14d
	movl	b12, %r15d
	movl	b12, %r12d
	movl	b12, %r13d
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	movl	b12, %eax
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	movl	b12, %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	movl	-52(%rbp), %eax                 # 4-byte Reload
	movl	%eax, (%rsp)
	movl	%r10d, 8(%rsp)
	movl	%r11d, 16(%rsp)
	movl	%ebx, 24(%rsp)
	movl	%r14d, 32(%rsp)
	movl	%r15d, 40(%rsp)
	movl	%r12d, 48(%rsp)
	movl	%r13d, 56(%rsp)
	movl	-56(%rbp), %eax                 # 4-byte Reload
	movl	%eax, 64(%rsp)
	movl	-60(%rbp), %eax                 # 4-byte Reload
	movl	%eax, 72(%rsp)
	callq	_Z4funciiiiiiiiiiiiiiii
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB1_1 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB1_1
.LBB1_4:                                # %for.end
	xorl	%eax, %eax
	addq	$104, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
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
	.addrsig_sym _Z4funciiiiiiiiiiiiiiii
	.addrsig_sym b1
	.addrsig_sym b2
	.addrsig_sym b3
	.addrsig_sym b4
	.addrsig_sym b5
	.addrsig_sym b6
	.addrsig_sym b7
	.addrsig_sym b8
	.addrsig_sym b9
	.addrsig_sym b10
	.addrsig_sym b11
	.addrsig_sym b12
	.addrsig_sym b13
	.addrsig_sym b14
	.addrsig_sym b15
	.addrsig_sym b16
