	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"Veci2.cpp"
	.text
	.globl	_ZN5Halib5Veci2C2Eii            # -- Begin function _ZN5Halib5Veci2C2Eii
	.p2align	2
	.type	_ZN5Halib5Veci2C2Eii,@function
_ZN5Halib5Veci2C2Eii:                   # @_ZN5Halib5Veci2C2Eii
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a1, -12(s0)
	lw	a0, -16(s0)
	sw	a0, 0(a1)
	lw	a0, -20(s0)
	sw	a0, 4(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	_ZN5Halib5Veci2C2Eii, .Lfunc_end0-_ZN5Halib5Veci2C2Eii
                                        # -- End function
	.globl	_ZNK5Halib5Veci29MagnitudeEv    # -- Begin function _ZNK5Halib5Veci29MagnitudeEv
	.p2align	2
	.type	_ZNK5Halib5Veci29MagnitudeEv,@function
_ZNK5Halib5Veci29MagnitudeEv:           # @_ZNK5Halib5Veci29MagnitudeEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	li	a0, 0
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	_ZNK5Halib5Veci29MagnitudeEv, .Lfunc_end1-_ZNK5Halib5Veci29MagnitudeEv
                                        # -- End function
	.globl	_ZN5Halib5Veci210DotProductERKS0_ # -- Begin function _ZN5Halib5Veci210DotProductERKS0_
	.p2align	2
	.type	_ZN5Halib5Veci210DotProductERKS0_,@function
_ZN5Halib5Veci210DotProductERKS0_:      # @_ZN5Halib5Veci210DotProductERKS0_
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	lw	a2, -16(s0)
	lw	a3, 0(a2)
	mul	a0, a0, a3
	lw	a1, 4(a1)
	lw	a2, 4(a2)
	mul	a1, a1, a2
	add	a0, a0, a1
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	_ZN5Halib5Veci210DotProductERKS0_, .Lfunc_end2-_ZN5Halib5Veci210DotProductERKS0_
                                        # -- End function
	.globl	_ZN5Halib5Veci212CrossProductERKS0_ # -- Begin function _ZN5Halib5Veci212CrossProductERKS0_
	.p2align	2
	.type	_ZN5Halib5Veci212CrossProductERKS0_,@function
_ZN5Halib5Veci212CrossProductERKS0_:    # @_ZN5Halib5Veci212CrossProductERKS0_
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a2, -12(s0)
	lw	a0, 0(a2)
	lw	a1, -16(s0)
	lw	a3, 4(a1)
	mul	a0, a0, a3
	lw	a1, 0(a1)
	lw	a2, 4(a2)
	mul	a1, a1, a2
	sub	a0, a0, a1
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end3:
	.size	_ZN5Halib5Veci212CrossProductERKS0_, .Lfunc_end3-_ZN5Halib5Veci212CrossProductERKS0_
                                        # -- End function
	.globl	_ZNK5Halib5Veci2ngEv            # -- Begin function _ZNK5Halib5Veci2ngEv
	.p2align	2
	.type	_ZNK5Halib5Veci2ngEv,@function
_ZNK5Halib5Veci2ngEv:                   # @_ZNK5Halib5Veci2ngEv
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -20(s0)
	lw	a2, -20(s0)
	lw	a1, 0(a2)
	li	a0, 0
	sub	a1, a0, a1
	lw	a2, 4(a2)
	sub	a2, a0, a2
	addi	a0, s0, -16
	call	_ZN5Halib5Veci2C1Eii
	lw	a0, -16(s0)
	lw	a1, -12(s0)
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	_ZNK5Halib5Veci2ngEv, .Lfunc_end4-_ZNK5Halib5Veci2ngEv
	.cfi_endproc
                                        # -- End function
	.globl	_ZNK5Halib5Veci2plERKS0_        # -- Begin function _ZNK5Halib5Veci2plERKS0_
	.p2align	2
	.type	_ZNK5Halib5Veci2plERKS0_,@function
_ZNK5Halib5Veci2plERKS0_:               # @_ZNK5Halib5Veci2plERKS0_
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -20(s0)
	sw	a1, -24(s0)
	lw	a0, -20(s0)
	lw	a1, 0(a0)
	lw	a2, -24(s0)
	lw	a3, 0(a2)
	add	a1, a1, a3
	lw	a0, 4(a0)
	lw	a2, 4(a2)
	add	a2, a0, a2
	addi	a0, s0, -16
	call	_ZN5Halib5Veci2C1Eii
	lw	a0, -16(s0)
	lw	a1, -12(s0)
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	_ZNK5Halib5Veci2plERKS0_, .Lfunc_end5-_ZNK5Halib5Veci2plERKS0_
	.cfi_endproc
                                        # -- End function
	.globl	_ZNK5Halib5Veci2miERKS0_        # -- Begin function _ZNK5Halib5Veci2miERKS0_
	.p2align	2
	.type	_ZNK5Halib5Veci2miERKS0_,@function
_ZNK5Halib5Veci2miERKS0_:               # @_ZNK5Halib5Veci2miERKS0_
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -20(s0)
	sw	a1, -24(s0)
	lw	a0, -20(s0)
	lw	a1, 0(a0)
	lw	a2, -24(s0)
	lw	a3, 0(a2)
	sub	a1, a1, a3
	lw	a0, 4(a0)
	lw	a2, 4(a2)
	sub	a2, a0, a2
	addi	a0, s0, -16
	call	_ZN5Halib5Veci2C1Eii
	lw	a0, -16(s0)
	lw	a1, -12(s0)
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	_ZNK5Halib5Veci2miERKS0_, .Lfunc_end6-_ZNK5Halib5Veci2miERKS0_
	.cfi_endproc
                                        # -- End function
	.globl	_ZNK5Halib5Veci2mlEi            # -- Begin function _ZNK5Halib5Veci2mlEi
	.p2align	2
	.type	_ZNK5Halib5Veci2mlEi,@function
_ZNK5Halib5Veci2mlEi:                   # @_ZNK5Halib5Veci2mlEi
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -20(s0)
	sw	a1, -24(s0)
	lw	a0, -20(s0)
	lw	a1, 0(a0)
	lw	a2, -24(s0)
	mul	a1, a1, a2
	lw	a0, 4(a0)
	mul	a2, a0, a2
	addi	a0, s0, -16
	call	_ZN5Halib5Veci2C1Eii
	lw	a0, -16(s0)
	lw	a1, -12(s0)
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	_ZNK5Halib5Veci2mlEi, .Lfunc_end7-_ZNK5Halib5Veci2mlEi
	.cfi_endproc
                                        # -- End function
	.globl	_ZNK5Halib5Veci2dvEi            # -- Begin function _ZNK5Halib5Veci2dvEi
	.p2align	2
	.type	_ZNK5Halib5Veci2dvEi,@function
_ZNK5Halib5Veci2dvEi:                   # @_ZNK5Halib5Veci2dvEi
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -20(s0)
	sw	a1, -24(s0)
	lw	a0, -20(s0)
	lw	a1, 0(a0)
	lw	a2, -24(s0)
	div	a1, a1, a2
	lw	a0, 4(a0)
	div	a2, a0, a2
	addi	a0, s0, -16
	call	_ZN5Halib5Veci2C1Eii
	lw	a0, -16(s0)
	lw	a1, -12(s0)
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	_ZNK5Halib5Veci2dvEi, .Lfunc_end8-_ZNK5Halib5Veci2dvEi
	.cfi_endproc
                                        # -- End function
	.globl	_ZNK5Halib5Veci2eqERKS0_        # -- Begin function _ZNK5Halib5Veci2eqERKS0_
	.p2align	2
	.type	_ZNK5Halib5Veci2eqERKS0_,@function
_ZNK5Halib5Veci2eqERKS0_:               # @_ZNK5Halib5Veci2eqERKS0_
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -12(s0)
	sw	a0, -24(s0)                     # 4-byte Folded Spill
	lw	a0, 0(a0)
	lw	a1, -16(s0)
	lw	a1, 0(a1)
	li	a2, 0
	sw	a2, -20(s0)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB9_2
	j	.LBB9_1
.LBB9_1:
	lw	a0, -24(s0)                     # 4-byte Folded Reload
	lw	a0, 4(a0)
	lw	a1, -16(s0)
	lw	a1, 4(a1)
	xor	a0, a0, a1
	seqz	a0, a0
	sw	a0, -20(s0)                     # 4-byte Folded Spill
	j	.LBB9_2
.LBB9_2:
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	andi	a0, a0, 1
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end9:
	.size	_ZNK5Halib5Veci2eqERKS0_, .Lfunc_end9-_ZNK5Halib5Veci2eqERKS0_
                                        # -- End function
	.globl	_ZN5Halib5Veci2pLERKS0_         # -- Begin function _ZN5Halib5Veci2pLERKS0_
	.p2align	2
	.type	_ZN5Halib5Veci2pLERKS0_,@function
_ZN5Halib5Veci2pLERKS0_:                # @_ZN5Halib5Veci2pLERKS0_
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	lw	a2, 0(a1)
	lw	a1, 0(a0)
	add	a1, a1, a2
	sw	a1, 0(a0)
	lw	a1, -16(s0)
	lw	a2, 4(a1)
	lw	a1, 4(a0)
	add	a1, a1, a2
	sw	a1, 4(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end10:
	.size	_ZN5Halib5Veci2pLERKS0_, .Lfunc_end10-_ZN5Halib5Veci2pLERKS0_
                                        # -- End function
	.globl	_ZN5Halib5Veci2mIERKS0_         # -- Begin function _ZN5Halib5Veci2mIERKS0_
	.p2align	2
	.type	_ZN5Halib5Veci2mIERKS0_,@function
_ZN5Halib5Veci2mIERKS0_:                # @_ZN5Halib5Veci2mIERKS0_
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	lw	a2, 0(a1)
	lw	a1, 0(a0)
	sub	a1, a1, a2
	sw	a1, 0(a0)
	lw	a1, -16(s0)
	lw	a2, 4(a1)
	lw	a1, 4(a0)
	sub	a1, a1, a2
	sw	a1, 4(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end11:
	.size	_ZN5Halib5Veci2mIERKS0_, .Lfunc_end11-_ZN5Halib5Veci2mIERKS0_
                                        # -- End function
	.globl	_ZN5Halib5Veci2mLEi             # -- Begin function _ZN5Halib5Veci2mLEi
	.p2align	2
	.type	_ZN5Halib5Veci2mLEi,@function
_ZN5Halib5Veci2mLEi:                    # @_ZN5Halib5Veci2mLEi
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -12(s0)
	lw	a2, -16(s0)
	lw	a1, 0(a0)
	mul	a1, a1, a2
	sw	a1, 0(a0)
	lw	a2, -16(s0)
	lw	a1, 4(a0)
	mul	a1, a1, a2
	sw	a1, 4(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end12:
	.size	_ZN5Halib5Veci2mLEi, .Lfunc_end12-_ZN5Halib5Veci2mLEi
                                        # -- End function
	.globl	_ZN5Halib5Veci2dVEi             # -- Begin function _ZN5Halib5Veci2dVEi
	.p2align	2
	.type	_ZN5Halib5Veci2dVEi,@function
_ZN5Halib5Veci2dVEi:                    # @_ZN5Halib5Veci2dVEi
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -12(s0)
	lw	a2, -16(s0)
	lw	a1, 0(a0)
	div	a1, a1, a2
	sw	a1, 0(a0)
	lw	a2, -16(s0)
	lw	a1, 4(a0)
	div	a1, a1, a2
	sw	a1, 4(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end13:
	.size	_ZN5Halib5Veci2dVEi, .Lfunc_end13-_ZN5Halib5Veci2dVEi
                                        # -- End function
	.globl	_ZN5Halib5Veci2C1Eii
	.type	_ZN5Halib5Veci2C1Eii,@function
.set _ZN5Halib5Veci2C1Eii, _ZN5Halib5Veci2C2Eii
	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
