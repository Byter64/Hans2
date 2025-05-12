	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"main.cpp"
	.text
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
# %bb.0:
	lui	a0, %hi(sdramInt)
	lw	a0, %lo(sdramInt)(a0)
	lui	a1, 3
	addi	a1, a1, 57
	sw	a1, 0(a0)
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	lw	a1, 0(a0)
	addi	a1, a1, 1
	sw	a1, 0(a0)
	j	.LBB0_1
.Lfunc_end0:
	.size	_Z4mainv, .Lfunc_end0-_Z4mainv
                                        # -- End function
	.globl	_Z15updateAnimationRiS_ii       # -- Begin function _Z15updateAnimationRiS_ii
	.p2align	2
	.type	_Z15updateAnimationRiS_ii,@function
_Z15updateAnimationRiS_ii:              # @_Z15updateAnimationRiS_ii
# %bb.0:
	lw	a4, 0(a0)
	addi	a4, a4, -1
	sw	a4, 0(a0)
	beqz	a4, .LBB1_2
# %bb.1:
	ret
.LBB1_2:
	lw	a4, 0(a1)
	add	a2, a4, a2
	rem	a2, a2, a3
	li	a3, 20
	sw	a2, 0(a1)
	sw	a3, 0(a0)
	ret
.Lfunc_end1:
	.size	_Z15updateAnimationRiS_ii, .Lfunc_end1-_Z15updateAnimationRiS_ii
                                        # -- End function
	.type	sdramInt,@object                # @sdramInt
	.bss
	.globl	sdramInt
	.p2align	2, 0x0
sdramInt:
	.word	0
	.size	sdramInt, 4

	.ident	"clang version 21.0.0git"
	.section	".note.GNU-stack","",@progbits
	.addrsig
