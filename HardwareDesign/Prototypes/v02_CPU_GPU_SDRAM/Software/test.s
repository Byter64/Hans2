	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"test.cpp"
	.text
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
# %bb.0:
	lui	a0, %hi(number)
	addi	a1, a0, %lo(number)
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	lw	a2, %lo(number)(a0)
	addi	a2, a2, 3
	sw	a2, %lo(number)(a0)
	lw	a2, 4(a1)
	addi	a2, a2, 4
	sw	a2, 4(a1)
	j	.LBB0_1
.Lfunc_end0:
	.size	_Z4mainv, .Lfunc_end0-_Z4mainv
                                        # -- End function
	.type	number,@object                  # @number
	.data
	.globl	number
	.p2align	2, 0x0
number:
	.word	4294967295                      # 0xffffffff
	.word	4                               # 0x4
	.size	number, 8

	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym number
