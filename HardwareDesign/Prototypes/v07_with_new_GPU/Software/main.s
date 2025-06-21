	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"main.cpp"
	.text
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
# %bb.0:
	li	a0, 0
	lui	a1, %hi(p)
	lw	a1, %lo(p)(a1)
	li	a2, 256
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	sw	a0, 0(a1)
	addi	a0, a0, 1
	addi	a1, a1, 4
	bne	a0, a2, .LBB0_1
# %bb.2:
	li	a0, 0
	ret
.Lfunc_end0:
	.size	_Z4mainv, .Lfunc_end0-_Z4mainv
                                        # -- End function
	.type	p,@object                       # @p
	.data
	.globl	p
	.p2align	2, 0x0
p:
	.word	33644544
	.size	p, 4

	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
