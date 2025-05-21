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
	sw	s4, 72(sp)                      # 4-byte Folded Spill
	sw	s5, 68(sp)                      # 4-byte Folded Spill
	sw	s6, 64(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	.cfi_offset s5, -28
	.cfi_offset s6, -32
	lui	s5, %hi(sdCard)
	lw	a0, %lo(sdCard)(s5)
	li	a1, 42
	sb	a1, 0(a0)
	lw	a0, %lo(sdCard)(s5)
	li	a1, 100
	li	a2, -12
	sb	a1, 1(a0)
	lw	a0, %lo(sdCard)(s5)
	lui	s0, %hi(.L.str)
	addi	s0, s0, %lo(.L.str)
	lui	s1, %hi(.L.str.1)
	addi	s1, s1, %lo(.L.str.1)
	lui	s2, %hi(.L.str.2)
	addi	s2, s2, %lo(.L.str.2)
	sb	a2, 2(a0)
	lui	s3, %hi(.L.str.3)
	addi	s3, s3, %lo(.L.str.3)
	li	s6, 12
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
	lw	a0, %lo(sdCard)(s5)
	sb	zero, 0(sp)
	lbu	a2, 0(a0)
	mv	a0, sp
	mv	a1, s0
	call	sprintf_
	lw	a0, %lo(sdCard)(s5)
	lbu	a2, 1(a0)
	mv	a0, sp
	mv	a1, s1
	call	sprintf_
	lw	a0, %lo(sdCard)(s5)
	lbu	a2, 2(a0)
	mv	a0, sp
	mv	a1, s2
	call	sprintf_
	li	s4, 0
.LBB0_2:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a0, %lo(sdCard)(s5)
	add	a0, a0, s4
	lbu	a3, 0(a0)
	mv	a0, sp
	mv	a1, s3
	mv	a2, s4
	call	sprintf_
	addi	s4, s4, 1
	bne	s4, s6, .LBB0_2
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

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"0x%x: %x"
	.size	.L.str.3, 9

	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
