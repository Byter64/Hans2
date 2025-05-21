	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"main.cpp"
	.text
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	sw	s0, 88(sp)                      # 4-byte Folded Spill
	sw	s1, 84(sp)                      # 4-byte Folded Spill
	sw	s2, 80(sp)                      # 4-byte Folded Spill
	sw	s3, 76(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	lui	s3, %hi(sdCard)
	lui	a1, 209441
	lw	a0, %lo(sdCard)(s3)
	lui	a2, 489061
	lui	a3, 768682
	addi	a1, a1, 256
	sw	a1, 0(a0)
	lui	s0, %hi(.L.str)
	addi	s0, s0, %lo(.L.str)
	addi	a1, a2, 1348
	sw	a1, 516(a0)
	lui	s1, %hi(.L.str.1)
	addi	s1, s1, %lo(.L.str.1)
	addi	a1, a3, -1656
	sw	a1, 1032(a0)
	lui	s2, %hi(.L.str.2)
	addi	s2, s2, %lo(.L.str.2)
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	sb	zero, 12(sp)
	lw	a2, 0(a0)
	addi	a0, sp, 12
	mv	a1, s0
	call	sprintf_
	lw	a0, %lo(sdCard)(s3)
	lw	a2, 516(a0)
	addi	a0, sp, 12
	mv	a1, s1
	call	sprintf_
	lw	a0, %lo(sdCard)(s3)
	lw	a2, 1032(a0)
	addi	a0, sp, 12
	mv	a1, s2
	call	sprintf_
	lw	a0, %lo(sdCard)(s3)
	j	.LBB0_1
.Lfunc_end0:
	.size	_Z4mainv, .Lfunc_end0-_Z4mainv
	.cfi_endproc
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
	.type	sdCard,@object                  # @sdCard
	.data
	.globl	sdCard
	.p2align	2, 0x0
sdCard:
	.word	2147483648
	.size	sdCard, 4

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"0x00: %x"
	.size	.L.str, 9

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"0x04: %x"
	.size	.L.str.1, 9

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"0x08: %x"
	.size	.L.str.2, 9

	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
