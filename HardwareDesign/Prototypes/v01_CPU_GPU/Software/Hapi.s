	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"Hapi.cpp"
	.text
	.globl	_ZN4Hapi4InitEv                 # -- Begin function _ZN4Hapi4InitEv
	.p2align	2
	.type	_ZN4Hapi4InitEv,@function
_ZN4Hapi4InitEv:                        # @_ZN4Hapi4InitEv
# %bb.0:
	li	a0, 0
	ret
.Lfunc_end0:
	.size	_ZN4Hapi4InitEv, .Lfunc_end0-_ZN4Hapi4InitEv
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
	.globl	_ZN4Hapi12StartDrawingEv        # -- Begin function _ZN4Hapi12StartDrawingEv
	.p2align	2
	.type	_ZN4Hapi12StartDrawingEv,@function
_ZN4Hapi12StartDrawingEv:               # @_ZN4Hapi12StartDrawingEv
# %bb.0:
	ret
.Lfunc_end6:
	.size	_ZN4Hapi12StartDrawingEv, .Lfunc_end6-_ZN4Hapi12StartDrawingEv
                                        # -- End function
	.globl	_ZN4Hapi10EndDrawingEv          # -- Begin function _ZN4Hapi10EndDrawingEv
	.p2align	2
	.type	_ZN4Hapi10EndDrawingEv,@function
_ZN4Hapi10EndDrawingEv:                 # @_ZN4Hapi10EndDrawingEv
# %bb.0:
	lui	a0, %hi(.L_MergedGlobals)
	addi	a0, a0, %lo(.L_MergedGlobals)
	lw	a1, 48(a0)
	li	a2, 1
	sw	a2, 0(a1)
	lw	a0, 52(a0)
.LBB7_1:                                # =>This Inner Loop Header: Depth=1
	lw	a1, 0(a0)
	beqz	a1, .LBB7_1
# %bb.2:
	ret
.Lfunc_end7:
	.size	_ZN4Hapi10EndDrawingEv, .Lfunc_end7-_ZN4Hapi10EndDrawingEv
                                        # -- End function
	.globl	_ZN4Hapi4DrawEjiiiiiii          # -- Begin function _ZN4Hapi4DrawEjiiiiiii
	.p2align	2
	.type	_ZN4Hapi4DrawEjiiiiiii,@function
_ZN4Hapi4DrawEjiiiiiii:                 # @_ZN4Hapi4DrawEjiiiiiii
# %bb.0:
	lui	t0, %hi(.L_MergedGlobals+44)
	lw	t0, %lo(.L_MergedGlobals+44)(t0)
.LBB8_1:                                # =>This Inner Loop Header: Depth=1
	lw	t1, 0(t0)
	bnez	t1, .LBB8_1
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
	lw	a0, 32(t0)
	li	a1, 1
	sw	a1, 0(a0)
	ret
.Lfunc_end8:
	.size	_ZN4Hapi4DrawEjiiiiiii, .Lfunc_end8-_ZN4Hapi4DrawEjiiiiiii
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
.LBB9_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, 0(a2)
	bnez	a0, .LBB9_1
# %bb.2:
	mv	a0, sp
	call	_ZN4Hapi5Color8GetColorEv
	lw	a1, 36(s0)
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
.Lfunc_end9:
	.size	_ZN4Hapi5ClearENS_5ColorE, .Lfunc_end9-_ZN4Hapi5ClearENS_5ColorE
	.cfi_endproc
                                        # -- End function
	.globl	_ZN4Hapi12SetTargetFPSEi        # -- Begin function _ZN4Hapi12SetTargetFPSEi
	.p2align	2
	.type	_ZN4Hapi12SetTargetFPSEi,@function
_ZN4Hapi12SetTargetFPSEi:               # @_ZN4Hapi12SetTargetFPSEi
# %bb.0:
	lui	a0, %hi(CLOCK_FREQ)
	lw	a0, %lo(CLOCK_FREQ)(a0)
	lw	zero, 0(a0)
	ret
.Lfunc_end10:
	.size	_ZN4Hapi12SetTargetFPSEi, .Lfunc_end10-_ZN4Hapi12SetTargetFPSEi
                                        # -- End function
	.globl	_ZN4Hapi8SetVSyncEb             # -- Begin function _ZN4Hapi8SetVSyncEb
	.p2align	2
	.type	_ZN4Hapi8SetVSyncEb,@function
_ZN4Hapi8SetVSyncEb:                    # @_ZN4Hapi8SetVSyncEb
# %bb.0:
	lui	a1, %hi(GPU_IS_V_SYNCED)
	lw	a1, %lo(GPU_IS_V_SYNCED)(a1)
	sw	a0, 0(a1)
	ret
.Lfunc_end11:
	.size	_ZN4Hapi8SetVSyncEb, .Lfunc_end11-_ZN4Hapi8SetVSyncEb
                                        # -- End function
	.type	GPU_BLOCK,@object               # @GPU_BLOCK
	.data
	.globl	GPU_BLOCK
	.p2align	2, 0x0
GPU_BLOCK:
	.word	24576
	.size	GPU_BLOCK, 4

	.type	GPU_IS_V_SYNCED,@object         # @GPU_IS_V_SYNCED
	.globl	GPU_IS_V_SYNCED
	.p2align	2, 0x0
GPU_IS_V_SYNCED:
	.word	24836
	.size	GPU_IS_V_SYNCED, 4

	.type	CLOCK,@object                   # @CLOCK
	.bss
	.globl	CLOCK
	.p2align	2, 0x0
CLOCK:
	.word	0
	.size	CLOCK, 4

	.type	CLOCK_FREQ,@object              # @CLOCK_FREQ
	.globl	CLOCK_FREQ
	.p2align	2, 0x0
CLOCK_FREQ:
	.word	0
	.size	CLOCK_FREQ, 4

	.type	CLOCK_LOW,@object               # @CLOCK_LOW
	.data
	.globl	CLOCK_LOW
	.p2align	2, 0x0
CLOCK_LOW:
	.word	4
	.size	CLOCK_LOW, 4

	.type	CLOCK_HIGH,@object              # @CLOCK_HIGH
	.globl	CLOCK_HIGH
	.p2align	2, 0x0
CLOCK_HIGH:
	.word	8
	.size	CLOCK_HIGH, 4

	.type	INPUT_ADDRESS,@object           # @INPUT_ADDRESS
	.globl	INPUT_ADDRESS
	.p2align	2, 0x0
INPUT_ADDRESS:
	.word	4294967295
	.size	INPUT_ADDRESS, 4

	.type	.L_MergedGlobals,@object        # @_MergedGlobals
	.p2align	2, 0x0
.L_MergedGlobals:
	.word	24576
	.word	24580
	.word	24584
	.word	24588
	.word	24592
	.word	24596
	.word	24600
	.word	24604
	.word	24608
	.word	24612
	.word	24616
	.word	24620
	.word	24832
	.word	24840
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
	.globl	GPU_COMMAND_DRAW
.set GPU_COMMAND_DRAW, .L_MergedGlobals+32
	.size	GPU_COMMAND_DRAW, 4
	.globl	GPU_CLEAR_COLOR
.set GPU_CLEAR_COLOR, .L_MergedGlobals+36
	.size	GPU_CLEAR_COLOR, 4
	.globl	GPU_COMMAND_CLEAR
.set GPU_COMMAND_CLEAR, .L_MergedGlobals+40
	.size	GPU_COMMAND_CLEAR, 4
	.globl	GPU_IS_BUSY
.set GPU_IS_BUSY, .L_MergedGlobals+44
	.size	GPU_IS_BUSY, 4
	.globl	GPU_SWAP_BUFFERS
.set GPU_SWAP_BUFFERS, .L_MergedGlobals+48
	.size	GPU_SWAP_BUFFERS, 4
	.globl	GPU_VSYNC
.set GPU_VSYNC, .L_MergedGlobals+52
	.size	GPU_VSYNC, 4
	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym .L_MergedGlobals
