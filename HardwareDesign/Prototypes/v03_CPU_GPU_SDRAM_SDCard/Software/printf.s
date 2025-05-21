	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"printf.c"
	.text
	.globl	sprintf_                        # -- Begin function sprintf_
	.p2align	2
	.type	sprintf_,@function
sprintf_:                               # @sprintf_
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 4(sp)                       # 4-byte Folded Spill
	.cfi_offset ra, -28
	mv	t0, a1
	mv	a1, a0
	sw	a6, 24(sp)
	sw	a7, 28(sp)
	sw	a2, 8(sp)
	sw	a3, 12(sp)
	sw	a4, 16(sp)
	sw	a5, 20(sp)
	addi	a0, sp, 8
	sw	a0, 0(sp)
	lui	a0, %hi(_ZL11_out_buffercPvjj)
	addi	a0, a0, %lo(_ZL11_out_buffercPvjj)
	li	a2, -1
	addi	a4, sp, 8
	mv	a3, t0
	call	_ZL10_vsnprintfPFvcPvjjEPcjPKcS_
	lw	ra, 4(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	sprintf_, .Lfunc_end0-sprintf_
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function _ZL10_vsnprintfPFvcPvjjEPcjPKcS_
	.type	_ZL10_vsnprintfPFvcPvjjEPcjPKcS_,@function
_ZL10_vsnprintfPFvcPvjjEPcjPKcS_:       # @_ZL10_vsnprintfPFvcPvjjEPcjPKcS_
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	sw	s7, 44(sp)                      # 4-byte Folded Spill
	sw	s8, 40(sp)                      # 4-byte Folded Spill
	sw	s9, 36(sp)                      # 4-byte Folded Spill
	sw	s10, 32(sp)                     # 4-byte Folded Spill
	sw	s11, 28(sp)                     # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	.cfi_offset s5, -28
	.cfi_offset s6, -32
	.cfi_offset s7, -36
	.cfi_offset s8, -40
	.cfi_offset s9, -44
	.cfi_offset s10, -48
	.cfi_offset s11, -52
	sw	a4, 24(sp)                      # 4-byte Folded Spill
	mv	s5, a3
	mv	s0, a2
	mv	s2, a1
	beqz	a1, .LBB1_2
# %bb.1:
	mv	s1, a0
	j	.LBB1_3
.LBB1_2:
	lui	s1, %hi(_ZL9_out_nullcPvjj)
	addi	s1, s1, %lo(_ZL9_out_nullcPvjj)
.LBB1_3:
	li	s11, 0
	li	s9, 37
	li	s8, 42
	li	s7, 32
	li	s4, 43
	li	s10, 48
.LBB1_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_5 Depth 2
                                        #     Child Loop BB1_9 Depth 2
                                        #     Child Loop BB1_23 Depth 2
                                        #     Child Loop BB1_30 Depth 2
                                        #     Child Loop BB1_78 Depth 2
                                        #     Child Loop BB1_87 Depth 2
                                        #     Child Loop BB1_116 Depth 2
                                        #     Child Loop BB1_124 Depth 2
                                        #     Child Loop BB1_103 Depth 2
                                        #     Child Loop BB1_107 Depth 2
	addi	s6, s5, 2
.LBB1_5:                                #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a0, 0(s5)
	beqz	a0, .LBB1_126
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=2
	beq	a0, s9, .LBB1_8
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=2
	addi	s3, s11, 1
	mv	a1, s2
	mv	a2, s11
	mv	a3, s0
	jalr	s1
	addi	s5, s5, 1
	addi	s6, s6, 1
	mv	s11, s3
	j	.LBB1_5
.LBB1_8:                                #   in Loop: Header=BB1_4 Depth=1
	li	t4, 0
	li	a1, 35
	li	a2, 45
.LBB1_9:                                #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a0, -1(s6)
	bge	s8, a0, .LBB1_14
# %bb.10:                               #   in Loop: Header=BB1_9 Depth=2
	beq	a0, s4, .LBB1_19
# %bb.11:                               #   in Loop: Header=BB1_9 Depth=2
	beq	a0, s10, .LBB1_17
# %bb.12:                               #   in Loop: Header=BB1_9 Depth=2
	bne	a0, a2, .LBB1_21
# %bb.13:                               #   in Loop: Header=BB1_9 Depth=2
	li	a0, 2
	j	.LBB1_20
.LBB1_14:                               #   in Loop: Header=BB1_9 Depth=2
	beq	a0, s7, .LBB1_18
# %bb.15:                               #   in Loop: Header=BB1_9 Depth=2
	bne	a0, a1, .LBB1_21
# %bb.16:                               #   in Loop: Header=BB1_9 Depth=2
	li	a0, 16
	j	.LBB1_20
.LBB1_17:                               #   in Loop: Header=BB1_9 Depth=2
	li	a0, 1
	j	.LBB1_20
.LBB1_18:                               #   in Loop: Header=BB1_9 Depth=2
	li	a0, 8
	j	.LBB1_20
.LBB1_19:                               #   in Loop: Header=BB1_9 Depth=2
	li	a0, 4
.LBB1_20:                               #   in Loop: Header=BB1_9 Depth=2
	or	t4, t4, a0
	addi	s6, s6, 1
	j	.LBB1_9
.LBB1_21:                               #   in Loop: Header=BB1_4 Depth=1
	addi	a1, a0, -48
	zext.b	a1, a1
	addi	s7, s6, -1
	li	a2, 9
	bltu	a2, a1, .LBB1_24
# %bb.22:                               #   in Loop: Header=BB1_4 Depth=1
	li	s5, 0
	li	a3, 10
.LBB1_23:                               #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	zext.b	a1, a0
	lbu	a0, 1(s7)
	mul	a2, s5, a3
	addi	s7, s7, 1
	add	a1, a2, a1
	addi	a2, a0, -48
	zext.b	a2, a2
	addi	s5, a1, -48
	bltu	a2, a3, .LBB1_23
	j	.LBB1_27
.LBB1_24:                               #   in Loop: Header=BB1_4 Depth=1
	bne	a0, s8, .LBB1_26
# %bb.25:                               #   in Loop: Header=BB1_4 Depth=1
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	lw	a1, 0(a2)
	addi	a2, a2, 4
	srai	a0, a1, 31
	xor	a3, a1, a0
	sub	s5, a3, a0
	lbu	a0, 0(s6)
	srli	a1, a1, 30
	andi	a1, a1, 2
	or	t4, a1, t4
	mv	s7, s6
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	j	.LBB1_27
.LBB1_26:                               #   in Loop: Header=BB1_4 Depth=1
	li	s5, 0
.LBB1_27:                               #   in Loop: Header=BB1_4 Depth=1
	li	a1, 46
	bne	a0, a1, .LBB1_31
# %bb.28:                               #   in Loop: Header=BB1_4 Depth=1
	lbu	a0, 1(s7)
	ori	t4, t4, 1024
	addi	a1, a0, -48
	zext.b	a2, a1
	addi	a1, s7, 1
	li	a3, 9
	bltu	a3, a2, .LBB1_32
# %bb.29:                               #   in Loop: Header=BB1_4 Depth=1
	li	a4, 10
	li	s6, 0
.LBB1_30:                               #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	zext.b	a2, a0
	lbu	a0, 1(a1)
	mul	a3, s6, a4
	addi	a1, a1, 1
	add	a2, a3, a2
	addi	a3, a0, -48
	zext.b	a3, a3
	addi	s6, a2, -48
	bltu	a3, a4, .LBB1_30
	j	.LBB1_35
.LBB1_31:                               #   in Loop: Header=BB1_4 Depth=1
	li	s6, 0
	j	.LBB1_36
.LBB1_32:                               #   in Loop: Header=BB1_4 Depth=1
	bne	a0, s8, .LBB1_34
# %bb.33:                               #   in Loop: Header=BB1_4 Depth=1
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	lw	a1, 0(a2)
	addi	a2, a2, 4
	lbu	a0, 2(s7)
	sgtz	a3, a1
	neg	a3, a3
	addi	s7, s7, 2
	and	s6, a3, a1
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	j	.LBB1_36
.LBB1_34:                               #   in Loop: Header=BB1_4 Depth=1
	li	s6, 0
.LBB1_35:                               #   in Loop: Header=BB1_4 Depth=1
	mv	s7, a1
.LBB1_36:                               #   in Loop: Header=BB1_4 Depth=1
	addi	a1, a0, -104
	srli	a2, a1, 1
	slli	a1, a1, 31
	or	a1, a1, a2
	li	a2, 9
	bltu	a2, a1, .LBB1_44
# %bb.37:                               #   in Loop: Header=BB1_4 Depth=1
	slli	a1, a1, 2
	lui	a2, %hi(.LJTI1_0)
	addi	a2, a2, %lo(.LJTI1_0)
	add	a1, a2, a1
	lw	a3, 0(a1)
	li	a1, 1
	li	a2, 256
	jr	a3
.LBB1_38:                               #   in Loop: Header=BB1_4 Depth=1
	lbu	a0, 1(s7)
	li	a1, 104
	bne	a0, a1, .LBB1_92
# %bb.39:                               #   in Loop: Header=BB1_4 Depth=1
	li	a1, 2
	li	a2, 192
	j	.LBB1_43
.LBB1_40:                               #   in Loop: Header=BB1_4 Depth=1
	li	a2, 512
	j	.LBB1_43
.LBB1_41:                               #   in Loop: Header=BB1_4 Depth=1
	lbu	a0, 1(s7)
	li	a1, 108
	bne	a0, a1, .LBB1_93
# %bb.42:                               #   in Loop: Header=BB1_4 Depth=1
	li	a1, 2
	li	a2, 768
.LBB1_43:                               #   in Loop: Header=BB1_4 Depth=1
	add	s7, s7, a1
	lbu	a0, 0(s7)
	or	t4, t4, a2
.LBB1_44:                               #   in Loop: Header=BB1_4 Depth=1
	li	a6, 16
	li	a1, 97
	bge	a1, a0, .LBB1_48
# %bb.45:                               #   in Loop: Header=BB1_4 Depth=1
	addi	a1, a0, -98
	li	a2, 19
	bltu	a2, a1, .LBB1_52
# %bb.46:                               #   in Loop: Header=BB1_4 Depth=1
	slli	a1, a1, 2
	lui	a2, %hi(.LJTI1_1)
	addi	a2, a2, %lo(.LJTI1_1)
	add	a1, a2, a1
	lw	a1, 0(a1)
	li	a6, 8
	jr	a1
.LBB1_47:                               #   in Loop: Header=BB1_4 Depth=1
	andi	t4, t4, -17
	li	a6, 10
	j	.LBB1_50
.LBB1_48:                               #   in Loop: Header=BB1_4 Depth=1
	beq	a0, s9, .LBB1_89
# %bb.49:                               #   in Loop: Header=BB1_4 Depth=1
	li	a1, 88
	bne	a0, a1, .LBB1_53
.LBB1_50:                               #   in Loop: Header=BB1_4 Depth=1
	addi	a1, a0, -88
	seqz	a1, a1
	slli	a1, a1, 5
	or	t4, t4, a1
	li	a1, 100
	beq	a0, a1, .LBB1_59
# %bb.51:                               #   in Loop: Header=BB1_4 Depth=1
	li	a1, 105
	bne	a0, a1, .LBB1_58
	j	.LBB1_59
.LBB1_52:                               #   in Loop: Header=BB1_4 Depth=1
	li	a1, 120
	beq	a0, a1, .LBB1_50
.LBB1_53:                               #   in Loop: Header=BB1_4 Depth=1
	addi	s3, s11, 1
	j	.LBB1_90
.LBB1_54:                               #   in Loop: Header=BB1_4 Depth=1
	lw	s3, 24(sp)                      # 4-byte Folded Reload
	lw	a4, 0(s3)
	ori	t4, t4, 33
	addi	s3, s3, 4
	li	a6, 16
	li	t3, 8
	mv	a0, s1
	mv	a1, s2
	mv	a2, s11
	mv	a3, s0
	li	a5, 0
	mv	a7, s6
	j	.LBB1_99
.LBB1_55:                               #   in Loop: Header=BB1_4 Depth=1
	andi	a0, t4, 2
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_101
# %bb.56:                               #   in Loop: Header=BB1_4 Depth=1
	li	s6, 1
	j	.LBB1_104
.LBB1_57:                               #   in Loop: Header=BB1_4 Depth=1
	li	a6, 2
.LBB1_58:                               #   in Loop: Header=BB1_4 Depth=1
	andi	t4, t4, -13
.LBB1_59:                               #   in Loop: Header=BB1_4 Depth=1
	andi	a1, t4, 1024
	beqz	a1, .LBB1_61
# %bb.60:                               #   in Loop: Header=BB1_4 Depth=1
	andi	t4, t4, -2
.LBB1_61:                               #   in Loop: Header=BB1_4 Depth=1
	andi	a1, t4, 512
	li	a2, 105
	beq	a0, a2, .LBB1_63
# %bb.62:                               #   in Loop: Header=BB1_4 Depth=1
	li	a2, 100
	bne	a0, a2, .LBB1_69
.LBB1_63:                               #   in Loop: Header=BB1_4 Depth=1
	bnez	a1, .LBB1_111
# %bb.64:                               #   in Loop: Header=BB1_4 Depth=1
	andi	a0, t4, 256
	bnez	a0, .LBB1_75
# %bb.65:                               #   in Loop: Header=BB1_4 Depth=1
	andi	a0, t4, 64
	bnez	a0, .LBB1_95
# %bb.66:                               #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	lw	a5, 0(a0)
	andi	a0, t4, 128
	beqz	a0, .LBB1_68
# %bb.67:                               #   in Loop: Header=BB1_4 Depth=1
	slli	a5, a5, 16
	srai	a5, a5, 16
.LBB1_68:                               #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	j	.LBB1_96
.LBB1_69:                               #   in Loop: Header=BB1_4 Depth=1
	bnez	a1, .LBB1_111
# %bb.70:                               #   in Loop: Header=BB1_4 Depth=1
	andi	a0, t4, 256
	bnez	a0, .LBB1_97
# %bb.71:                               #   in Loop: Header=BB1_4 Depth=1
	andi	a0, t4, 64
	bnez	a0, .LBB1_108
# %bb.72:                               #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	lw	a4, 0(a0)
	andi	a0, t4, 128
	beqz	a0, .LBB1_74
# %bb.73:                               #   in Loop: Header=BB1_4 Depth=1
	slli	a4, a4, 16
	srli	a4, a4, 16
.LBB1_74:                               #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	j	.LBB1_109
.LBB1_75:                               #   in Loop: Header=BB1_4 Depth=1
	lw	s3, 24(sp)                      # 4-byte Folded Reload
	lw	a5, 0(s3)
	addi	s3, s3, 4
	srai	a0, a5, 31
	xor	a4, a5, a0
	sub	a4, a4, a0
	srli	a5, a5, 31
	mv	a0, s1
	mv	a1, s2
	mv	a2, s11
	mv	a3, s0
	j	.LBB1_98
.LBB1_76:                               #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	lw	s9, 0(a0)
	lbu	a0, 0(s9)
	mv	a1, s9
	beqz	a0, .LBB1_80
# %bb.77:                               #   in Loop: Header=BB1_4 Depth=1
	snez	a1, s6
	addi	a1, a1, -1
	or	a2, a1, s6
	addi	a2, a2, -1
	mv	a1, s9
.LBB1_78:                               #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a4, 1(a1)
	addi	a1, a1, 1
	beqz	a4, .LBB1_80
# %bb.79:                               #   in Loop: Header=BB1_78 Depth=2
	mv	a3, a2
	addi	a2, a2, -1
	bnez	a3, .LBB1_78
.LBB1_80:                               #   in Loop: Header=BB1_4 Depth=1
	sub	a1, a1, s9
	mv	a2, a1
	bltu	a1, s6, .LBB1_82
# %bb.81:                               #   in Loop: Header=BB1_4 Depth=1
	mv	a2, s6
.LBB1_82:                               #   in Loop: Header=BB1_4 Depth=1
	andi	a3, t4, 1024
	sw	a3, 20(sp)                      # 4-byte Folded Spill
	beqz	a3, .LBB1_84
# %bb.83:                               #   in Loop: Header=BB1_4 Depth=1
	mv	a1, a2
.LBB1_84:                               #   in Loop: Header=BB1_4 Depth=1
	andi	a2, t4, 2
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	bnez	a2, .LBB1_113
# %bb.85:                               #   in Loop: Header=BB1_4 Depth=1
	bgeu	a1, s5, .LBB1_112
# %bb.86:                               #   in Loop: Header=BB1_4 Depth=1
	addi	a0, s5, 1
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	sub	s3, s5, a1
.LBB1_87:                               #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mv	a2, s11
	addi	s11, s11, 1
	li	a0, 32
	mv	a1, s2
	mv	a3, s0
	jalr	s1
	addi	s3, s3, -1
	bnez	s3, .LBB1_87
# %bb.88:                               #   in Loop: Header=BB1_4 Depth=1
	lbu	a0, 0(s9)
	j	.LBB1_114
.LBB1_89:                               #   in Loop: Header=BB1_4 Depth=1
	addi	s3, s11, 1
	li	a0, 37
.LBB1_90:                               #   in Loop: Header=BB1_4 Depth=1
	mv	a1, s2
	mv	a2, s11
	mv	a3, s0
	jalr	s1
.LBB1_91:                               #   in Loop: Header=BB1_4 Depth=1
	mv	s11, s3
	j	.LBB1_111
.LBB1_92:                               #   in Loop: Header=BB1_4 Depth=1
	ori	t4, t4, 128
	j	.LBB1_94
.LBB1_93:                               #   in Loop: Header=BB1_4 Depth=1
	ori	t4, t4, 256
.LBB1_94:                               #   in Loop: Header=BB1_4 Depth=1
	addi	s7, s7, 1
	j	.LBB1_44
.LBB1_95:                               #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	lbu	a5, 0(a0)
.LBB1_96:                               #   in Loop: Header=BB1_4 Depth=1
	addi	a0, a0, 4
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	srai	a0, a5, 31
	xor	a4, a5, a0
	sub	a4, a4, a0
	srli	a5, a5, 31
	mv	a0, s1
	mv	a1, s2
	mv	a2, s11
	mv	a3, s0
	j	.LBB1_110
.LBB1_97:                               #   in Loop: Header=BB1_4 Depth=1
	lw	s3, 24(sp)                      # 4-byte Folded Reload
	lw	a4, 0(s3)
	addi	s3, s3, 4
	mv	a0, s1
	mv	a1, s2
	mv	a2, s11
	mv	a3, s0
	li	a5, 0
.LBB1_98:                               #   in Loop: Header=BB1_4 Depth=1
	mv	a7, s6
	mv	t3, s5
.LBB1_99:                               #   in Loop: Header=BB1_4 Depth=1
	call	_ZL10_ntoa_longPFvcPvjjEPcjjmbmjjj
	mv	s11, a0
.LBB1_100:                              #   in Loop: Header=BB1_4 Depth=1
	sw	s3, 24(sp)                      # 4-byte Folded Spill
	j	.LBB1_111
.LBB1_101:                              #   in Loop: Header=BB1_4 Depth=1
	li	s6, 2
	bltu	s5, s6, .LBB1_104
# %bb.102:                              #   in Loop: Header=BB1_4 Depth=1
	addi	s6, s5, 1
	addi	s3, s5, -1
.LBB1_103:                              #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mv	a2, s11
	addi	s11, s11, 1
	li	a0, 32
	mv	a1, s2
	mv	a3, s0
	jalr	s1
	addi	s3, s3, -1
	bnez	s3, .LBB1_103
.LBB1_104:                              #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	mv	s3, a0
	lbu	a0, 0(a0)
	mv	a2, s11
	addi	s3, s3, 4
	addi	s11, s11, 1
	mv	a1, s2
	mv	a3, s0
	jalr	s1
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	beqz	a0, .LBB1_100
# %bb.105:                              #   in Loop: Header=BB1_4 Depth=1
	bgeu	s6, s5, .LBB1_100
# %bb.106:                              #   in Loop: Header=BB1_4 Depth=1
	sub	s5, s5, s6
.LBB1_107:                              #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mv	a2, s11
	addi	s11, s11, 1
	li	a0, 32
	mv	a1, s2
	mv	a3, s0
	jalr	s1
	addi	s5, s5, -1
	bnez	s5, .LBB1_107
	j	.LBB1_100
.LBB1_108:                              #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	lbu	a4, 0(a0)
.LBB1_109:                              #   in Loop: Header=BB1_4 Depth=1
	addi	a0, a0, 4
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	mv	a0, s1
	mv	a1, s2
	mv	a2, s11
	mv	a3, s0
	li	a5, 0
.LBB1_110:                              #   in Loop: Header=BB1_4 Depth=1
	mv	a7, s6
	mv	t3, s5
	call	_ZL10_ntoa_longPFvcPvjjEPcjjmbmjjj
	mv	s11, a0
.LBB1_111:                              #   in Loop: Header=BB1_4 Depth=1
	addi	s5, s7, 1
	li	s7, 32
	j	.LBB1_4
.LBB1_112:                              #   in Loop: Header=BB1_4 Depth=1
	addi	a1, a1, 1
.LBB1_113:                              #   in Loop: Header=BB1_4 Depth=1
	sw	a1, 12(sp)                      # 4-byte Folded Spill
.LBB1_114:                              #   in Loop: Header=BB1_4 Depth=1
	beqz	a0, .LBB1_120
# %bb.115:                              #   in Loop: Header=BB1_4 Depth=1
	addi	s9, s9, 1
.LBB1_116:                              #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a1, 20(sp)                      # 4-byte Folded Reload
	beqz	a1, .LBB1_119
# %bb.117:                              #   in Loop: Header=BB1_116 Depth=2
	beqz	s6, .LBB1_120
# %bb.118:                              #   in Loop: Header=BB1_116 Depth=2
	addi	s6, s6, -1
.LBB1_119:                              #   in Loop: Header=BB1_116 Depth=2
	addi	s3, s11, 1
	zext.b	a0, a0
	mv	a1, s2
	mv	a2, s11
	mv	a3, s0
	jalr	s1
	lbu	a0, 0(s9)
	addi	s9, s9, 1
	mv	s11, s3
	bnez	a0, .LBB1_116
	j	.LBB1_121
.LBB1_120:                              #   in Loop: Header=BB1_4 Depth=1
	mv	s3, s11
.LBB1_121:                              #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	addi	a0, a0, 4
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	beqz	a1, .LBB1_125
# %bb.122:                              #   in Loop: Header=BB1_4 Depth=1
	li	s9, 37
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	bgeu	a0, s5, .LBB1_91
# %bb.123:                              #   in Loop: Header=BB1_4 Depth=1
	sub	s5, s5, a0
.LBB1_124:                              #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mv	a2, s3
	addi	s3, s3, 1
	li	a0, 32
	mv	a1, s2
	mv	a3, s0
	jalr	s1
	addi	s5, s5, -1
	bnez	s5, .LBB1_124
	j	.LBB1_91
.LBB1_125:                              #   in Loop: Header=BB1_4 Depth=1
	mv	s11, s3
	li	s9, 37
	j	.LBB1_111
.LBB1_126:
	mv	a2, s11
	bltu	s11, s0, .LBB1_128
# %bb.127:
	addi	a2, s0, -1
.LBB1_128:
	li	a0, 0
	mv	a1, s2
	mv	a3, s0
	jalr	s1
	mv	a0, s11
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	lw	s7, 44(sp)                      # 4-byte Folded Reload
	lw	s8, 40(sp)                      # 4-byte Folded Reload
	lw	s9, 36(sp)                      # 4-byte Folded Reload
	lw	s10, 32(sp)                     # 4-byte Folded Reload
	lw	s11, 28(sp)                     # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	.cfi_restore s5
	.cfi_restore s6
	.cfi_restore s7
	.cfi_restore s8
	.cfi_restore s9
	.cfi_restore s10
	.cfi_restore s11
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	_ZL10_vsnprintfPFvcPvjjEPcjPKcS_, .Lfunc_end1-_ZL10_vsnprintfPFvcPvjjEPcjPKcS_
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI1_0:
	.word	.LBB1_38
	.word	.LBB1_40
	.word	.LBB1_41
	.word	.LBB1_44
	.word	.LBB1_44
	.word	.LBB1_44
	.word	.LBB1_43
	.word	.LBB1_44
	.word	.LBB1_44
	.word	.LBB1_43
.LJTI1_1:
	.word	.LBB1_57
	.word	.LBB1_55
	.word	.LBB1_47
	.word	.LBB1_53
	.word	.LBB1_53
	.word	.LBB1_53
	.word	.LBB1_53
	.word	.LBB1_47
	.word	.LBB1_53
	.word	.LBB1_53
	.word	.LBB1_53
	.word	.LBB1_53
	.word	.LBB1_53
	.word	.LBB1_58
	.word	.LBB1_54
	.word	.LBB1_53
	.word	.LBB1_53
	.word	.LBB1_76
	.word	.LBB1_53
	.word	.LBB1_47
                                        # -- End function
	.text
	.p2align	2                               # -- Begin function _ZL11_out_buffercPvjj
	.type	_ZL11_out_buffercPvjj,@function
_ZL11_out_buffercPvjj:                  # @_ZL11_out_buffercPvjj
# %bb.0:
	bgeu	a2, a3, .LBB2_2
# %bb.1:
	add	a1, a1, a2
	sb	a0, 0(a1)
.LBB2_2:
	ret
.Lfunc_end2:
	.size	_ZL11_out_buffercPvjj, .Lfunc_end2-_ZL11_out_buffercPvjj
                                        # -- End function
	.globl	snprintf_                       # -- Begin function snprintf_
	.p2align	2
	.type	snprintf_,@function
snprintf_:                              # @snprintf_
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 4(sp)                       # 4-byte Folded Spill
	.cfi_offset ra, -28
	mv	t0, a2
	mv	a2, a1
	mv	a1, a0
	sw	a7, 28(sp)
	sw	a3, 12(sp)
	sw	a4, 16(sp)
	sw	a5, 20(sp)
	sw	a6, 24(sp)
	addi	a0, sp, 12
	sw	a0, 0(sp)
	lui	a0, %hi(_ZL11_out_buffercPvjj)
	addi	a0, a0, %lo(_ZL11_out_buffercPvjj)
	addi	a4, sp, 12
	mv	a3, t0
	call	_ZL10_vsnprintfPFvcPvjjEPcjPKcS_
	lw	ra, 4(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	snprintf_, .Lfunc_end3-snprintf_
	.cfi_endproc
                                        # -- End function
	.globl	vsnprintf_                      # -- Begin function vsnprintf_
	.p2align	2
	.type	vsnprintf_,@function
vsnprintf_:                             # @vsnprintf_
	.cfi_startproc
# %bb.0:
	mv	a4, a3
	mv	a3, a2
	mv	a2, a1
	lui	a1, %hi(_ZL11_out_buffercPvjj)
	addi	a1, a1, %lo(_ZL11_out_buffercPvjj)
	mv	a5, a0
	mv	a0, a1
	mv	a1, a5
	tail	_ZL10_vsnprintfPFvcPvjjEPcjPKcS_
.Lfunc_end4:
	.size	vsnprintf_, .Lfunc_end4-vsnprintf_
	.cfi_endproc
                                        # -- End function
	.globl	fctprintf                       # -- Begin function fctprintf
	.p2align	2
	.type	fctprintf,@function
fctprintf:                              # @fctprintf
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 20(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -28
	mv	t0, a2
	sw	a7, 44(sp)
	sw	a3, 28(sp)
	sw	a4, 32(sp)
	sw	a5, 36(sp)
	sw	a6, 40(sp)
	addi	a2, sp, 28
	sw	a2, 16(sp)
	sw	a0, 8(sp)
	sw	a1, 12(sp)
	lui	a0, %hi(_ZL8_out_fctcPvjj)
	addi	a0, a0, %lo(_ZL8_out_fctcPvjj)
	addi	a1, sp, 8
	li	a2, -1
	addi	a4, sp, 28
	mv	a3, t0
	call	_ZL10_vsnprintfPFvcPvjjEPcjPKcS_
	lw	ra, 20(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	fctprintf, .Lfunc_end5-fctprintf
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function _ZL8_out_fctcPvjj
	.type	_ZL8_out_fctcPvjj,@function
_ZL8_out_fctcPvjj:                      # @_ZL8_out_fctcPvjj
	.cfi_startproc
# %bb.0:
	beqz	a0, .LBB6_2
# %bb.1:
	lw	t1, 0(a1)
	lw	a1, 4(a1)
	jr	t1
.LBB6_2:
	ret
.Lfunc_end6:
	.size	_ZL8_out_fctcPvjj, .Lfunc_end6-_ZL8_out_fctcPvjj
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function _ZL9_out_nullcPvjj
	.type	_ZL9_out_nullcPvjj,@function
_ZL9_out_nullcPvjj:                     # @_ZL9_out_nullcPvjj
# %bb.0:
	ret
.Lfunc_end7:
	.size	_ZL9_out_nullcPvjj, .Lfunc_end7-_ZL9_out_nullcPvjj
                                        # -- End function
	.p2align	2                               # -- Begin function _ZL10_ntoa_longPFvcPvjjEPcjjmbmjjj
	.type	_ZL10_ntoa_longPFvcPvjjEPcjjmbmjjj,@function
_ZL10_ntoa_longPFvcPvjjEPcjjmbmjjj:     # @_ZL10_ntoa_longPFvcPvjjEPcjjmbmjjj
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	sw	s7, 44(sp)                      # 4-byte Folded Spill
	sw	s8, 40(sp)                      # 4-byte Folded Spill
	sw	s9, 36(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	.cfi_offset s5, -28
	.cfi_offset s6, -32
	.cfi_offset s7, -36
	.cfi_offset s8, -40
	.cfi_offset s9, -44
	mv	s0, t3
	mv	s1, a3
	mv	s4, a2
	mv	s2, a1
	mv	s3, a0
	bnez	a4, .LBB8_2
# %bb.1:
	andi	t4, t4, -17
.LBB8_2:
	andi	a0, t4, 1024
	bnez	a4, .LBB8_5
# %bb.3:
	beqz	a0, .LBB8_5
# %bb.4:
	li	s6, 0
	j	.LBB8_11
.LBB8_5:
	li	s6, 0
	andi	a3, t4, 32
	li	a1, 10
	addi	a2, sp, 4
	xori	a3, a3, 97
	addi	a3, a3, 246
	li	t0, 31
.LBB8_6:                                # =>This Inner Loop Header: Depth=1
	divu	t1, a4, a6
	mul	t2, t1, a6
	sub	t3, a4, t2
	mv	t2, s6
	bltu	t3, a1, .LBB8_8
# %bb.7:                                #   in Loop: Header=BB8_6 Depth=1
	add	t3, a3, t3
	j	.LBB8_9
.LBB8_8:                                #   in Loop: Header=BB8_6 Depth=1
	addi	t3, t3, 48
.LBB8_9:                                #   in Loop: Header=BB8_6 Depth=1
	addi	s6, t2, 1
	add	t5, a2, t2
	sb	t3, 0(t5)
	bltu	a4, a6, .LBB8_11
# %bb.10:                               #   in Loop: Header=BB8_6 Depth=1
	mv	a4, t1
	bltu	t2, t0, .LBB8_6
.LBB8_11:
	andi	s7, t4, 2
	bnez	s7, .LBB8_30
# %bb.12:
	andi	a1, t4, 1
	beqz	s0, .LBB8_15
# %bb.13:
	beqz	a1, .LBB8_15
# %bb.14:
	andi	a2, t4, 12
	snez	a2, a2
	or	a2, a5, a2
	sub	s0, s0, a2
.LBB8_15:
	li	a3, 32
	mv	a2, a7
	bgeu	a7, a3, .LBB8_18
# %bb.16:
	bltu	s6, a2, .LBB8_19
.LBB8_17:
	bnez	a1, .LBB8_22
	j	.LBB8_30
.LBB8_18:
	li	a2, 32
	bgeu	s6, a2, .LBB8_17
.LBB8_19:
	addi	a3, sp, 4
	add	s6, a3, s6
	add	a3, a3, a2
	li	a4, 48
.LBB8_20:                               # =>This Inner Loop Header: Depth=1
	sb	a4, 0(s6)
	addi	s6, s6, 1
	bne	s6, a3, .LBB8_20
# %bb.21:
	mv	s6, a2
	beqz	a1, .LBB8_30
.LBB8_22:
	li	a1, 32
	mv	a2, s0
	bltu	s0, a1, .LBB8_24
# %bb.23:
	li	a2, 32
.LBB8_24:
	mv	a1, s6
	bltu	a2, s6, .LBB8_26
# %bb.25:
	mv	a1, a2
.LBB8_26:
	bgeu	s6, a2, .LBB8_29
# %bb.27:
	sub	a2, a1, s6
	addi	a3, sp, 4
	add	s6, a3, s6
	li	a3, 48
.LBB8_28:                               # =>This Inner Loop Header: Depth=1
	sb	a3, 0(s6)
	addi	a2, a2, -1
	addi	s6, s6, 1
	bnez	a2, .LBB8_28
.LBB8_29:
	mv	s6, a1
.LBB8_30:
	andi	a1, t4, 16
	beqz	a1, .LBB8_51
# %bb.31:
	bnez	a0, .LBB8_38
# %bb.32:
	beqz	s6, .LBB8_38
# %bb.33:
	beq	s6, a7, .LBB8_35
# %bb.34:
	bne	s6, s0, .LBB8_38
.LBB8_35:
	addi	a0, s6, -1
	addi	a1, a6, -16
	snez	a2, a0
	seqz	a1, a1
	and	a1, a1, a2
	beqz	a1, .LBB8_37
# %bb.36:
	addi	a0, s6, -2
.LBB8_37:
	mv	s6, a0
.LBB8_38:
	li	a0, 16
	bne	a6, a0, .LBB8_42
# %bb.39:
	andi	a0, t4, 32
	bnez	a0, .LBB8_45
# %bb.40:
	li	a1, 32
	bgeu	s6, a1, .LBB8_45
# %bb.41:
	li	a0, 120
	j	.LBB8_48
.LBB8_42:
	li	a0, 2
	bne	a6, a0, .LBB8_49
# %bb.43:
	li	a0, 31
	bltu	a0, s6, .LBB8_49
# %bb.44:
	li	a0, 98
	j	.LBB8_48
.LBB8_45:
	beqz	a0, .LBB8_49
# %bb.46:
	li	a0, 32
	bgeu	s6, a0, .LBB8_49
# %bb.47:
	li	a0, 88
.LBB8_48:
	addi	a1, sp, 4
	add	a1, a1, s6
	addi	s6, s6, 1
	sb	a0, 0(a1)
.LBB8_49:
	li	a0, 31
	bltu	a0, s6, .LBB8_60
# %bb.50:
	addi	a0, sp, 4
	add	a0, a0, s6
	addi	s6, s6, 1
	li	a1, 48
	sb	a1, 0(a0)
.LBB8_51:
	li	a0, 31
	bltu	a0, s6, .LBB8_54
# %bb.52:
	beqz	a5, .LBB8_55
# %bb.53:
	li	a0, 45
	j	.LBB8_59
.LBB8_54:
	li	s6, 32
	j	.LBB8_60
.LBB8_55:
	andi	a0, t4, 4
	bnez	a0, .LBB8_58
# %bb.56:
	andi	a0, t4, 8
	beqz	a0, .LBB8_60
# %bb.57:
	li	a0, 32
	j	.LBB8_59
.LBB8_58:
	li	a0, 43
.LBB8_59:
	addi	a1, sp, 4
	add	a1, a1, s6
	addi	s6, s6, 1
	sb	a0, 0(a1)
.LBB8_60:
	andi	a0, t4, 3
	mv	s5, s4
	bnez	a0, .LBB8_64
# %bb.61:
	mv	s5, s4
	bgeu	s6, s0, .LBB8_64
# %bb.62:
	sub	s8, s0, s6
	mv	a2, s4
.LBB8_63:                               # =>This Inner Loop Header: Depth=1
	addi	s5, a2, 1
	li	a0, 32
	mv	a1, s2
	mv	a3, s1
	jalr	s3
	addi	s8, s8, -1
	mv	a2, s5
	bnez	s8, .LBB8_63
.LBB8_64:
	beqz	s6, .LBB8_68
# %bb.65:
	neg	s8, s6
	addi	a0, sp, 4
	add	a0, s6, a0
	addi	s9, a0, -1
.LBB8_66:                               # =>This Inner Loop Header: Depth=1
	lbu	a0, 0(s9)
	addi	s6, s5, 1
	mv	a1, s2
	mv	a2, s5
	mv	a3, s1
	jalr	s3
	addi	s8, s8, 1
	addi	s9, s9, -1
	mv	s5, s6
	bnez	s8, .LBB8_66
# %bb.67:
	bnez	s7, .LBB8_69
	j	.LBB8_72
.LBB8_68:
	mv	s6, s5
	beqz	s7, .LBB8_72
.LBB8_69:
	sub	a0, s6, s4
	bgeu	a0, s0, .LBB8_72
# %bb.70:
	neg	s5, s4
.LBB8_71:                               # =>This Inner Loop Header: Depth=1
	addi	s4, s6, 1
	li	a0, 32
	mv	a1, s2
	mv	a2, s6
	mv	a3, s1
	jalr	s3
	add	a0, s5, s4
	mv	s6, s4
	bltu	a0, s0, .LBB8_71
	j	.LBB8_73
.LBB8_72:
	mv	s4, s6
.LBB8_73:
	mv	a0, s4
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	lw	s7, 44(sp)                      # 4-byte Folded Reload
	lw	s8, 40(sp)                      # 4-byte Folded Reload
	lw	s9, 36(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	.cfi_restore s5
	.cfi_restore s6
	.cfi_restore s7
	.cfi_restore s8
	.cfi_restore s9
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	_ZL10_ntoa_longPFvcPvjjEPcjjmbmjjj, .Lfunc_end8-_ZL10_ntoa_longPFvcPvjjEPcjjmbmjjj
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _ZL11_out_buffercPvjj
	.addrsig_sym _ZL8_out_fctcPvjj
	.addrsig_sym _ZL9_out_nullcPvjj
