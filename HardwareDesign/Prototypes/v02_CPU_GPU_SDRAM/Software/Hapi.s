	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"Hapi.cpp"
	.text
	.globl	_ZN4Hapi4InitEv                 # -- Begin function _ZN4Hapi4InitEv
	.p2align	2
	.type	_ZN4Hapi4InitEv,@function
_ZN4Hapi4InitEv:                        # @_ZN4Hapi4InitEv
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -560
	.cfi_def_cfa_offset 560
	sw	ra, 556(sp)                     # 4-byte Folded Spill
	sw	s0, 552(sp)                     # 4-byte Folded Spill
	sw	s1, 548(sp)                     # 4-byte Folded Spill
	sw	s2, 544(sp)                     # 4-byte Folded Spill
	sw	s3, 540(sp)                     # 4-byte Folded Spill
	sw	s4, 536(sp)                     # 4-byte Folded Spill
	sw	s5, 532(sp)                     # 4-byte Folded Spill
	sw	s6, 528(sp)                     # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	.cfi_offset s5, -28
	.cfi_offset s6, -32
	li	s1, 0
	li	s2, 0
	li	s3, 3
	li	s4, 5
	lui	s0, %hi(_ZL5atlas)
	addi	s0, s0, %lo(_ZL5atlas)
	li	s5, 26
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	sw	s1, 512(sp)
	sw	zero, 516(sp)
	sw	s3, 520(sp)
	sw	s4, 524(sp)
	addi	a0, s2, 65
	andi	a1, a0, 255
	addi	a2, sp, 512
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	addi	s2, s2, 1
	addi	s1, s1, 4
	bne	s2, s5, .LBB0_1
# %bb.2:
	li	a0, 104
	li	s1, 3
	li	s2, 5
	sw	a0, 496(sp)
	sw	zero, 500(sp)
	sw	s1, 504(sp)
	sw	s2, 508(sp)
	lui	s0, %hi(_ZL5atlas)
	addi	s0, s0, %lo(_ZL5atlas)
	li	a1, 91
	addi	a2, sp, 496
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 108
	sw	a0, 480(sp)
	sw	zero, 484(sp)
	sw	s1, 488(sp)
	sw	s2, 492(sp)
	li	a1, 93
	addi	a2, sp, 480
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 112
	sw	a0, 464(sp)
	sw	zero, 468(sp)
	sw	s1, 472(sp)
	sw	s2, 476(sp)
	li	a1, 123
	addi	a2, sp, 464
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 116
	sw	a0, 448(sp)
	sw	zero, 452(sp)
	sw	s1, 456(sp)
	sw	s2, 460(sp)
	li	a1, 125
	addi	a2, sp, 448
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	s3, 0
	li	s4, 0
	li	s5, 26
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	sw	s3, 432(sp)
	sw	s2, 436(sp)
	sw	s1, 440(sp)
	sw	s2, 444(sp)
	addi	a0, s4, 97
	andi	a1, a0, 255
	addi	a2, sp, 432
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	addi	s4, s4, 1
	addi	s3, s3, 4
	bne	s4, s5, .LBB0_3
# %bb.4:
	li	a0, 104
	li	s1, 5
	li	s2, 3
	sw	a0, 416(sp)
	sw	s1, 420(sp)
	sw	s2, 424(sp)
	sw	s1, 428(sp)
	lui	s0, %hi(_ZL5atlas)
	addi	s0, s0, %lo(_ZL5atlas)
	li	a1, 92
	addi	a2, sp, 416
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 108
	sw	a0, 400(sp)
	sw	s1, 404(sp)
	sw	s2, 408(sp)
	sw	s1, 412(sp)
	li	a1, 47
	addi	a2, sp, 400
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 112
	sw	a0, 384(sp)
	sw	s1, 388(sp)
	sw	s2, 392(sp)
	sw	s1, 396(sp)
	li	a1, 60
	addi	a2, sp, 384
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 116
	sw	a0, 368(sp)
	sw	s1, 372(sp)
	sw	s2, 376(sp)
	sw	s1, 380(sp)
	li	a1, 62
	addi	a2, sp, 368
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	s3, 0
	li	s4, 1
	li	s5, 10
	li	s6, 36
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	sw	s3, 352(sp)
	sw	s5, 356(sp)
	sw	s2, 360(sp)
	sw	s1, 364(sp)
	ori	a0, s4, 48
	andi	a1, a0, 255
	addi	a2, sp, 352
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	addi	s3, s3, 4
	addi	s4, s4, 1
	bne	s3, s6, .LBB0_5
# %bb.6:
	li	a0, 36
	li	s3, 10
	li	s1, 3
	li	s2, 5
	sw	a0, 336(sp)
	sw	s3, 340(sp)
	sw	s1, 344(sp)
	sw	s2, 348(sp)
	li	a1, 48
	addi	a2, sp, 336
	li	s4, 48
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 40
	sw	a0, 320(sp)
	sw	s3, 324(sp)
	sw	s1, 328(sp)
	sw	s2, 332(sp)
	li	a1, 33
	addi	a2, sp, 320
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 44
	sw	a0, 304(sp)
	sw	s3, 308(sp)
	sw	s1, 312(sp)
	sw	s2, 316(sp)
	li	a1, 34
	addi	a2, sp, 304
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	sw	s4, 288(sp)
	sw	s3, 292(sp)
	sw	s1, 296(sp)
	sw	s2, 300(sp)
	li	a1, 36
	addi	a2, sp, 288
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 52
	sw	a0, 272(sp)
	sw	s3, 276(sp)
	sw	s1, 280(sp)
	sw	s2, 284(sp)
	li	a1, 37
	addi	a2, sp, 272
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 56
	sw	a0, 256(sp)
	sw	s3, 260(sp)
	sw	s1, 264(sp)
	sw	s2, 268(sp)
	li	a1, 94
	addi	a2, sp, 256
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 60
	sw	a0, 240(sp)
	sw	s3, 244(sp)
	sw	s1, 248(sp)
	sw	s2, 252(sp)
	li	a1, 42
	addi	a2, sp, 240
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 64
	sw	a0, 224(sp)
	sw	s3, 228(sp)
	sw	s1, 232(sp)
	sw	s2, 236(sp)
	li	a1, 40
	addi	a2, sp, 224
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 68
	sw	a0, 208(sp)
	sw	s3, 212(sp)
	sw	s1, 216(sp)
	sw	s2, 220(sp)
	li	a1, 41
	addi	a2, sp, 208
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 72
	sw	a0, 192(sp)
	sw	s3, 196(sp)
	sw	s1, 200(sp)
	sw	s2, 204(sp)
	li	a1, 96
	addi	a2, sp, 192
	li	s4, 96
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 76
	sw	a0, 176(sp)
	sw	s3, 180(sp)
	sw	s1, 184(sp)
	sw	s2, 188(sp)
	li	a1, 39
	addi	a2, sp, 176
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 80
	sw	a0, 160(sp)
	sw	s3, 164(sp)
	sw	s1, 168(sp)
	sw	s2, 172(sp)
	li	a1, 45
	addi	a2, sp, 160
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 84
	sw	a0, 144(sp)
	sw	s3, 148(sp)
	sw	s1, 152(sp)
	sw	s2, 156(sp)
	li	a1, 61
	addi	a2, sp, 144
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 88
	sw	a0, 128(sp)
	sw	s3, 132(sp)
	sw	s1, 136(sp)
	sw	s2, 140(sp)
	li	a1, 95
	addi	a2, sp, 128
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 92
	sw	a0, 112(sp)
	sw	s3, 116(sp)
	sw	s1, 120(sp)
	sw	s2, 124(sp)
	li	a1, 43
	addi	a2, sp, 112
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	sw	s4, 96(sp)
	sw	s3, 100(sp)
	sw	s1, 104(sp)
	sw	s2, 108(sp)
	li	a1, 63
	addi	a2, sp, 96
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 100
	sw	a0, 80(sp)
	sw	s3, 84(sp)
	sw	s1, 88(sp)
	sw	s2, 92(sp)
	li	a1, 124
	addi	a2, sp, 80
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 104
	sw	a0, 64(sp)
	sw	s3, 68(sp)
	sw	s1, 72(sp)
	sw	s2, 76(sp)
	li	a1, 46
	addi	a2, sp, 64
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 108
	sw	a0, 48(sp)
	sw	s3, 52(sp)
	sw	s1, 56(sp)
	sw	s2, 60(sp)
	li	a1, 44
	addi	a2, sp, 48
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 112
	sw	a0, 32(sp)
	sw	s3, 36(sp)
	sw	s1, 40(sp)
	sw	s2, 44(sp)
	li	a1, 58
	addi	a2, sp, 32
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, 116
	sw	a0, 16(sp)
	sw	s3, 20(sp)
	sw	s1, 24(sp)
	sw	s2, 28(sp)
	li	a1, 59
	addi	a2, sp, 16
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	li	a0, -1
	sw	a0, 0(sp)
	sw	a0, 4(sp)
	sw	s1, 8(sp)
	sw	s2, 12(sp)
	li	a1, 32
	mv	a2, sp
	mv	a0, s0
	call	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	lui	a0, %hi(_ZN4Hapi11defaultFontE)
	lui	a1, %hi(_ZN6AssetsL11minifont5x3E)
	addi	a1, a1, %lo(_ZN6AssetsL11minifont5x3E)
	li	a2, 120
	sw	a1, %lo(_ZN4Hapi11defaultFontE)(a0)
	li	a1, 15
	addi	a0, a0, %lo(_ZN4Hapi11defaultFontE)
	sw	a2, 4(a0)
	sw	a1, 8(a0)
	sw	s0, 12(a0)
	li	a0, 0
	lw	ra, 556(sp)                     # 4-byte Folded Reload
	lw	s0, 552(sp)                     # 4-byte Folded Reload
	lw	s1, 548(sp)                     # 4-byte Folded Reload
	lw	s2, 544(sp)                     # 4-byte Folded Reload
	lw	s3, 540(sp)                     # 4-byte Folded Reload
	lw	s4, 536(sp)                     # 4-byte Folded Reload
	lw	s5, 532(sp)                     # 4-byte Folded Reload
	lw	s6, 528(sp)                     # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	.cfi_restore s5
	.cfi_restore s6
	addi	sp, sp, 560
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	_ZN4Hapi4InitEv, .Lfunc_end0-_ZN4Hapi4InitEv
	.cfi_endproc
                                        # -- End function
	.globl	_ZN4Hapi9TerminateEv            # -- Begin function _ZN4Hapi9TerminateEv
	.p2align	2
	.type	_ZN4Hapi9TerminateEv,@function
_ZN4Hapi9TerminateEv:                   # @_ZN4Hapi9TerminateEv
# %bb.0:
	li	a0, 0
	ret
.Lfunc_end1:
	.size	_ZN4Hapi9TerminateEv, .Lfunc_end1-_ZN4Hapi9TerminateEv
                                        # -- End function
	.globl	_ZN4Hapi11ShouldCloseEv         # -- Begin function _ZN4Hapi11ShouldCloseEv
	.p2align	2
	.type	_ZN4Hapi11ShouldCloseEv,@function
_ZN4Hapi11ShouldCloseEv:                # @_ZN4Hapi11ShouldCloseEv
# %bb.0:
	li	a0, 0
	ret
.Lfunc_end2:
	.size	_ZN4Hapi11ShouldCloseEv, .Lfunc_end2-_ZN4Hapi11ShouldCloseEv
                                        # -- End function
	.globl	_ZN4Hapi9LoadImageEPcii         # -- Begin function _ZN4Hapi9LoadImageEPcii
	.p2align	2
	.type	_ZN4Hapi9LoadImageEPcii,@function
_ZN4Hapi9LoadImageEPcii:                # @_ZN4Hapi9LoadImageEPcii
# %bb.0:
	ret
.Lfunc_end3:
	.size	_ZN4Hapi9LoadImageEPcii, .Lfunc_end3-_ZN4Hapi9LoadImageEPcii
                                        # -- End function
	.globl	_ZN4Hapi11UpdateImageEjPcii     # -- Begin function _ZN4Hapi11UpdateImageEjPcii
	.p2align	2
	.type	_ZN4Hapi11UpdateImageEjPcii,@function
_ZN4Hapi11UpdateImageEjPcii:            # @_ZN4Hapi11UpdateImageEjPcii
# %bb.0:
	ret
.Lfunc_end4:
	.size	_ZN4Hapi11UpdateImageEjPcii, .Lfunc_end4-_ZN4Hapi11UpdateImageEjPcii
                                        # -- End function
	.globl	_ZN4Hapi11UnloadImageEj         # -- Begin function _ZN4Hapi11UnloadImageEj
	.p2align	2
	.type	_ZN4Hapi11UnloadImageEj,@function
_ZN4Hapi11UnloadImageEj:                # @_ZN4Hapi11UnloadImageEj
# %bb.0:
	ret
.Lfunc_end5:
	.size	_ZN4Hapi11UnloadImageEj, .Lfunc_end5-_ZN4Hapi11UnloadImageEj
                                        # -- End function
	.globl	_ZN4Hapi8LoadFontEPciiPNS_9FontAtlasE # -- Begin function _ZN4Hapi8LoadFontEPciiPNS_9FontAtlasE
	.p2align	2
	.type	_ZN4Hapi8LoadFontEPciiPNS_9FontAtlasE,@function
_ZN4Hapi8LoadFontEPciiPNS_9FontAtlasE:  # @_ZN4Hapi8LoadFontEPciiPNS_9FontAtlasE
# %bb.0:
	sw	a1, 0(a0)
	sw	a2, 4(a0)
	sw	a3, 8(a0)
	sw	a4, 12(a0)
	ret
.Lfunc_end6:
	.size	_ZN4Hapi8LoadFontEPciiPNS_9FontAtlasE, .Lfunc_end6-_ZN4Hapi8LoadFontEPciiPNS_9FontAtlasE
                                        # -- End function
	.globl	_ZN4Hapi10UnloadFontENS_4FontE  # -- Begin function _ZN4Hapi10UnloadFontENS_4FontE
	.p2align	2
	.type	_ZN4Hapi10UnloadFontENS_4FontE,@function
_ZN4Hapi10UnloadFontENS_4FontE:         # @_ZN4Hapi10UnloadFontENS_4FontE
# %bb.0:
	ret
.Lfunc_end7:
	.size	_ZN4Hapi10UnloadFontENS_4FontE, .Lfunc_end7-_ZN4Hapi10UnloadFontENS_4FontE
                                        # -- End function
	.globl	_ZN4Hapi12StartDrawingEv        # -- Begin function _ZN4Hapi12StartDrawingEv
	.p2align	2
	.type	_ZN4Hapi12StartDrawingEv,@function
_ZN4Hapi12StartDrawingEv:               # @_ZN4Hapi12StartDrawingEv
# %bb.0:
	ret
.Lfunc_end8:
	.size	_ZN4Hapi12StartDrawingEv, .Lfunc_end8-_ZN4Hapi12StartDrawingEv
                                        # -- End function
	.globl	_ZN4Hapi10EndDrawingEv          # -- Begin function _ZN4Hapi10EndDrawingEv
	.p2align	2
	.type	_ZN4Hapi10EndDrawingEv,@function
_ZN4Hapi10EndDrawingEv:                 # @_ZN4Hapi10EndDrawingEv
# %bb.0:
	lui	a0, %hi(.L_MergedGlobals)
	addi	a0, a0, %lo(.L_MergedGlobals)
	lw	a1, 44(a0)
.LBB9_1:                                # =>This Inner Loop Header: Depth=1
	lw	a2, 0(a1)
	bnez	a2, .LBB9_1
# %bb.2:
	lw	a1, 52(a0)
	li	a2, 1
	sw	a2, 0(a1)
	lw	a0, 48(a0)
.LBB9_3:                                # =>This Inner Loop Header: Depth=1
	lw	a1, 0(a0)
	beqz	a1, .LBB9_3
# %bb.4:
	ret
.Lfunc_end9:
	.size	_ZN4Hapi10EndDrawingEv, .Lfunc_end9-_ZN4Hapi10EndDrawingEv
                                        # -- End function
	.globl	_ZN4Hapi4DrawEjiiiiiii          # -- Begin function _ZN4Hapi4DrawEjiiiiiii
	.p2align	2
	.type	_ZN4Hapi4DrawEjiiiiiii,@function
_ZN4Hapi4DrawEjiiiiiii:                 # @_ZN4Hapi4DrawEjiiiiiii
# %bb.0:
	lui	t0, %hi(.L_MergedGlobals+44)
	lw	t0, %lo(.L_MergedGlobals+44)(t0)
.LBB10_1:                               # =>This Inner Loop Header: Depth=1
	lw	t1, 0(t0)
	bnez	t1, .LBB10_1
# %bb.2:
	lui	t0, %hi(.L_MergedGlobals)
	lw	t1, %lo(.L_MergedGlobals)(t0)
	addi	t0, t0, %lo(.L_MergedGlobals)
	sw	a0, 0(t1)
	lw	a0, 4(t0)
	sw	a1, 0(a0)
	lw	a0, 8(t0)
	sw	a2, 0(a0)
	lw	a0, 12(t0)
	sw	a7, 0(a0)
	lw	a0, 16(t0)
	sw	a5, 0(a0)
	lw	a0, 20(t0)
	sw	a6, 0(a0)
	lw	a0, 24(t0)
	sw	a3, 0(a0)
	lw	a0, 28(t0)
	sw	a4, 0(a0)
	lw	a0, 36(t0)
	li	a1, 1
	sw	a1, 0(a0)
	ret
.Lfunc_end10:
	.size	_ZN4Hapi4DrawEjiiiiiii, .Lfunc_end10-_ZN4Hapi4DrawEjiiiiiii
                                        # -- End function
	.globl	_ZN4Hapi8DrawTextEPKcNS_4FontEiij # -- Begin function _ZN4Hapi8DrawTextEPKcNS_4FontEiij
	.p2align	2
	.type	_ZN4Hapi8DrawTextEPKcNS_4FontEiij,@function
_ZN4Hapi8DrawTextEPKcNS_4FontEiij:      # @_ZN4Hapi8DrawTextEPKcNS_4FontEiij
# %bb.0:
	addi	sp, sp, -48
	sw	s0, 44(sp)                      # 4-byte Folded Spill
	sw	s1, 40(sp)                      # 4-byte Folded Spill
	sw	s2, 36(sp)                      # 4-byte Folded Spill
	sw	s3, 32(sp)                      # 4-byte Folded Spill
	sw	s4, 28(sp)                      # 4-byte Folded Spill
	sw	s5, 24(sp)                      # 4-byte Folded Spill
	sw	s6, 20(sp)                      # 4-byte Folded Spill
	sw	s7, 16(sp)                      # 4-byte Folded Spill
	sw	s8, 12(sp)                      # 4-byte Folded Spill
	sw	s9, 8(sp)                       # 4-byte Folded Spill
	sw	s10, 4(sp)                      # 4-byte Folded Spill
	sw	s11, 0(sp)                      # 4-byte Folded Spill
	lbu	s4, 0(a0)
	beqz	s4, .LBB11_10
# %bb.1:
	lw	a5, 12(a1)
	lui	a6, %hi(.L_MergedGlobals)
	addi	s0, a6, %lo(.L_MergedGlobals)
	lw	a6, %lo(.L_MergedGlobals)(a6)
	lw	a7, 44(s0)
	lw	t0, 4(s0)
	lw	t1, 8(s0)
	lw	t2, 12(s0)
	lw	t3, 16(s0)
	lw	t4, 20(s0)
	lw	t5, 24(s0)
	lw	t6, 28(s0)
	lw	s0, 36(s0)
	li	s1, 32
	li	s2, 1
	mv	s3, a2
.LBB11_2:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB11_5 Depth 2
                                        #     Child Loop BB11_7 Depth 2
	slli	s7, s4, 4
	add	s7, a5, s7
	lw	s6, 8(s7)
	addi	s5, s6, 1
	sub	s8, s3, a2
	add	s8, s8, s5
	bltu	s8, a4, .LBB11_4
# %bb.3:                                #   in Loop: Header=BB11_2 Depth=1
	lw	s3, 12(s7)
	add	a3, a3, s3
	addi	a3, a3, 1
	mv	s3, a2
.LBB11_4:                               #   in Loop: Header=BB11_2 Depth=1
	beq	s4, s1, .LBB11_9
.LBB11_5:                               #   Parent Loop BB11_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	s4, 0(a7)
	bnez	s4, .LBB11_5
# %bb.6:                                #   in Loop: Header=BB11_2 Depth=1
	lw	s8, 0(s7)
	lw	s9, 4(s7)
	lw	s4, 12(s7)
	lw	s10, 0(a1)
	lw	s7, 4(a1)
.LBB11_7:                               #   Parent Loop BB11_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	s11, 0(a7)
	bnez	s11, .LBB11_7
# %bb.8:                                #   in Loop: Header=BB11_2 Depth=1
	sw	s10, 0(a6)
	sw	s8, 0(t0)
	sw	s9, 0(t1)
	sw	s7, 0(t2)
	sw	s6, 0(t3)
	sw	s4, 0(t4)
	sw	s3, 0(t5)
	sw	a3, 0(t6)
	sw	s2, 0(s0)
.LBB11_9:                               #   in Loop: Header=BB11_2 Depth=1
	lbu	s4, 1(a0)
	addi	a0, a0, 1
	add	s3, s3, s5
	bnez	s4, .LBB11_2
.LBB11_10:
	lw	s0, 44(sp)                      # 4-byte Folded Reload
	lw	s1, 40(sp)                      # 4-byte Folded Reload
	lw	s2, 36(sp)                      # 4-byte Folded Reload
	lw	s3, 32(sp)                      # 4-byte Folded Reload
	lw	s4, 28(sp)                      # 4-byte Folded Reload
	lw	s5, 24(sp)                      # 4-byte Folded Reload
	lw	s6, 20(sp)                      # 4-byte Folded Reload
	lw	s7, 16(sp)                      # 4-byte Folded Reload
	lw	s8, 12(sp)                      # 4-byte Folded Reload
	lw	s9, 8(sp)                       # 4-byte Folded Reload
	lw	s10, 4(sp)                      # 4-byte Folded Reload
	lw	s11, 0(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end11:
	.size	_ZN4Hapi8DrawTextEPKcNS_4FontEiij, .Lfunc_end11-_ZN4Hapi8DrawTextEPKcNS_4FontEiij
                                        # -- End function
	.globl	_ZN4Hapi8DrawTextEPKciij        # -- Begin function _ZN4Hapi8DrawTextEPKciij
	.p2align	2
	.type	_ZN4Hapi8DrawTextEPKciij,@function
_ZN4Hapi8DrawTextEPKciij:               # @_ZN4Hapi8DrawTextEPKciij
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	mv	a4, a3
	mv	a3, a2
	mv	a2, a1
	lui	a1, %hi(_ZN4Hapi11defaultFontE)
	lw	a5, %lo(_ZN4Hapi11defaultFontE)(a1)
	addi	a1, a1, %lo(_ZN4Hapi11defaultFontE)
	lw	a6, 4(a1)
	lw	a7, 8(a1)
	lw	a1, 12(a1)
	sw	a5, 12(sp)
	sw	a6, 16(sp)
	sw	a7, 20(sp)
	sw	a1, 24(sp)
	addi	a1, sp, 12
	call	_ZN4Hapi8DrawTextEPKcNS_4FontEiij
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end12:
	.size	_ZN4Hapi8DrawTextEPKciij, .Lfunc_end12-_ZN4Hapi8DrawTextEPKciij
                                        # -- End function
	.globl	_ZN4Hapi5ClearENS_5ColorE       # -- Begin function _ZN4Hapi5ClearENS_5ColorE
	.p2align	2
	.type	_ZN4Hapi5ClearENS_5ColorE,@function
_ZN4Hapi5ClearENS_5ColorE:              # @_ZN4Hapi5ClearENS_5ColorE
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	lui	s0, %hi(.L_MergedGlobals)
	addi	s0, s0, %lo(.L_MergedGlobals)
	lw	a2, 44(s0)
	sw	a0, 0(sp)
	sh	a1, 4(sp)
.LBB13_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, 0(a2)
	bnez	a0, .LBB13_1
# %bb.2:
	mv	a0, sp
	call	_ZN4Hapi5Color8GetColorEv
	lw	a1, 32(s0)
	sw	a0, 0(a1)
	lw	a0, 40(s0)
	li	a1, 1
	sw	a1, 0(a0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end13:
	.size	_ZN4Hapi5ClearENS_5ColorE, .Lfunc_end13-_ZN4Hapi5ClearENS_5ColorE
	.cfi_endproc
                                        # -- End function
	.globl	_ZN4Hapi12SetTargetFPSEi        # -- Begin function _ZN4Hapi12SetTargetFPSEi
	.p2align	2
	.type	_ZN4Hapi12SetTargetFPSEi,@function
_ZN4Hapi12SetTargetFPSEi:               # @_ZN4Hapi12SetTargetFPSEi
# %bb.0:
	ret
.Lfunc_end14:
	.size	_ZN4Hapi12SetTargetFPSEi, .Lfunc_end14-_ZN4Hapi12SetTargetFPSEi
                                        # -- End function
	.globl	_ZN4Hapi8SetVSyncEb             # -- Begin function _ZN4Hapi8SetVSyncEb
	.p2align	2
	.type	_ZN4Hapi8SetVSyncEb,@function
_ZN4Hapi8SetVSyncEb:                    # @_ZN4Hapi8SetVSyncEb
# %bb.0:
	lui	a1, %hi(VSYNC_BUFFER_SWAP)
	lw	a1, %lo(VSYNC_BUFFER_SWAP)(a1)
	sw	a0, 0(a1)
	ret
.Lfunc_end15:
	.size	_ZN4Hapi8SetVSyncEb, .Lfunc_end15-_ZN4Hapi8SetVSyncEb
                                        # -- End function
	.type	GPU_BLOCK,@object               # @GPU_BLOCK
	.data
	.globl	GPU_BLOCK
	.p2align	2, 0x0
GPU_BLOCK:
	.word	33554432
	.size	GPU_BLOCK, 4

	.type	GPU_HSYNC,@object               # @GPU_HSYNC
	.globl	GPU_HSYNC
	.p2align	2, 0x0
GPU_HSYNC:
	.word	33554484
	.size	GPU_HSYNC, 4

	.type	VSYNC_BUFFER_SWAP,@object       # @VSYNC_BUFFER_SWAP
	.globl	VSYNC_BUFFER_SWAP
	.p2align	2, 0x0
VSYNC_BUFFER_SWAP:
	.word	33554492
	.size	VSYNC_BUFFER_SWAP, 4

	.type	_ZN4Hapi11defaultFontE,@object  # @_ZN4Hapi11defaultFontE
	.bss
	.globl	_ZN4Hapi11defaultFontE
	.p2align	2, 0x0
_ZN4Hapi11defaultFontE:
	.zero	16
	.size	_ZN4Hapi11defaultFontE, 16

	.type	_ZL5atlas,@object               # @_ZL5atlas
	.local	_ZL5atlas
	.comm	_ZL5atlas,2048,4
	.type	_ZN6AssetsL11minifont5x3E,@object # @_ZN6AssetsL11minifont5x3E
	.section	.rodata,"a",@progbits
	.p2align	1, 0x0
_ZN6AssetsL11minifont5x3E:
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	0                               # 0x0
	.half	0                               # 0x0
	.size	_ZN6AssetsL11minifont5x3E, 3600

	.type	.L_MergedGlobals,@object        # @_MergedGlobals
	.data
	.p2align	2, 0x0
.L_MergedGlobals:
	.word	33554432
	.word	33554436
	.word	33554440
	.word	33554444
	.word	33554448
	.word	33554452
	.word	33554456
	.word	33554460
	.word	33554464
	.word	33554468
	.word	33554472
	.word	33554476
	.word	33554480
	.word	33554488
	.size	.L_MergedGlobals, 56

	.globl	GPU_IMAGE_START
.set GPU_IMAGE_START, .L_MergedGlobals
	.size	GPU_IMAGE_START, 4
	.globl	GPU_IMAGE_X
.set GPU_IMAGE_X, .L_MergedGlobals+4
	.size	GPU_IMAGE_X, 4
	.globl	GPU_IMAGE_Y
.set GPU_IMAGE_Y, .L_MergedGlobals+8
	.size	GPU_IMAGE_Y, 4
	.globl	GPU_IMAGE_WIDTH
.set GPU_IMAGE_WIDTH, .L_MergedGlobals+12
	.size	GPU_IMAGE_WIDTH, 4
	.globl	GPU_EXCERPT_WIDTH
.set GPU_EXCERPT_WIDTH, .L_MergedGlobals+16
	.size	GPU_EXCERPT_WIDTH, 4
	.globl	GPU_EXCERPT_HEIGHT
.set GPU_EXCERPT_HEIGHT, .L_MergedGlobals+20
	.size	GPU_EXCERPT_HEIGHT, 4
	.globl	GPU_SCREEN_X
.set GPU_SCREEN_X, .L_MergedGlobals+24
	.size	GPU_SCREEN_X, 4
	.globl	GPU_SCREEN_Y
.set GPU_SCREEN_Y, .L_MergedGlobals+28
	.size	GPU_SCREEN_Y, 4
	.globl	GPU_CLEAR_COLOR
.set GPU_CLEAR_COLOR, .L_MergedGlobals+32
	.size	GPU_CLEAR_COLOR, 4
	.globl	GPU_COMMAND_DRAW
.set GPU_COMMAND_DRAW, .L_MergedGlobals+36
	.size	GPU_COMMAND_DRAW, 4
	.globl	GPU_COMMAND_CLEAR
.set GPU_COMMAND_CLEAR, .L_MergedGlobals+40
	.size	GPU_COMMAND_CLEAR, 4
	.globl	GPU_IS_BUSY
.set GPU_IS_BUSY, .L_MergedGlobals+44
	.size	GPU_IS_BUSY, 4
	.globl	GPU_VSYNC
.set GPU_VSYNC, .L_MergedGlobals+48
	.size	GPU_VSYNC, 4
	.globl	GPU_COMMAND_SWAP_BUFFERS
.set GPU_COMMAND_SWAP_BUFFERS, .L_MergedGlobals+52
	.size	GPU_COMMAND_SWAP_BUFFERS, 4
	.ident	"clang version 21.0.0git"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _ZL5atlas
	.addrsig_sym _ZN6AssetsL11minifont5x3E
	.addrsig_sym .L_MergedGlobals
