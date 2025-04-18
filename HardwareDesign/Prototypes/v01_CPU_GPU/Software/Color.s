	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"Color.cpp"
	.text
	.globl	_ZN4Hapi5ColorC2Ehhhb           # -- Begin function _ZN4Hapi5ColorC2Ehhhb
	.p2align	2
	.type	_ZN4Hapi5ColorC2Ehhhb,@function
_ZN4Hapi5ColorC2Ehhhb:                  # @_ZN4Hapi5ColorC2Ehhhb
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
                                        # kill: def $x15 killed $x14
                                        # kill: def $x15 killed $x13
                                        # kill: def $x15 killed $x12
                                        # kill: def $x15 killed $x11
	sw	a0, -12(s0)
	sb	a1, -13(s0)
	sb	a2, -14(s0)
	sb	a3, -15(s0)
	sb	a4, -16(s0)
	lw	a0, -12(s0)
	lbu	a1, -13(s0)
	lbu	a2, -14(s0)
	lbu	a3, -15(s0)
	lbu	a4, -16(s0)
	andi	a4, a4, 1
	call	_ZN4Hapi5Color8SetColorEhhhb
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	_ZN4Hapi5ColorC2Ehhhb, .Lfunc_end0-_ZN4Hapi5ColorC2Ehhhb
	.cfi_endproc
                                        # -- End function
	.globl	_ZN4Hapi5Color8SetColorEhhhb    # -- Begin function _ZN4Hapi5Color8SetColorEhhhb
	.p2align	2
	.type	_ZN4Hapi5Color8SetColorEhhhb,@function
_ZN4Hapi5Color8SetColorEhhhb:           # @_ZN4Hapi5Color8SetColorEhhhb
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
                                        # kill: def $x15 killed $x14
                                        # kill: def $x15 killed $x13
                                        # kill: def $x15 killed $x12
                                        # kill: def $x15 killed $x11
	sw	a0, -12(s0)
	sb	a1, -13(s0)
	sb	a2, -14(s0)
	sb	a3, -15(s0)
	sb	a4, -16(s0)
	lw	a0, -12(s0)
	sw	a0, -20(s0)                     # 4-byte Folded Spill
	lbu	a1, -13(s0)
	call	_ZN4Hapi5Color6SetRedEh
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	lbu	a1, -14(s0)
	call	_ZN4Hapi5Color8SetGreenEh
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	lbu	a1, -15(s0)
	call	_ZN4Hapi5Color7SetBlueEh
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	lbu	a1, -16(s0)
	andi	a1, a1, 1
	call	_ZN4Hapi5Color8SetAlphaEb
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	_ZN4Hapi5Color8SetColorEhhhb, .Lfunc_end1-_ZN4Hapi5Color8SetColorEhhhb
                                        # -- End function
	.globl	_ZN4Hapi5Color6SetRedEh         # -- Begin function _ZN4Hapi5Color6SetRedEh
	.p2align	2
	.type	_ZN4Hapi5Color6SetRedEh,@function
_ZN4Hapi5Color6SetRedEh:                # @_ZN4Hapi5Color6SetRedEh
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
                                        # kill: def $x12 killed $x11
	sw	a0, -12(s0)
	sb	a1, -13(s0)
	lw	a1, -12(s0)
	lbu	a0, -13(s0)
	sb	a0, 2(a1)
	lhu	a0, 0(a1)
	andi	a0, a0, 2047
	lbu	a2, -13(s0)
	srli	a2, a2, 3
	slli	a2, a2, 11
	or	a0, a0, a2
	sh	a0, 0(a1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	_ZN4Hapi5Color6SetRedEh, .Lfunc_end2-_ZN4Hapi5Color6SetRedEh
                                        # -- End function
	.globl	_ZN4Hapi5Color8SetGreenEh       # -- Begin function _ZN4Hapi5Color8SetGreenEh
	.p2align	2
	.type	_ZN4Hapi5Color8SetGreenEh,@function
_ZN4Hapi5Color8SetGreenEh:              # @_ZN4Hapi5Color8SetGreenEh
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
                                        # kill: def $x12 killed $x11
	sw	a0, -12(s0)
	sb	a1, -13(s0)
	lw	a1, -12(s0)
	lbu	a0, -13(s0)
	sb	a0, 3(a1)
	lhu	a0, 0(a1)
	andi	a0, a0, -1985
	lbu	a2, -13(s0)
	slli	a2, a2, 3
	andi	a2, a2, 1984
	or	a0, a0, a2
	sh	a0, 0(a1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end3:
	.size	_ZN4Hapi5Color8SetGreenEh, .Lfunc_end3-_ZN4Hapi5Color8SetGreenEh
                                        # -- End function
	.globl	_ZN4Hapi5Color7SetBlueEh        # -- Begin function _ZN4Hapi5Color7SetBlueEh
	.p2align	2
	.type	_ZN4Hapi5Color7SetBlueEh,@function
_ZN4Hapi5Color7SetBlueEh:               # @_ZN4Hapi5Color7SetBlueEh
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
                                        # kill: def $x12 killed $x11
	sw	a0, -12(s0)
	sb	a1, -13(s0)
	lw	a1, -12(s0)
	lbu	a0, -13(s0)
	sb	a0, 4(a1)
	lhu	a0, 0(a1)
	andi	a0, a0, -63
	lbu	a2, -13(s0)
	srli	a2, a2, 2
	andi	a2, a2, 62
	or	a0, a0, a2
	sh	a0, 0(a1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end4:
	.size	_ZN4Hapi5Color7SetBlueEh, .Lfunc_end4-_ZN4Hapi5Color7SetBlueEh
                                        # -- End function
	.globl	_ZN4Hapi5Color8SetAlphaEb       # -- Begin function _ZN4Hapi5Color8SetAlphaEb
	.p2align	2
	.type	_ZN4Hapi5Color8SetAlphaEb,@function
_ZN4Hapi5Color8SetAlphaEb:              # @_ZN4Hapi5Color8SetAlphaEb
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
                                        # kill: def $x12 killed $x11
	sw	a0, -12(s0)
	sb	a1, -13(s0)
	lw	a1, -12(s0)
	lbu	a0, -13(s0)
	andi	a0, a0, 1
	sb	a0, 5(a1)
	lhu	a0, 0(a1)
	andi	a0, a0, -2
	lbu	a2, -13(s0)
	andi	a2, a2, 1
	or	a0, a0, a2
	sh	a0, 0(a1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end5:
	.size	_ZN4Hapi5Color8SetAlphaEb, .Lfunc_end5-_ZN4Hapi5Color8SetAlphaEb
                                        # -- End function
	.globl	_ZN4Hapi5Color8SetColorEhhh     # -- Begin function _ZN4Hapi5Color8SetColorEhhh
	.p2align	2
	.type	_ZN4Hapi5Color8SetColorEhhh,@function
_ZN4Hapi5Color8SetColorEhhh:            # @_ZN4Hapi5Color8SetColorEhhh
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
                                        # kill: def $x14 killed $x13
                                        # kill: def $x14 killed $x12
                                        # kill: def $x14 killed $x11
	sw	a0, -12(s0)
	sb	a1, -13(s0)
	sb	a2, -14(s0)
	sb	a3, -15(s0)
	lw	a0, -12(s0)
	sw	a0, -20(s0)                     # 4-byte Folded Spill
	lbu	a1, -13(s0)
	call	_ZN4Hapi5Color6SetRedEh
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	lbu	a1, -14(s0)
	call	_ZN4Hapi5Color8SetGreenEh
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	lbu	a1, -15(s0)
	call	_ZN4Hapi5Color7SetBlueEh
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end6:
	.size	_ZN4Hapi5Color8SetColorEhhh, .Lfunc_end6-_ZN4Hapi5Color8SetColorEhhh
                                        # -- End function
	.globl	_ZN4Hapi5Color10SetColor16Et    # -- Begin function _ZN4Hapi5Color10SetColor16Et
	.p2align	2
	.type	_ZN4Hapi5Color10SetColor16Et,@function
_ZN4Hapi5Color10SetColor16Et:           # @_ZN4Hapi5Color10SetColor16Et
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
                                        # kill: def $x12 killed $x11
	sw	a0, -12(s0)
	sh	a1, -14(s0)
	lw	a1, -12(s0)
	lh	a0, -14(s0)
	sh	a0, 0(a1)
	lbu	a0, -13(s0)
	andi	a0, a0, 248
	sb	a0, 2(a1)
	lhu	a0, -14(s0)
	srli	a0, a0, 3
	andi	a0, a0, 248
	sb	a0, 3(a1)
	lhu	a0, -14(s0)
	slli	a0, a0, 2
	andi	a0, a0, 248
	sb	a0, 4(a1)
	lbu	a0, -14(s0)
	andi	a0, a0, 1
	sb	a0, 5(a1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end7:
	.size	_ZN4Hapi5Color10SetColor16Et, .Lfunc_end7-_ZN4Hapi5Color10SetColor16Et
                                        # -- End function
	.globl	_ZN4Hapi5Color6GetRedEv         # -- Begin function _ZN4Hapi5Color6GetRedEv
	.p2align	2
	.type	_ZN4Hapi5Color6GetRedEv,@function
_ZN4Hapi5Color6GetRedEv:                # @_ZN4Hapi5Color6GetRedEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	lbu	a0, 2(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end8:
	.size	_ZN4Hapi5Color6GetRedEv, .Lfunc_end8-_ZN4Hapi5Color6GetRedEv
                                        # -- End function
	.globl	_ZN4Hapi5Color8GetGreenEv       # -- Begin function _ZN4Hapi5Color8GetGreenEv
	.p2align	2
	.type	_ZN4Hapi5Color8GetGreenEv,@function
_ZN4Hapi5Color8GetGreenEv:              # @_ZN4Hapi5Color8GetGreenEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	lbu	a0, 3(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end9:
	.size	_ZN4Hapi5Color8GetGreenEv, .Lfunc_end9-_ZN4Hapi5Color8GetGreenEv
                                        # -- End function
	.globl	_ZN4Hapi5Color7GetBlueEv        # -- Begin function _ZN4Hapi5Color7GetBlueEv
	.p2align	2
	.type	_ZN4Hapi5Color7GetBlueEv,@function
_ZN4Hapi5Color7GetBlueEv:               # @_ZN4Hapi5Color7GetBlueEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	lbu	a0, 4(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end10:
	.size	_ZN4Hapi5Color7GetBlueEv, .Lfunc_end10-_ZN4Hapi5Color7GetBlueEv
                                        # -- End function
	.globl	_ZN4Hapi5Color8GetAlphaEv       # -- Begin function _ZN4Hapi5Color8GetAlphaEv
	.p2align	2
	.type	_ZN4Hapi5Color8GetAlphaEv,@function
_ZN4Hapi5Color8GetAlphaEv:              # @_ZN4Hapi5Color8GetAlphaEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	lbu	a0, 5(a0)
	andi	a0, a0, 1
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end11:
	.size	_ZN4Hapi5Color8GetAlphaEv, .Lfunc_end11-_ZN4Hapi5Color8GetAlphaEv
                                        # -- End function
	.globl	_ZN4Hapi5Color8GetColorEv       # -- Begin function _ZN4Hapi5Color8GetColorEv
	.p2align	2
	.type	_ZN4Hapi5Color8GetColorEv,@function
_ZN4Hapi5Color8GetColorEv:              # @_ZN4Hapi5Color8GetColorEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	lhu	a0, 0(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end12:
	.size	_ZN4Hapi5Color8GetColorEv, .Lfunc_end12-_ZN4Hapi5Color8GetColorEv
                                        # -- End function
	.globl	_ZN4Hapi5ColorC1Ehhhb
	.type	_ZN4Hapi5ColorC1Ehhhb,@function
.set _ZN4Hapi5ColorC1Ehhhb, _ZN4Hapi5ColorC2Ehhhb
	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _ZN4Hapi5Color8SetColorEhhhb
	.addrsig_sym _ZN4Hapi5Color6SetRedEh
	.addrsig_sym _ZN4Hapi5Color8SetGreenEh
	.addrsig_sym _ZN4Hapi5Color7SetBlueEh
	.addrsig_sym _ZN4Hapi5Color8SetAlphaEb
