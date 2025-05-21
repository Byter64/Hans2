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
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	mv	s0, a3
	mv	s1, a2
	mv	s2, a1
	mv	s3, a0
	li	a0, -1
	sw	a0, 0(s3)
	mv	a0, a1
	mv	a1, a2
	mv	a2, a3
	call	_ZN4Hapi9LoadImageEPcii
	sw	a0, 0(s3)
	sw	s1, 4(s3)
	sw	s0, 8(s3)
	sw	s2, 12(s3)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
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
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	mv	s0, a3
	mv	s1, a2
	mv	s2, a1
	mv	s3, a0
	mv	a0, a1
	mv	a1, a2
	mv	a2, a3
	call	_ZN4Hapi9LoadImageEPcii
	sw	a0, 0(s3)
	sw	s1, 4(s3)
	sw	s0, 8(s3)
	sw	s2, 12(s3)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
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
	mv	a4, a2
	lw	a2, 0(a0)
	lw	a5, 4(a0)
	lw	a6, 8(a0)
	mv	a3, a1
	mv	a0, a2
	li	a1, 0
	li	a2, 0
	mv	a7, a5
	tail	_ZN4Hapi4DrawEjiiiiiii
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
	mv	t0, a2
	lw	a2, 0(a0)
	lw	a7, 4(a0)
	mv	t1, a1
	mv	a0, a2
	mv	a1, a3
	mv	a2, a4
	mv	a3, t1
	mv	a4, t0
	tail	_ZN4Hapi4DrawEjiiiiiii
.Lfunc_end3:
	.size	_ZNK5Halib5Image4DrawENS_5Veci2ES1_S1_, .Lfunc_end3-_ZNK5Halib5Image4DrawENS_5Veci2ES1_S1_
	.cfi_endproc
                                        # -- End function
	.globl	_ZNK5Halib5Image8GetImageEv     # -- Begin function _ZNK5Halib5Image8GetImageEv
	.p2align	2
	.type	_ZNK5Halib5Image8GetImageEv,@function
_ZNK5Halib5Image8GetImageEv:            # @_ZNK5Halib5Image8GetImageEv
# %bb.0:
	lw	a0, 0(a0)
	ret
.Lfunc_end4:
	.size	_ZNK5Halib5Image8GetImageEv, .Lfunc_end4-_ZNK5Halib5Image8GetImageEv
                                        # -- End function
	.globl	_ZNK5Halib5Image12GetImageSizeEv # -- Begin function _ZNK5Halib5Image12GetImageSizeEv
	.p2align	2
	.type	_ZNK5Halib5Image12GetImageSizeEv,@function
_ZNK5Halib5Image12GetImageSizeEv:       # @_ZNK5Halib5Image12GetImageSizeEv
# %bb.0:
	lw	a2, 4(a0)
	lw	a1, 8(a0)
	mv	a0, a2
	ret
.Lfunc_end5:
	.size	_ZNK5Halib5Image12GetImageSizeEv, .Lfunc_end5-_ZNK5Halib5Image12GetImageSizeEv
                                        # -- End function
	.globl	_ZN5Halib5Image10GetRawDataEv   # -- Begin function _ZN5Halib5Image10GetRawDataEv
	.p2align	2
	.type	_ZN5Halib5Image10GetRawDataEv,@function
_ZN5Halib5Image10GetRawDataEv:          # @_ZN5Halib5Image10GetRawDataEv
# %bb.0:
	lw	a0, 12(a0)
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
