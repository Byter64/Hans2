	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"DebugHelper.cpp"
	.text
	.globl	WaitFrame                       # -- Begin function WaitFrame
	.p2align	2
	.type	WaitFrame,@function
WaitFrame:                              # @WaitFrame
# %bb.0:
	blez	a0, .LBB0_7
# %bb.1:
	lui	a1, %hi(GPU_VSYNC)
	lw	a1, %lo(GPU_VSYNC)(a1)
	li	a2, 0
.LBB0_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
                                        #     Child Loop BB0_4 Depth 2
                                        #     Child Loop BB0_5 Depth 2
	lw	a3, 0(a1)
	beqz	a3, .LBB0_2
.LBB0_3:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a3, 0(a1)
	bnez	a3, .LBB0_3
.LBB0_4:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a3, 0(a1)
	beqz	a3, .LBB0_4
.LBB0_5:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a3, 0(a1)
	bnez	a3, .LBB0_5
# %bb.6:                                #   in Loop: Header=BB0_2 Depth=1
	addi	a2, a2, 1
	bne	a2, a0, .LBB0_2
.LBB0_7:
	ret
.Lfunc_end0:
	.size	WaitFrame, .Lfunc_end0-WaitFrame
                                        # -- End function
	.globl	SetLoadingBar                   # -- Begin function SetLoadingBar
	.p2align	2
	.type	SetLoadingBar,@function
SetLoadingBar:                          # @SetLoadingBar
	.cfi_startproc
# %bb.0:
	bltz	a0, .LBB1_8
# %bb.1:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	mv	s0, a0
	lui	s3, %hi(_ZZ13SetLoadingBarE6loaded)
	lw	s4, %lo(_ZZ13SetLoadingBarE6loaded)(s3)
	slli	s2, a0, 1
	add	s2, s2, a0
	blt	a0, s4, .LBB1_4
# %bb.2:
	slli	a0, s4, 1
	add	s4, a0, s4
	lui	s1, %hi(_ZL19mainColourRectangle)
	addi	s1, s1, %lo(_ZL19mainColourRectangle)
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
	addi	a3, s4, 49
	li	a4, 197
	li	a5, 8
	li	a6, 4
	li	a7, 8
	mv	a0, s1
	li	a1, 0
	li	a2, 0
	call	_ZN4Hapi4DrawEjiiiiiii
	addi	s4, s4, 8
	bge	s2, s4, .LBB1_3
.LBB1_4:
	call	_ZN4Hapi10EndDrawingEv
	lw	s3, %lo(_ZZ13SetLoadingBarE6loaded)(s3)
	blt	s0, s3, .LBB1_7
# %bb.5:
	slli	a0, s3, 1
	add	s3, a0, s3
	lui	s1, %hi(_ZL19mainColourRectangle)
	addi	s1, s1, %lo(_ZL19mainColourRectangle)
.LBB1_6:                                # =>This Inner Loop Header: Depth=1
	addi	a3, s3, 49
	li	a4, 197
	li	a5, 8
	li	a6, 4
	li	a7, 8
	mv	a0, s1
	li	a1, 0
	li	a2, 0
	call	_ZN4Hapi4DrawEjiiiiiii
	addi	s3, s3, 8
	bge	s2, s3, .LBB1_6
.LBB1_7:
	call	_ZN4Hapi10EndDrawingEv
	lui	a0, %hi(_ZZ13SetLoadingBarE6loaded)
	sw	s0, %lo(_ZZ13SetLoadingBarE6loaded)(a0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
.LBB1_8:
	ret
.Lfunc_end1:
	.size	SetLoadingBar, .Lfunc_end1-SetLoadingBar
	.cfi_endproc
                                        # -- End function
	.globl	SetStatus                       # -- Begin function SetStatus
	.p2align	2
	.type	SetStatus,@function
SetStatus:                              # @SetStatus
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	sw	s1, 4(sp)                       # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	mv	s0, a2
	mv	s1, a1
	call	ScreenPrintStatus
	mv	a0, s1
	call	SetLoadingBar
	mv	a0, s0
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	tail	WaitFrame
.Lfunc_end2:
	.size	SetStatus, .Lfunc_end2-SetStatus
	.cfi_endproc
                                        # -- End function
	.globl	ScreenPrintStatus               # -- Begin function ScreenPrintStatus
	.p2align	2
	.type	ScreenPrintStatus,@function
ScreenPrintStatus:                      # @ScreenPrintStatus
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
	mv	s0, a0
	li	s2, -8
	lui	s1, %hi(_ZL25backgroundColourRectangle)
	addi	s1, s1, %lo(_ZL25backgroundColourRectangle)
	li	s3, 285
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
	addi	a3, s2, 57
	li	a4, 190
	li	a5, 8
	li	a6, 5
	li	a7, 8
	mv	a0, s1
	li	a1, 0
	li	a2, 0
	call	_ZN4Hapi4DrawEjiiiiiii
	addi	s2, s2, 8
	bltu	s2, s3, .LBB3_1
# %bb.2:
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	li	a1, 49
	li	a2, 190
	li	a3, 100
	call	_ZN4Hapi8DrawTextEPKciij
	lui	a0, 244
	li	a1, 53
	addi	a3, a0, 576
	li	a2, 190
	mv	a0, s0
	call	_ZN4Hapi8DrawTextEPKciij
	call	_ZN4Hapi10EndDrawingEv
	li	s2, -8
	lui	s1, %hi(_ZL25backgroundColourRectangle)
	addi	s1, s1, %lo(_ZL25backgroundColourRectangle)
	li	s3, 285
.LBB3_3:                                # =>This Inner Loop Header: Depth=1
	addi	a3, s2, 57
	li	a4, 190
	li	a5, 8
	li	a6, 5
	li	a7, 8
	mv	a0, s1
	li	a1, 0
	li	a2, 0
	call	_ZN4Hapi4DrawEjiiiiiii
	addi	s2, s2, 8
	bltu	s2, s3, .LBB3_3
# %bb.4:
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	li	a1, 49
	li	a2, 190
	li	a3, 100
	call	_ZN4Hapi8DrawTextEPKciij
	lui	a0, 244
	li	a1, 53
	addi	a3, a0, 576
	li	a2, 190
	mv	a0, s0
	call	_ZN4Hapi8DrawTextEPKciij
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
	tail	_ZN4Hapi10EndDrawingEv
.Lfunc_end3:
	.size	ScreenPrintStatus, .Lfunc_end3-ScreenPrintStatus
	.cfi_endproc
                                        # -- End function
	.globl	ScreenPrintWord                 # -- Begin function ScreenPrintWord
	.p2align	2
	.type	ScreenPrintWord,@function
ScreenPrintWord:                        # @ScreenPrintWord
	.cfi_startproc
# %bb.0:
	slli	a2, a0, 4
	srli	a2, a2, 28
	li	a1, 10
	bltu	a2, a1, .LBB4_2
# %bb.1:
	addi	a3, a2, 55
	j	.LBB4_3
.LBB4_2:
	addi	a3, a2, 48
.LBB4_3:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	srli	a2, a0, 16
	sb	a3, 4(sp)
	srli	a4, a0, 29
	li	a5, 5
	srli	a3, a0, 28
	bltu	a4, a5, .LBB4_5
# %bb.4:
	addi	a4, a3, 55
	j	.LBB4_6
.LBB4_5:
	addi	a4, a3, 48
.LBB4_6:
	zext.b	a3, a2
	andi	a2, a2, 15
	sb	a4, 3(sp)
	bltu	a2, a1, .LBB4_8
# %bb.7:
	addi	a2, a2, 55
	j	.LBB4_9
.LBB4_8:
	addi	a2, a2, 48
.LBB4_9:
	srli	a4, a0, 8
	sb	a2, 6(sp)
	li	a2, 160
	srli	a5, a3, 4
	bltu	a3, a2, .LBB4_11
# %bb.10:
	addi	a5, a5, 55
	j	.LBB4_12
.LBB4_11:
	addi	a5, a5, 48
.LBB4_12:
	zext.b	a3, a4
	andi	a4, a4, 15
	sb	a5, 5(sp)
	bltu	a4, a1, .LBB4_14
# %bb.13:
	addi	a4, a4, 55
	j	.LBB4_15
.LBB4_14:
	addi	a4, a4, 48
.LBB4_15:
	sb	a4, 8(sp)
	srli	a4, a3, 4
	bltu	a3, a2, .LBB4_17
# %bb.16:
	addi	a4, a4, 55
	j	.LBB4_18
.LBB4_17:
	addi	a4, a4, 48
.LBB4_18:
	zext.b	a3, a0
	andi	a0, a0, 15
	sb	a4, 7(sp)
	bltu	a0, a1, .LBB4_20
# %bb.19:
	addi	a0, a0, 55
	j	.LBB4_21
.LBB4_20:
	addi	a0, a0, 48
.LBB4_21:
	sb	a0, 10(sp)
	srli	a0, a3, 4
	bltu	a3, a2, .LBB4_23
# %bb.22:
	addi	a0, a0, 55
	j	.LBB4_24
.LBB4_23:
	addi	a0, a0, 48
.LBB4_24:
	sb	a0, 9(sp)
	sb	zero, 11(sp)
	addi	a0, sp, 3
	call	ScreenPrint
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	ScreenPrintWord, .Lfunc_end4-ScreenPrintWord
	.cfi_endproc
                                        # -- End function
	.globl	ByteToHex                       # -- Begin function ByteToHex
	.p2align	2
	.type	ByteToHex,@function
ByteToHex:                              # @ByteToHex
# %bb.0:
	mv	a2, a0
	andi	a3, a0, 15
	li	a4, 10
	mv	a0, a1
	bltu	a3, a4, .LBB5_2
# %bb.1:
	addi	a1, a3, 55
	j	.LBB5_3
.LBB5_2:
	addi	a1, a3, 48
.LBB5_3:
	sb	a1, 1(a0)
	li	a3, 160
	srli	a1, a2, 4
	bltu	a2, a3, .LBB5_5
# %bb.4:
	addi	a1, a1, 55
	j	.LBB5_6
.LBB5_5:
	addi	a1, a1, 48
.LBB5_6:
	sb	a1, 0(a0)
	sb	zero, 2(a0)
	ret
.Lfunc_end5:
	.size	ByteToHex, .Lfunc_end5-ByteToHex
                                        # -- End function
	.globl	ScreenPrint                     # -- Begin function ScreenPrint
	.p2align	2
	.type	ScreenPrint,@function
ScreenPrint:                            # @ScreenPrint
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	mv	s0, a0
	lui	s3, %hi(.L_MergedGlobals)
	addi	s4, s3, %lo(.L_MergedGlobals)
	lw	a1, %lo(.L_MergedGlobals)(s3)
	lw	a2, 4(s4)
	addi	a1, a1, -4
	lui	s1, %hi(.L.str)
	addi	s1, s1, %lo(.L.str)
	li	a3, 100
	mv	a0, s1
	call	_ZN4Hapi8DrawTextEPKciij
	lw	a1, %lo(.L_MergedGlobals)(s3)
	lw	a2, 4(s4)
	lui	a0, 244
	addi	s2, a0, 576
	mv	a0, s0
	mv	a3, s2
	call	_ZN4Hapi8DrawTextEPKciij
	call	_ZN4Hapi10EndDrawingEv
	lw	a1, %lo(.L_MergedGlobals)(s3)
	lw	a2, 4(s4)
	addi	a1, a1, -4
	li	a3, 100
	mv	a0, s1
	call	_ZN4Hapi8DrawTextEPKciij
	lw	a1, %lo(.L_MergedGlobals)(s3)
	lw	a2, 4(s4)
	mv	a0, s0
	mv	a3, s2
	call	_ZN4Hapi8DrawTextEPKciij
	call	_ZN4Hapi10EndDrawingEv
	lw	a0, 4(s4)
	addi	a1, a0, 6
	li	a2, 184
	sw	a1, 4(s4)
	blt	a0, a2, .LBB6_2
# %bb.1:
	lw	a0, %lo(.L_MergedGlobals)(s3)
	li	a1, 5
	sw	a1, 4(s4)
	addi	a0, a0, 70
	sw	a0, %lo(.L_MergedGlobals)(s3)
.LBB6_2:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	ScreenPrint, .Lfunc_end6-ScreenPrint
	.cfi_endproc
                                        # -- End function
	.globl	ScreenPrintHWord                # -- Begin function ScreenPrintHWord
	.p2align	2
	.type	ScreenPrintHWord,@function
ScreenPrintHWord:                       # @ScreenPrintHWord
	.cfi_startproc
# %bb.0:
	srli	a3, a0, 8
	andi	a2, a3, 15
	li	a1, 10
	bltu	a2, a1, .LBB7_2
# %bb.1:
	addi	a2, a2, 55
	j	.LBB7_3
.LBB7_2:
	addi	a2, a2, 48
.LBB7_3:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	sb	a2, 8(sp)
	li	a2, 160
	srli	a4, a0, 12
	bltu	a3, a2, .LBB7_5
# %bb.4:
	addi	a4, a4, 55
	j	.LBB7_6
.LBB7_5:
	addi	a4, a4, 48
.LBB7_6:
	zext.b	a3, a0
	andi	a0, a0, 15
	sb	a4, 7(sp)
	bltu	a0, a1, .LBB7_8
# %bb.7:
	addi	a0, a0, 55
	j	.LBB7_9
.LBB7_8:
	addi	a0, a0, 48
.LBB7_9:
	sb	a0, 10(sp)
	srli	a0, a3, 4
	bltu	a3, a2, .LBB7_11
# %bb.10:
	addi	a0, a0, 55
	j	.LBB7_12
.LBB7_11:
	addi	a0, a0, 48
.LBB7_12:
	sb	a0, 9(sp)
	sb	zero, 11(sp)
	addi	a0, sp, 7
	call	ScreenPrint
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	ScreenPrintHWord, .Lfunc_end7-ScreenPrintHWord
	.cfi_endproc
                                        # -- End function
	.globl	ScreenPrintByte                 # -- Begin function ScreenPrintByte
	.p2align	2
	.type	ScreenPrintByte,@function
ScreenPrintByte:                        # @ScreenPrintByte
	.cfi_startproc
# %bb.0:
	andi	a1, a0, 15
	li	a2, 10
	bltu	a1, a2, .LBB8_2
# %bb.1:
	addi	a1, a1, 55
	j	.LBB8_3
.LBB8_2:
	addi	a1, a1, 48
.LBB8_3:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	sb	a1, 10(sp)
	li	a2, 160
	srli	a1, a0, 4
	bltu	a0, a2, .LBB8_5
# %bb.4:
	addi	a0, a1, 55
	j	.LBB8_6
.LBB8_5:
	addi	a0, a1, 48
.LBB8_6:
	sb	a0, 9(sp)
	sb	zero, 11(sp)
	addi	a0, sp, 9
	call	ScreenPrint
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	ScreenPrintByte, .Lfunc_end8-ScreenPrintByte
	.cfi_endproc
                                        # -- End function
	.type	_ZZ13SetLoadingBarE6loaded,@object # @_ZZ13SetLoadingBarE6loaded
	.local	_ZZ13SetLoadingBarE6loaded
	.comm	_ZZ13SetLoadingBarE6loaded,4,4
	.type	_ZL19mainColourRectangle,@object # @_ZL19mainColourRectangle
	.section	.rodata,"a",@progbits
	.p2align	1, 0x0
_ZL19mainColourRectangle:
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.half	613                             # 0x265
	.size	_ZL19mainColourRectangle, 64

	.type	_ZL25backgroundColourRectangle,@object # @_ZL25backgroundColourRectangle
	.p2align	1, 0x0
_ZL25backgroundColourRectangle:
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.half	6343                            # 0x18c7
	.size	_ZL25backgroundColourRectangle, 80

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	">"
	.size	.L.str, 2

	.type	.L_MergedGlobals,@object        # @_MergedGlobals
	.data
	.p2align	2, 0x0
.L_MergedGlobals:
	.word	5                               # 0x5
	.word	5                               # 0x5
	.size	.L_MergedGlobals, 8

.set _ZZ11ScreenPrintE1x, .L_MergedGlobals
	.size	_ZZ11ScreenPrintE1x, 4
.set _ZZ11ScreenPrintE1y, .L_MergedGlobals+4
	.size	_ZZ11ScreenPrintE1y, 4
	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _ZL19mainColourRectangle
	.addrsig_sym _ZL25backgroundColourRectangle
	.addrsig_sym .L_MergedGlobals
