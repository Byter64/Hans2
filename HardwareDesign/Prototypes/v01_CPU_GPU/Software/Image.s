	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"Image.cpp"
	.text
	.globl	_ZN5Halib5ImageC2EPKtNS_5Veci2E # -- Begin function _ZN5Halib5ImageC2EPKtNS_5Veci2E
	.p2align	2
	.type	_ZN5Halib5ImageC2EPKtNS_5Veci2E,@function
_ZN5Halib5ImageC2EPKtNS_5Veci2E:        # @_ZN5Halib5ImageC2EPKtNS_5Veci2E
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
                                        # kill: def $x14 killed $x13
                                        # kill: def $x14 killed $x12
	sw	a3, -12(s0)
	sw	a2, -16(s0)
	sw	a0, -20(s0)
	sw	a1, -24(s0)
	lw	a0, -20(s0)
	li	a1, -1
	sw	a1, 0(a0)
	lw	a1, -24(s0)
	lw	a2, -12(s0)
	sw	a2, -28(s0)
	lw	a2, -16(s0)
	sw	a2, -32(s0)
	lw	a3, -28(s0)
	lw	a2, -32(s0)
	call	_ZN5Halib5Image8SetImageEPcNS_5Veci2E
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	_ZN5Halib5ImageC2EPKtNS_5Veci2E, .Lfunc_end0-_ZN5Halib5ImageC2EPKtNS_5Veci2E
	.cfi_endproc
                                        # -- End function
	.globl	_ZN5Halib5Image8SetImageEPcNS_5Veci2E # -- Begin function _ZN5Halib5Image8SetImageEPcNS_5Veci2E
	.p2align	2
	.type	_ZN5Halib5Image8SetImageEPcNS_5Veci2E,@function
_ZN5Halib5Image8SetImageEPcNS_5Veci2E:  # @_ZN5Halib5Image8SetImageEPcNS_5Veci2E
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
                                        # kill: def $x14 killed $x13
                                        # kill: def $x14 killed $x12
	sw	a3, -12(s0)
	sw	a2, -16(s0)
	sw	a0, -20(s0)
	sw	a1, -24(s0)
	lw	a0, -20(s0)
	sw	a0, -28(s0)                     # 4-byte Folded Spill
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	lw	a2, -12(s0)
	call	_ZN4Hapi9LoadImageEPcii
	lw	a1, -28(s0)                     # 4-byte Folded Reload
	sw	a0, 0(a1)
	lw	a0, -12(s0)
	sw	a0, 8(a1)
	lw	a0, -16(s0)
	sw	a0, 4(a1)
	lw	a0, -24(s0)
	sw	a0, 12(a1)
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	_ZN5Halib5Image8SetImageEPcNS_5Veci2E, .Lfunc_end1-_ZN5Halib5Image8SetImageEPcNS_5Veci2E
	.cfi_endproc
                                        # -- End function
	.globl	_ZNK5Halib5Image4DrawENS_5Veci2E # -- Begin function _ZNK5Halib5Image4DrawENS_5Veci2E
	.p2align	2
	.type	_ZNK5Halib5Image4DrawENS_5Veci2E,@function
_ZNK5Halib5Image4DrawENS_5Veci2E:       # @_ZNK5Halib5Image4DrawENS_5Veci2E
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
                                        # kill: def $x13 killed $x12
                                        # kill: def $x13 killed $x11
	sw	a2, -12(s0)
	sw	a1, -16(s0)
	sw	a0, -20(s0)
	lw	a1, -20(s0)
	lw	a0, 0(a1)
	lw	a3, -16(s0)
	lw	a4, -12(s0)
	lw	a7, 4(a1)
	lw	a6, 8(a1)
	li	a2, 0
	mv	a1, a2
	mv	a5, a7
	call	_ZN4Hapi4DrawEjiiiiiii
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	_ZNK5Halib5Image4DrawENS_5Veci2E, .Lfunc_end2-_ZNK5Halib5Image4DrawENS_5Veci2E
	.cfi_endproc
                                        # -- End function
	.globl	_ZNK5Halib5Image4DrawENS_5Veci2ES1_S1_ # -- Begin function _ZNK5Halib5Image4DrawENS_5Veci2ES1_S1_
	.p2align	2
	.type	_ZNK5Halib5Image4DrawENS_5Veci2ES1_S1_,@function
_ZNK5Halib5Image4DrawENS_5Veci2ES1_S1_: # @_ZNK5Halib5Image4DrawENS_5Veci2ES1_S1_
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 48
	.cfi_def_cfa s0, 0
                                        # kill: def $x17 killed $x16
                                        # kill: def $x17 killed $x15
                                        # kill: def $x17 killed $x14
                                        # kill: def $x17 killed $x13
                                        # kill: def $x17 killed $x12
                                        # kill: def $x17 killed $x11
	sw	a2, -12(s0)
	sw	a1, -16(s0)
	sw	a4, -20(s0)
	sw	a3, -24(s0)
	sw	a6, -28(s0)
	sw	a5, -32(s0)
	sw	a0, -36(s0)
	lw	a7, -36(s0)
	lw	a0, 0(a7)
	lw	a1, -24(s0)
	lw	a2, -20(s0)
	lw	a3, -16(s0)
	lw	a4, -12(s0)
	lw	a5, -32(s0)
	lw	a6, -28(s0)
	lw	a7, 4(a7)
	call	_ZN4Hapi4DrawEjiiiiiii
	.cfi_def_cfa sp, 48
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	_ZNK5Halib5Image4DrawENS_5Veci2ES1_S1_, .Lfunc_end3-_ZNK5Halib5Image4DrawENS_5Veci2ES1_S1_
	.cfi_endproc
                                        # -- End function
	.globl	_ZNK5Halib5Image8GetImageEv     # -- Begin function _ZNK5Halib5Image8GetImageEv
	.p2align	2
	.type	_ZNK5Halib5Image8GetImageEv,@function
_ZNK5Halib5Image8GetImageEv:            # @_ZNK5Halib5Image8GetImageEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	lw	a0, 0(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end4:
	.size	_ZNK5Halib5Image8GetImageEv, .Lfunc_end4-_ZNK5Halib5Image8GetImageEv
                                        # -- End function
	.globl	_ZNK5Halib5Image12GetImageSizeEv # -- Begin function _ZNK5Halib5Image12GetImageSizeEv
	.p2align	2
	.type	_ZNK5Halib5Image12GetImageSizeEv,@function
_ZNK5Halib5Image12GetImageSizeEv:       # @_ZNK5Halib5Image12GetImageSizeEv
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	lw	a1, 8(a0)
	sw	a1, -12(s0)
	lw	a0, 4(a0)
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	lw	a1, -12(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end5:
	.size	_ZNK5Halib5Image12GetImageSizeEv, .Lfunc_end5-_ZNK5Halib5Image12GetImageSizeEv
                                        # -- End function
	.globl	_ZN5Halib5Image10GetRawDataEv   # -- Begin function _ZN5Halib5Image10GetRawDataEv
	.p2align	2
	.type	_ZN5Halib5Image10GetRawDataEv,@function
_ZN5Halib5Image10GetRawDataEv:          # @_ZN5Halib5Image10GetRawDataEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	lw	a0, 12(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end6:
	.size	_ZN5Halib5Image10GetRawDataEv, .Lfunc_end6-_ZN5Halib5Image10GetRawDataEv
                                        # -- End function
	.globl	_ZN5Halib5ImageC1EPKtNS_5Veci2E
	.type	_ZN5Halib5ImageC1EPKtNS_5Veci2E,@function
.set _ZN5Halib5ImageC1EPKtNS_5Veci2E, _ZN5Halib5ImageC2EPKtNS_5Veci2E
	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _ZN5Halib5Image8SetImageEPcNS_5Veci2E
	.addrsig_sym _ZN4Hapi4DrawEjiiiiiii
	.addrsig_sym _ZN4Hapi9LoadImageEPcii
