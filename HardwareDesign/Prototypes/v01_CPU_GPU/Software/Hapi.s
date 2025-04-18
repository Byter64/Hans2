	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"Hapi.cpp"
	.text
	.p2align	2                               # -- Begin function __cxx_global_var_init
	.type	__cxx_global_var_init,@function
__cxx_global_var_init:                  # @__cxx_global_var_init
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	lui	a1, %hi(GPU_IMAGE_START)
	sw	a0, %lo(GPU_IMAGE_START)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	__cxx_global_var_init, .Lfunc_end0-__cxx_global_var_init
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.1
	.type	__cxx_global_var_init.1,@function
__cxx_global_var_init.1:                # @__cxx_global_var_init.1
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 4
	lui	a1, %hi(GPU_IMAGE_X)
	sw	a0, %lo(GPU_IMAGE_X)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	__cxx_global_var_init.1, .Lfunc_end1-__cxx_global_var_init.1
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.2
	.type	__cxx_global_var_init.2,@function
__cxx_global_var_init.2:                # @__cxx_global_var_init.2
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 8
	lui	a1, %hi(GPU_IMAGE_Y)
	sw	a0, %lo(GPU_IMAGE_Y)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	__cxx_global_var_init.2, .Lfunc_end2-__cxx_global_var_init.2
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.3
	.type	__cxx_global_var_init.3,@function
__cxx_global_var_init.3:                # @__cxx_global_var_init.3
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 12
	lui	a1, %hi(GPU_IMAGE_WIDTH)
	sw	a0, %lo(GPU_IMAGE_WIDTH)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	__cxx_global_var_init.3, .Lfunc_end3-__cxx_global_var_init.3
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.4
	.type	__cxx_global_var_init.4,@function
__cxx_global_var_init.4:                # @__cxx_global_var_init.4
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 16
	lui	a1, %hi(GPU_EXCERPT_WIDTH)
	sw	a0, %lo(GPU_EXCERPT_WIDTH)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	__cxx_global_var_init.4, .Lfunc_end4-__cxx_global_var_init.4
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.5
	.type	__cxx_global_var_init.5,@function
__cxx_global_var_init.5:                # @__cxx_global_var_init.5
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 20
	lui	a1, %hi(GPU_EXCERPT_HEIGHT)
	sw	a0, %lo(GPU_EXCERPT_HEIGHT)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	__cxx_global_var_init.5, .Lfunc_end5-__cxx_global_var_init.5
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.6
	.type	__cxx_global_var_init.6,@function
__cxx_global_var_init.6:                # @__cxx_global_var_init.6
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 24
	lui	a1, %hi(GPU_SCREEN_X)
	sw	a0, %lo(GPU_SCREEN_X)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	__cxx_global_var_init.6, .Lfunc_end6-__cxx_global_var_init.6
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.7
	.type	__cxx_global_var_init.7,@function
__cxx_global_var_init.7:                # @__cxx_global_var_init.7
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 28
	lui	a1, %hi(GPU_SCREEN_Y)
	sw	a0, %lo(GPU_SCREEN_Y)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	__cxx_global_var_init.7, .Lfunc_end7-__cxx_global_var_init.7
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.8
	.type	__cxx_global_var_init.8,@function
__cxx_global_var_init.8:                # @__cxx_global_var_init.8
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 32
	lui	a1, %hi(GPU_COMMAND_DRAW)
	sw	a0, %lo(GPU_COMMAND_DRAW)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	__cxx_global_var_init.8, .Lfunc_end8-__cxx_global_var_init.8
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.9
	.type	__cxx_global_var_init.9,@function
__cxx_global_var_init.9:                # @__cxx_global_var_init.9
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 36
	lui	a1, %hi(GPU_CLEAR_COLOR)
	sw	a0, %lo(GPU_CLEAR_COLOR)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	__cxx_global_var_init.9, .Lfunc_end9-__cxx_global_var_init.9
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.10
	.type	__cxx_global_var_init.10,@function
__cxx_global_var_init.10:               # @__cxx_global_var_init.10
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 40
	lui	a1, %hi(GPU_COMMAND_CLEAR)
	sw	a0, %lo(GPU_COMMAND_CLEAR)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	__cxx_global_var_init.10, .Lfunc_end10-__cxx_global_var_init.10
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.11
	.type	__cxx_global_var_init.11,@function
__cxx_global_var_init.11:               # @__cxx_global_var_init.11
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 44
	lui	a1, %hi(GPU_IS_BUSY)
	sw	a0, %lo(GPU_IS_BUSY)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	__cxx_global_var_init.11, .Lfunc_end11-__cxx_global_var_init.11
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.12
	.type	__cxx_global_var_init.12,@function
__cxx_global_var_init.12:               # @__cxx_global_var_init.12
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 256
	lui	a1, %hi(GPU_SWAP_BUFFERS)
	sw	a0, %lo(GPU_SWAP_BUFFERS)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end12:
	.size	__cxx_global_var_init.12, .Lfunc_end12-__cxx_global_var_init.12
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.13
	.type	__cxx_global_var_init.13,@function
__cxx_global_var_init.13:               # @__cxx_global_var_init.13
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 260
	lui	a1, %hi(GPU_IS_V_SYNCED)
	sw	a0, %lo(GPU_IS_V_SYNCED)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end13:
	.size	__cxx_global_var_init.13, .Lfunc_end13-__cxx_global_var_init.13
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.14
	.type	__cxx_global_var_init.14,@function
__cxx_global_var_init.14:               # @__cxx_global_var_init.14
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
	lui	a0, %hi(GPU_BLOCK)
	lw	a0, %lo(GPU_BLOCK)(a0)
	addi	a0, a0, 264
	lui	a1, %hi(GPU_VSYNC)
	sw	a0, %lo(GPU_VSYNC)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end14:
	.size	__cxx_global_var_init.14, .Lfunc_end14-__cxx_global_var_init.14
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.15
	.type	__cxx_global_var_init.15,@function
__cxx_global_var_init.15:               # @__cxx_global_var_init.15
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
	lui	a0, %hi(CLOCK)
	lw	a0, %lo(CLOCK)(a0)
	lui	a1, %hi(CLOCK_FREQ)
	sw	a0, %lo(CLOCK_FREQ)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end15:
	.size	__cxx_global_var_init.15, .Lfunc_end15-__cxx_global_var_init.15
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.16
	.type	__cxx_global_var_init.16,@function
__cxx_global_var_init.16:               # @__cxx_global_var_init.16
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
	lui	a0, %hi(CLOCK)
	lw	a0, %lo(CLOCK)(a0)
	addi	a0, a0, 4
	lui	a1, %hi(CLOCK_LOW)
	sw	a0, %lo(CLOCK_LOW)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end16:
	.size	__cxx_global_var_init.16, .Lfunc_end16-__cxx_global_var_init.16
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __cxx_global_var_init.17
	.type	__cxx_global_var_init.17,@function
__cxx_global_var_init.17:               # @__cxx_global_var_init.17
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
	lui	a0, %hi(CLOCK)
	lw	a0, %lo(CLOCK)(a0)
	addi	a0, a0, 8
	lui	a1, %hi(CLOCK_HIGH)
	sw	a0, %lo(CLOCK_HIGH)(a1)
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end17:
	.size	__cxx_global_var_init.17, .Lfunc_end17-__cxx_global_var_init.17
	.cfi_endproc
                                        # -- End function
	.globl	_ZN4Hapi4InitEv                 # -- Begin function _ZN4Hapi4InitEv
	.p2align	2
	.type	_ZN4Hapi4InitEv,@function
_ZN4Hapi4InitEv:                        # @_ZN4Hapi4InitEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	li	a0, 0
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end18:
	.size	_ZN4Hapi4InitEv, .Lfunc_end18-_ZN4Hapi4InitEv
                                        # -- End function
	.globl	_ZN4Hapi9TerminateEv            # -- Begin function _ZN4Hapi9TerminateEv
	.p2align	2
	.type	_ZN4Hapi9TerminateEv,@function
_ZN4Hapi9TerminateEv:                   # @_ZN4Hapi9TerminateEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	li	a0, 0
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end19:
	.size	_ZN4Hapi9TerminateEv, .Lfunc_end19-_ZN4Hapi9TerminateEv
                                        # -- End function
	.globl	_ZN4Hapi11ShouldCloseEv         # -- Begin function _ZN4Hapi11ShouldCloseEv
	.p2align	2
	.type	_ZN4Hapi11ShouldCloseEv,@function
_ZN4Hapi11ShouldCloseEv:                # @_ZN4Hapi11ShouldCloseEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	li	a0, 0
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end20:
	.size	_ZN4Hapi11ShouldCloseEv, .Lfunc_end20-_ZN4Hapi11ShouldCloseEv
                                        # -- End function
	.globl	_ZN4Hapi9LoadImageEPcii         # -- Begin function _ZN4Hapi9LoadImageEPcii
	.p2align	2
	.type	_ZN4Hapi9LoadImageEPcii,@function
_ZN4Hapi9LoadImageEPcii:                # @_ZN4Hapi9LoadImageEPcii
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a0, -12(s0)
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end21:
	.size	_ZN4Hapi9LoadImageEPcii, .Lfunc_end21-_ZN4Hapi9LoadImageEPcii
                                        # -- End function
	.globl	_ZN4Hapi11UpdateImageEjPcii     # -- Begin function _ZN4Hapi11UpdateImageEjPcii
	.p2align	2
	.type	_ZN4Hapi11UpdateImageEjPcii,@function
_ZN4Hapi11UpdateImageEjPcii:            # @_ZN4Hapi11UpdateImageEjPcii
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end22:
	.size	_ZN4Hapi11UpdateImageEjPcii, .Lfunc_end22-_ZN4Hapi11UpdateImageEjPcii
                                        # -- End function
	.globl	_ZN4Hapi11UnloadImageEj         # -- Begin function _ZN4Hapi11UnloadImageEj
	.p2align	2
	.type	_ZN4Hapi11UnloadImageEj,@function
_ZN4Hapi11UnloadImageEj:                # @_ZN4Hapi11UnloadImageEj
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end23:
	.size	_ZN4Hapi11UnloadImageEj, .Lfunc_end23-_ZN4Hapi11UnloadImageEj
                                        # -- End function
	.globl	_ZN4Hapi12StartDrawingEv        # -- Begin function _ZN4Hapi12StartDrawingEv
	.p2align	2
	.type	_ZN4Hapi12StartDrawingEv,@function
_ZN4Hapi12StartDrawingEv:               # @_ZN4Hapi12StartDrawingEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end24:
	.size	_ZN4Hapi12StartDrawingEv, .Lfunc_end24-_ZN4Hapi12StartDrawingEv
                                        # -- End function
	.globl	_ZN4Hapi10EndDrawingEv          # -- Begin function _ZN4Hapi10EndDrawingEv
	.p2align	2
	.type	_ZN4Hapi10EndDrawingEv,@function
_ZN4Hapi10EndDrawingEv:                 # @_ZN4Hapi10EndDrawingEv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	lui	a0, %hi(GPU_SWAP_BUFFERS)
	lw	a1, %lo(GPU_SWAP_BUFFERS)(a0)
	li	a0, 1
	sw	a0, 0(a1)
	j	.LBB25_1
.LBB25_1:                               # =>This Inner Loop Header: Depth=1
	lui	a0, %hi(GPU_VSYNC)
	lw	a0, %lo(GPU_VSYNC)(a0)
	lw	a0, 0(a0)
	bnez	a0, .LBB25_3
	j	.LBB25_2
.LBB25_2:                               #   in Loop: Header=BB25_1 Depth=1
	j	.LBB25_1
.LBB25_3:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end25:
	.size	_ZN4Hapi10EndDrawingEv, .Lfunc_end25-_ZN4Hapi10EndDrawingEv
                                        # -- End function
	.globl	_ZN4Hapi4DrawEjiiiiiii          # -- Begin function _ZN4Hapi4DrawEjiiiiiii
	.p2align	2
	.type	_ZN4Hapi4DrawEjiiiiiii,@function
_ZN4Hapi4DrawEjiiiiiii:                 # @_ZN4Hapi4DrawEjiiiiiii
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
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	sw	a4, -28(s0)
	sw	a5, -32(s0)
	sw	a6, -36(s0)
	sw	a7, -40(s0)
	call	_ZL10WaitForGPUv
	lw	a0, -12(s0)
	lui	a1, %hi(GPU_IMAGE_START)
	lw	a1, %lo(GPU_IMAGE_START)(a1)
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lui	a1, %hi(GPU_IMAGE_X)
	lw	a1, %lo(GPU_IMAGE_X)(a1)
	sw	a0, 0(a1)
	lw	a0, -20(s0)
	lui	a1, %hi(GPU_IMAGE_Y)
	lw	a1, %lo(GPU_IMAGE_Y)(a1)
	sw	a0, 0(a1)
	lw	a0, -40(s0)
	lui	a1, %hi(GPU_IMAGE_WIDTH)
	lw	a1, %lo(GPU_IMAGE_WIDTH)(a1)
	sw	a0, 0(a1)
	lw	a0, -32(s0)
	lui	a1, %hi(GPU_EXCERPT_WIDTH)
	lw	a1, %lo(GPU_EXCERPT_WIDTH)(a1)
	sw	a0, 0(a1)
	lw	a0, -36(s0)
	lui	a1, %hi(GPU_EXCERPT_HEIGHT)
	lw	a1, %lo(GPU_EXCERPT_HEIGHT)(a1)
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	lui	a1, %hi(GPU_SCREEN_X)
	lw	a1, %lo(GPU_SCREEN_X)(a1)
	sw	a0, 0(a1)
	lw	a0, -28(s0)
	lui	a1, %hi(GPU_SCREEN_Y)
	lw	a1, %lo(GPU_SCREEN_Y)(a1)
	sw	a0, 0(a1)
	lui	a0, %hi(GPU_COMMAND_DRAW)
	lw	a1, %lo(GPU_COMMAND_DRAW)(a0)
	li	a0, 1
	sw	a0, 0(a1)
	.cfi_def_cfa sp, 48
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end26:
	.size	_ZN4Hapi4DrawEjiiiiiii, .Lfunc_end26-_ZN4Hapi4DrawEjiiiiiii
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function _ZL10WaitForGPUv
	.type	_ZL10WaitForGPUv,@function
_ZL10WaitForGPUv:                       # @_ZL10WaitForGPUv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	lui	a0, %hi(GPU_IS_BUSY)
	lw	a0, %lo(GPU_IS_BUSY)(a0)
	sw	a0, -12(s0)
	j	.LBB27_1
.LBB27_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	lw	a0, 0(a0)
	beqz	a0, .LBB27_3
	j	.LBB27_2
.LBB27_2:                               #   in Loop: Header=BB27_1 Depth=1
	j	.LBB27_1
.LBB27_3:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end27:
	.size	_ZL10WaitForGPUv, .Lfunc_end27-_ZL10WaitForGPUv
                                        # -- End function
	.globl	_ZN4Hapi5ClearENS_5ColorE       # -- Begin function _ZN4Hapi5ClearENS_5ColorE
	.p2align	2
	.type	_ZN4Hapi5ClearENS_5ColorE,@function
_ZN4Hapi5ClearENS_5ColorE:              # @_ZN4Hapi5ClearENS_5ColorE
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
                                        # kill: def $x12 killed $x11
                                        # kill: def $x12 killed $x10
	sw	a1, -20(s0)
	sw	a0, -24(s0)
	lh	a0, -20(s0)
	sh	a0, -12(s0)
	lw	a0, -24(s0)
	sw	a0, -16(s0)
	call	_ZL10WaitForGPUv
	addi	a0, s0, -16
	call	_ZN4Hapi5Color8GetColorEv
	lui	a1, %hi(GPU_CLEAR_COLOR)
	lw	a1, %lo(GPU_CLEAR_COLOR)(a1)
	sw	a0, 0(a1)
	lui	a0, %hi(GPU_COMMAND_CLEAR)
	lw	a1, %lo(GPU_COMMAND_CLEAR)(a0)
	li	a0, 1
	sw	a0, 0(a1)
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end28:
	.size	_ZN4Hapi5ClearENS_5ColorE, .Lfunc_end28-_ZN4Hapi5ClearENS_5ColorE
	.cfi_endproc
                                        # -- End function
	.globl	_ZN4Hapi12SetTargetFPSEi        # -- Begin function _ZN4Hapi12SetTargetFPSEi
	.p2align	2
	.type	_ZN4Hapi12SetTargetFPSEi,@function
_ZN4Hapi12SetTargetFPSEi:               # @_ZN4Hapi12SetTargetFPSEi
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lui	a0, %hi(CLOCK_FREQ)
	lw	a0, %lo(CLOCK_FREQ)(a0)
	lw	a0, 0(a0)
	lw	a1, -12(s0)
	div	a0, a0, a1
	lui	a1, %hi(_ZL11targetTicks)
	sw	a0, %lo(_ZL11targetTicks)(a1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end29:
	.size	_ZN4Hapi12SetTargetFPSEi, .Lfunc_end29-_ZN4Hapi12SetTargetFPSEi
                                        # -- End function
	.globl	_ZN4Hapi8SetVSyncEb             # -- Begin function _ZN4Hapi8SetVSyncEb
	.p2align	2
	.type	_ZN4Hapi8SetVSyncEb,@function
_ZN4Hapi8SetVSyncEb:                    # @_ZN4Hapi8SetVSyncEb
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
                                        # kill: def $x11 killed $x10
	sb	a0, -9(s0)
	lbu	a0, -9(s0)
	andi	a0, a0, 1
	lui	a1, %hi(GPU_IS_V_SYNCED)
	lw	a1, %lo(GPU_IS_V_SYNCED)(a1)
	sw	a0, 0(a1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end30:
	.size	_ZN4Hapi8SetVSyncEb, .Lfunc_end30-_ZN4Hapi8SetVSyncEb
                                        # -- End function
	.p2align	2                               # -- Begin function _GLOBAL__sub_I_Hapi.cpp
	.type	_GLOBAL__sub_I_Hapi.cpp,@function
_GLOBAL__sub_I_Hapi.cpp:                # @_GLOBAL__sub_I_Hapi.cpp
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
	call	__cxx_global_var_init
	call	__cxx_global_var_init.1
	call	__cxx_global_var_init.2
	call	__cxx_global_var_init.3
	call	__cxx_global_var_init.4
	call	__cxx_global_var_init.5
	call	__cxx_global_var_init.6
	call	__cxx_global_var_init.7
	call	__cxx_global_var_init.8
	call	__cxx_global_var_init.9
	call	__cxx_global_var_init.10
	call	__cxx_global_var_init.11
	call	__cxx_global_var_init.12
	call	__cxx_global_var_init.13
	call	__cxx_global_var_init.14
	call	__cxx_global_var_init.15
	call	__cxx_global_var_init.16
	call	__cxx_global_var_init.17
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end31:
	.size	_GLOBAL__sub_I_Hapi.cpp, .Lfunc_end31-_GLOBAL__sub_I_Hapi.cpp
	.cfi_endproc
                                        # -- End function
	.type	GPU_BLOCK,@object               # @GPU_BLOCK
	.data
	.globl	GPU_BLOCK
	.p2align	2, 0x0
GPU_BLOCK:
	.word	24576
	.size	GPU_BLOCK, 4

	.type	GPU_IMAGE_START,@object         # @GPU_IMAGE_START
	.bss
	.globl	GPU_IMAGE_START
	.p2align	2, 0x0
GPU_IMAGE_START:
	.word	0
	.size	GPU_IMAGE_START, 4

	.type	GPU_IMAGE_X,@object             # @GPU_IMAGE_X
	.globl	GPU_IMAGE_X
	.p2align	2, 0x0
GPU_IMAGE_X:
	.word	0
	.size	GPU_IMAGE_X, 4

	.type	GPU_IMAGE_Y,@object             # @GPU_IMAGE_Y
	.globl	GPU_IMAGE_Y
	.p2align	2, 0x0
GPU_IMAGE_Y:
	.word	0
	.size	GPU_IMAGE_Y, 4

	.type	GPU_IMAGE_WIDTH,@object         # @GPU_IMAGE_WIDTH
	.globl	GPU_IMAGE_WIDTH
	.p2align	2, 0x0
GPU_IMAGE_WIDTH:
	.word	0
	.size	GPU_IMAGE_WIDTH, 4

	.type	GPU_EXCERPT_WIDTH,@object       # @GPU_EXCERPT_WIDTH
	.globl	GPU_EXCERPT_WIDTH
	.p2align	2, 0x0
GPU_EXCERPT_WIDTH:
	.word	0
	.size	GPU_EXCERPT_WIDTH, 4

	.type	GPU_EXCERPT_HEIGHT,@object      # @GPU_EXCERPT_HEIGHT
	.globl	GPU_EXCERPT_HEIGHT
	.p2align	2, 0x0
GPU_EXCERPT_HEIGHT:
	.word	0
	.size	GPU_EXCERPT_HEIGHT, 4

	.type	GPU_SCREEN_X,@object            # @GPU_SCREEN_X
	.globl	GPU_SCREEN_X
	.p2align	2, 0x0
GPU_SCREEN_X:
	.word	0
	.size	GPU_SCREEN_X, 4

	.type	GPU_SCREEN_Y,@object            # @GPU_SCREEN_Y
	.globl	GPU_SCREEN_Y
	.p2align	2, 0x0
GPU_SCREEN_Y:
	.word	0
	.size	GPU_SCREEN_Y, 4

	.type	GPU_COMMAND_DRAW,@object        # @GPU_COMMAND_DRAW
	.globl	GPU_COMMAND_DRAW
	.p2align	2, 0x0
GPU_COMMAND_DRAW:
	.word	0
	.size	GPU_COMMAND_DRAW, 4

	.type	GPU_CLEAR_COLOR,@object         # @GPU_CLEAR_COLOR
	.globl	GPU_CLEAR_COLOR
	.p2align	2, 0x0
GPU_CLEAR_COLOR:
	.word	0
	.size	GPU_CLEAR_COLOR, 4

	.type	GPU_COMMAND_CLEAR,@object       # @GPU_COMMAND_CLEAR
	.globl	GPU_COMMAND_CLEAR
	.p2align	2, 0x0
GPU_COMMAND_CLEAR:
	.word	0
	.size	GPU_COMMAND_CLEAR, 4

	.type	GPU_IS_BUSY,@object             # @GPU_IS_BUSY
	.globl	GPU_IS_BUSY
	.p2align	2, 0x0
GPU_IS_BUSY:
	.word	0
	.size	GPU_IS_BUSY, 4

	.type	GPU_SWAP_BUFFERS,@object        # @GPU_SWAP_BUFFERS
	.globl	GPU_SWAP_BUFFERS
	.p2align	2, 0x0
GPU_SWAP_BUFFERS:
	.word	0
	.size	GPU_SWAP_BUFFERS, 4

	.type	GPU_IS_V_SYNCED,@object         # @GPU_IS_V_SYNCED
	.globl	GPU_IS_V_SYNCED
	.p2align	2, 0x0
GPU_IS_V_SYNCED:
	.word	0
	.size	GPU_IS_V_SYNCED, 4

	.type	GPU_VSYNC,@object               # @GPU_VSYNC
	.globl	GPU_VSYNC
	.p2align	2, 0x0
GPU_VSYNC:
	.word	0
	.size	GPU_VSYNC, 4

	.type	CLOCK,@object                   # @CLOCK
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
	.globl	CLOCK_LOW
	.p2align	2, 0x0
CLOCK_LOW:
	.word	0
	.size	CLOCK_LOW, 4

	.type	CLOCK_HIGH,@object              # @CLOCK_HIGH
	.globl	CLOCK_HIGH
	.p2align	2, 0x0
CLOCK_HIGH:
	.word	0
	.size	CLOCK_HIGH, 4

	.type	INPUT_ADDRESS,@object           # @INPUT_ADDRESS
	.data
	.globl	INPUT_ADDRESS
	.p2align	2, 0x0
INPUT_ADDRESS:
	.word	4294967295
	.size	INPUT_ADDRESS, 4

	.type	_ZL11targetTicks,@object        # @_ZL11targetTicks
	.local	_ZL11targetTicks
	.comm	_ZL11targetTicks,4,4
	.section	.init_array,"aw",@init_array
	.p2align	2, 0x0
	.word	_GLOBAL__sub_I_Hapi.cpp
	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __cxx_global_var_init
	.addrsig_sym __cxx_global_var_init.1
	.addrsig_sym __cxx_global_var_init.2
	.addrsig_sym __cxx_global_var_init.3
	.addrsig_sym __cxx_global_var_init.4
	.addrsig_sym __cxx_global_var_init.5
	.addrsig_sym __cxx_global_var_init.6
	.addrsig_sym __cxx_global_var_init.7
	.addrsig_sym __cxx_global_var_init.8
	.addrsig_sym __cxx_global_var_init.9
	.addrsig_sym __cxx_global_var_init.10
	.addrsig_sym __cxx_global_var_init.11
	.addrsig_sym __cxx_global_var_init.12
	.addrsig_sym __cxx_global_var_init.13
	.addrsig_sym __cxx_global_var_init.14
	.addrsig_sym __cxx_global_var_init.15
	.addrsig_sym __cxx_global_var_init.16
	.addrsig_sym __cxx_global_var_init.17
	.addrsig_sym _ZL10WaitForGPUv
	.addrsig_sym _ZN4Hapi5Color8GetColorEv
	.addrsig_sym _GLOBAL__sub_I_Hapi.cpp
	.addrsig_sym GPU_BLOCK
	.addrsig_sym GPU_IMAGE_START
	.addrsig_sym GPU_IMAGE_X
	.addrsig_sym GPU_IMAGE_Y
	.addrsig_sym GPU_IMAGE_WIDTH
	.addrsig_sym GPU_EXCERPT_WIDTH
	.addrsig_sym GPU_EXCERPT_HEIGHT
	.addrsig_sym GPU_SCREEN_X
	.addrsig_sym GPU_SCREEN_Y
	.addrsig_sym GPU_COMMAND_DRAW
	.addrsig_sym GPU_CLEAR_COLOR
	.addrsig_sym GPU_COMMAND_CLEAR
	.addrsig_sym GPU_IS_BUSY
	.addrsig_sym GPU_SWAP_BUFFERS
	.addrsig_sym GPU_IS_V_SYNCED
	.addrsig_sym GPU_VSYNC
	.addrsig_sym CLOCK
	.addrsig_sym CLOCK_FREQ
	.addrsig_sym CLOCK_LOW
	.addrsig_sym CLOCK_HIGH
	.addrsig_sym _ZL11targetTicks
