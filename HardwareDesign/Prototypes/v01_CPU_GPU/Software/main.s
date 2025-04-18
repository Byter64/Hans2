	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"main.cpp"
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 512
	lui	a1, %hi(GET_BUTTON_F1)
	sw	a0, %lo(GET_BUTTON_F1)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 516
	lui	a1, %hi(GET_BUTTON_F2)
	sw	a0, %lo(GET_BUTTON_F2)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 520
	lui	a1, %hi(GET_BUTTON_UP)
	sw	a0, %lo(GET_BUTTON_UP)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 524
	lui	a1, %hi(GET_BUTTON_DOWN)
	sw	a0, %lo(GET_BUTTON_DOWN)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 528
	lui	a1, %hi(GET_BUTTON_LEFT)
	sw	a0, %lo(GET_BUTTON_LEFT)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 532
	lui	a1, %hi(GET_BUTTON_RIGHT)
	sw	a0, %lo(GET_BUTTON_RIGHT)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1024
	lui	a1, %hi(GET_NES_B)
	sw	a0, %lo(GET_NES_B)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1028
	lui	a1, %hi(GET_NES_Y)
	sw	a0, %lo(GET_NES_Y)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1032
	lui	a1, %hi(GET_NES_SELECT)
	sw	a0, %lo(GET_NES_SELECT)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1036
	lui	a1, %hi(GET_NES_START)
	sw	a0, %lo(GET_NES_START)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1040
	lui	a1, %hi(GET_NES_UP)
	sw	a0, %lo(GET_NES_UP)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1044
	lui	a1, %hi(GET_NES_DOWN)
	sw	a0, %lo(GET_NES_DOWN)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1048
	lui	a1, %hi(GET_NES_LEFT)
	sw	a0, %lo(GET_NES_LEFT)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1052
	lui	a1, %hi(GET_NES_RIGHT)
	sw	a0, %lo(GET_NES_RIGHT)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1056
	lui	a1, %hi(GET_NES_A)
	sw	a0, %lo(GET_NES_A)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1060
	lui	a1, %hi(GET_NES_X)
	sw	a0, %lo(GET_NES_X)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1064
	lui	a1, %hi(GET_NES_L)
	sw	a0, %lo(GET_NES_L)(a1)
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
	lui	a0, %hi(MEMORY_ADDRESS)
	lw	a0, %lo(MEMORY_ADDRESS)(a0)
	addi	a0, a0, 1068
	lui	a1, %hi(GET_NES_R)
	sw	a0, %lo(GET_NES_R)(a1)
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
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sw	ra, 108(sp)                     # 4-byte Folded Spill
	sw	s0, 104(sp)                     # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 112
	.cfi_def_cfa s0, 0
	li	a0, 20
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	li	a1, 10
	sw	a1, -20(s0)
	li	a1, 100
	sw	a1, -24(s0)
	li	a2, 350
	sw	a2, -28(s0)
	sw	a1, -32(s0)
	li	a1, 2
	sw	a1, -36(s0)
	sb	a0, -37(s0)
	call	_ZN4Hapi4InitEv
	li	a0, 60
	call	_ZN4Hapi12SetTargetFPSEi
	lui	a0, %hi(_ZN11SproutLandsL5WaterE)
	addi	a0, a0, %lo(_ZN11SproutLandsL5WaterE)
	li	a2, 16
	sw	a2, -96(s0)                     # 4-byte Folded Spill
	mv	a1, a2
	call	_ZN4Hapi9LoadImageEPcii
	lw	a2, -96(s0)                     # 4-byte Folded Reload
	sw	a0, -44(s0)
	lui	a0, %hi(_ZN11SproutLandsL12PiknikbasketE)
	addi	a0, a0, %lo(_ZN11SproutLandsL12PiknikbasketE)
	mv	a1, a2
	call	_ZN4Hapi9LoadImageEPcii
	sw	a0, -48(s0)
	lui	a0, %hi(_ZN11SproutLandsL5BoatsE)
	addi	a0, a0, %lo(_ZN11SproutLandsL5BoatsE)
	li	a1, 48
	li	a2, 32
	call	_ZN4Hapi9LoadImageEPcii
	sw	a0, -52(s0)
	j	.LBB18_1
.LBB18_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB18_2 Depth 2
                                        #       Child Loop BB18_4 Depth 3
                                        #     Child Loop BB18_10 Depth 2
	call	_ZN4Hapi12StartDrawingEv
	addi	a0, s0, -58
	li	a1, 255
	li	a3, 127
	li	a4, 1
	mv	a2, a3
	call	_ZN4Hapi5ColorC1Ehhhb
	lh	a0, -54(s0)
	sh	a0, -64(s0)
	lhu	a0, -56(s0)
	slli	a0, a0, 16
	lhu	a1, -58(s0)
	or	a0, a0, a1
	sw	a0, -68(s0)
	lw	a1, -64(s0)
	lw	a0, -68(s0)
	call	_ZN4Hapi5ClearENS_5ColorE
	li	a0, 0
	sw	a0, -72(s0)
	j	.LBB18_2
.LBB18_2:                               #   Parent Loop BB18_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB18_4 Depth 3
	lw	a1, -72(s0)
	li	a0, 239
	blt	a0, a1, .LBB18_9
	j	.LBB18_3
.LBB18_3:                               #   in Loop: Header=BB18_2 Depth=2
	li	a0, 0
	sw	a0, -76(s0)
	j	.LBB18_4
.LBB18_4:                               #   Parent Loop BB18_1 Depth=1
                                        #     Parent Loop BB18_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	lw	a1, -76(s0)
	li	a0, 399
	blt	a0, a1, .LBB18_7
	j	.LBB18_5
.LBB18_5:                               #   in Loop: Header=BB18_4 Depth=3
	lw	a0, -44(s0)
	lw	a1, -16(s0)
	lw	a3, -76(s0)
	lw	a4, -72(s0)
	li	a2, 0
	li	a6, 16
	li	a7, 48
	mv	a5, a6
	call	_ZN4Hapi4DrawEjiiiiiii
	j	.LBB18_6
.LBB18_6:                               #   in Loop: Header=BB18_4 Depth=3
	lw	a0, -76(s0)
	addi	a0, a0, 16
	sw	a0, -76(s0)
	j	.LBB18_4
.LBB18_7:                               #   in Loop: Header=BB18_2 Depth=2
	j	.LBB18_8
.LBB18_8:                               #   in Loop: Header=BB18_2 Depth=2
	lw	a0, -72(s0)
	addi	a0, a0, 16
	sw	a0, -72(s0)
	j	.LBB18_2
.LBB18_9:                               #   in Loop: Header=BB18_1 Depth=1
	addi	a0, s0, -12
	addi	a1, s0, -16
	li	a2, 16
	li	a3, 48
	sw	a3, -108(s0)                    # 4-byte Folded Spill
	call	_Z15updateAnimationRiS_ii
	lw	a5, -108(s0)                    # 4-byte Folded Reload
	lw	a0, -52(s0)
	lw	a3, -20(s0)
	lw	a4, -24(s0)
	li	a2, 0
	sw	a2, -112(s0)                    # 4-byte Folded Spill
	li	a6, 32
	sw	a6, -104(s0)                    # 4-byte Folded Spill
	li	a7, 144
	sw	a7, -100(s0)                    # 4-byte Folded Spill
	mv	a1, a2
	call	_ZN4Hapi4DrawEjiiiiiii
	lw	a2, -112(s0)                    # 4-byte Folded Reload
	lw	a5, -108(s0)                    # 4-byte Folded Reload
	lw	a6, -104(s0)                    # 4-byte Folded Reload
	lw	a7, -100(s0)                    # 4-byte Folded Reload
	lw	a0, -52(s0)
	lw	a3, -28(s0)
	lw	a4, -32(s0)
	mv	a1, a2
	call	_ZN4Hapi4DrawEjiiiiiii
	lui	a0, %hi(baskets)
	addi	a0, a0, %lo(baskets)
	sw	a0, -80(s0)
	sw	a0, -84(s0)
	addi	a0, a0, 32
	sw	a0, -88(s0)
	j	.LBB18_10
.LBB18_10:                              #   Parent Loop BB18_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a0, -84(s0)
	lw	a1, -88(s0)
	beq	a0, a1, .LBB18_15
	j	.LBB18_11
.LBB18_11:                              #   in Loop: Header=BB18_10 Depth=2
	lw	a0, -84(s0)
	sw	a0, -92(s0)
	lw	a0, -92(s0)
	lbu	a0, 12(a0)
	andi	a0, a0, 1
	beqz	a0, .LBB18_13
	j	.LBB18_12
.LBB18_12:                              #   in Loop: Header=BB18_10 Depth=2
	lw	a0, -48(s0)
	lw	a1, -92(s0)
	lw	a3, 0(a1)
	lw	a4, 4(a1)
	li	a2, 0
	li	a7, 16
	mv	a1, a2
	mv	a5, a7
	mv	a6, a7
	call	_ZN4Hapi4DrawEjiiiiiii
	j	.LBB18_13
.LBB18_13:                              #   in Loop: Header=BB18_10 Depth=2
	j	.LBB18_14
.LBB18_14:                              #   in Loop: Header=BB18_10 Depth=2
	lw	a0, -84(s0)
	addi	a0, a0, 16
	sw	a0, -84(s0)
	j	.LBB18_10
.LBB18_15:                              #   in Loop: Header=BB18_1 Depth=1
	call	_ZN4Hapi10EndDrawingEv
	lui	a0, %hi(GET_NES_START)
	lw	a0, %lo(GET_NES_START)(a0)
	lw	a0, 0(a0)
	bnez	a0, .LBB18_26
	j	.LBB18_16
.LBB18_16:                              #   in Loop: Header=BB18_1 Depth=1
	lui	a0, %hi(GET_NES_SELECT)
	lw	a0, %lo(GET_NES_SELECT)(a0)
	lw	a0, 0(a0)
	bnez	a0, .LBB18_26
	j	.LBB18_17
.LBB18_17:                              #   in Loop: Header=BB18_1 Depth=1
	call	_Z13updateBasketsv
	lw	a2, -36(s0)
	lui	a0, %hi(GET_NES_X)
	lw	a0, %lo(GET_NES_X)(a0)
	lw	a0, 0(a0)
	snez	a3, a0
	lui	a0, %hi(GET_NES_B)
	lw	a0, %lo(GET_NES_B)(a0)
	lw	a0, 0(a0)
	snez	a4, a0
	lui	a0, %hi(GET_NES_Y)
	lw	a0, %lo(GET_NES_Y)(a0)
	lw	a0, 0(a0)
	snez	a5, a0
	lui	a0, %hi(GET_NES_A)
	lw	a0, %lo(GET_NES_A)(a0)
	lw	a0, 0(a0)
	snez	a6, a0
	addi	a0, s0, -20
	addi	a1, s0, -24
	call	_Z8moveBoatRiS_ibbbb
	lw	a2, -36(s0)
	lui	a0, %hi(GET_NES_UP)
	lw	a0, %lo(GET_NES_UP)(a0)
	lw	a0, 0(a0)
	snez	a3, a0
	lui	a0, %hi(GET_NES_DOWN)
	lw	a0, %lo(GET_NES_DOWN)(a0)
	lw	a0, 0(a0)
	snez	a4, a0
	lui	a0, %hi(GET_NES_LEFT)
	lw	a0, %lo(GET_NES_LEFT)(a0)
	lw	a0, 0(a0)
	snez	a5, a0
	lui	a0, %hi(GET_NES_RIGHT)
	lw	a0, %lo(GET_NES_RIGHT)(a0)
	lw	a0, 0(a0)
	snez	a6, a0
	addi	a0, s0, -28
	addi	a1, s0, -32
	call	_Z8moveBoatRiS_ibbbb
	lui	a0, %hi(GET_BUTTON_F1)
	lw	a0, %lo(GET_BUTTON_F1)(a0)
	lw	a0, 0(a0)
	beqz	a0, .LBB18_19
	j	.LBB18_18
.LBB18_18:                              #   in Loop: Header=BB18_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 48
	lw	a1, -24(s0)
	addi	a1, a1, 16
	li	a2, 1
	call	_Z10fireBasketiii
	j	.LBB18_19
.LBB18_19:                              #   in Loop: Header=BB18_1 Depth=1
	lui	a0, %hi(GET_BUTTON_F2)
	lw	a0, %lo(GET_BUTTON_F2)(a0)
	lw	a0, 0(a0)
	beqz	a0, .LBB18_21
	j	.LBB18_20
.LBB18_20:                              #   in Loop: Header=BB18_1 Depth=1
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	addi	a1, a1, 16
	li	a2, -1
	call	_Z10fireBasketiii
	j	.LBB18_21
.LBB18_21:                              #   in Loop: Header=BB18_1 Depth=1
	lui	a0, %hi(GET_NES_R)
	lw	a0, %lo(GET_NES_R)(a0)
	lw	a0, 0(a0)
	beqz	a0, .LBB18_23
	j	.LBB18_22
.LBB18_22:                              #   in Loop: Header=BB18_1 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 48
	lw	a1, -32(s0)
	addi	a1, a1, 16
	li	a2, 1
	call	_Z10fireBasketiii
	j	.LBB18_23
.LBB18_23:                              #   in Loop: Header=BB18_1 Depth=1
	lui	a0, %hi(GET_NES_L)
	lw	a0, %lo(GET_NES_L)(a0)
	lw	a0, 0(a0)
	beqz	a0, .LBB18_25
	j	.LBB18_24
.LBB18_24:                              #   in Loop: Header=BB18_1 Depth=1
	lw	a0, -28(s0)
	lw	a1, -32(s0)
	addi	a1, a1, 16
	li	a2, -1
	call	_Z10fireBasketiii
	j	.LBB18_25
.LBB18_25:                              #   in Loop: Header=BB18_1 Depth=1
	j	.LBB18_26
.LBB18_26:                              #   in Loop: Header=BB18_1 Depth=1
	j	.LBB18_1
.Lfunc_end18:
	.size	_Z4mainv, .Lfunc_end18-_Z4mainv
	.cfi_endproc
                                        # -- End function
	.globl	_Z15updateAnimationRiS_ii       # -- Begin function _Z15updateAnimationRiS_ii
	.p2align	2
	.type	_Z15updateAnimationRiS_ii,@function
_Z15updateAnimationRiS_ii:              # @_Z15updateAnimationRiS_ii
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	addi	a0, a0, -1
	sw	a0, 0(a1)
	bnez	a0, .LBB19_2
	j	.LBB19_1
.LBB19_1:
	lw	a1, -16(s0)
	lw	a0, 0(a1)
	lw	a2, -20(s0)
	add	a0, a0, a2
	lw	a2, -24(s0)
	rem	a0, a0, a2
	sw	a0, 0(a1)
	lw	a1, -12(s0)
	li	a0, 20
	sw	a0, 0(a1)
	j	.LBB19_2
.LBB19_2:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end19:
	.size	_Z15updateAnimationRiS_ii, .Lfunc_end19-_Z15updateAnimationRiS_ii
                                        # -- End function
	.globl	_Z13updateBasketsv              # -- Begin function _Z13updateBasketsv
	.p2align	2
	.type	_Z13updateBasketsv,@function
_Z13updateBasketsv:                     # @_Z13updateBasketsv
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	lui	a0, %hi(baskets)
	addi	a0, a0, %lo(baskets)
	sw	a0, -12(s0)
	sw	a0, -16(s0)
	addi	a0, a0, 32
	sw	a0, -20(s0)
	j	.LBB20_1
.LBB20_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	beq	a0, a1, .LBB20_9
	j	.LBB20_2
.LBB20_2:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a0, -16(s0)
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lbu	a0, 12(a0)
	andi	a0, a0, 1
	beqz	a0, .LBB20_7
	j	.LBB20_3
.LBB20_3:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a1, -24(s0)
	lw	a2, 8(a1)
	lw	a0, 0(a1)
	add	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	lw	a0, 0(a0)
	bltz	a0, .LBB20_5
	j	.LBB20_4
.LBB20_4:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a0, -24(s0)
	lw	a0, 0(a0)
	li	a1, 401
	blt	a0, a1, .LBB20_6
	j	.LBB20_5
.LBB20_5:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a1, -24(s0)
	li	a0, 0
	sb	a0, 12(a1)
	j	.LBB20_6
.LBB20_6:                               #   in Loop: Header=BB20_1 Depth=1
	j	.LBB20_7
.LBB20_7:                               #   in Loop: Header=BB20_1 Depth=1
	j	.LBB20_8
.LBB20_8:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a0, -16(s0)
	addi	a0, a0, 16
	sw	a0, -16(s0)
	j	.LBB20_1
.LBB20_9:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end20:
	.size	_Z13updateBasketsv, .Lfunc_end20-_Z13updateBasketsv
                                        # -- End function
	.globl	_Z8moveBoatRiS_ibbbb            # -- Begin function _Z8moveBoatRiS_ibbbb
	.p2align	2
	.type	_Z8moveBoatRiS_ibbbb,@function
_Z8moveBoatRiS_ibbbb:                   # @_Z8moveBoatRiS_ibbbb
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
                                        # kill: def $x17 killed $x16
                                        # kill: def $x17 killed $x15
                                        # kill: def $x17 killed $x14
                                        # kill: def $x17 killed $x13
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sb	a3, -21(s0)
	sb	a4, -22(s0)
	sb	a5, -23(s0)
	sb	a6, -24(s0)
	lbu	a0, -21(s0)
	andi	a0, a0, 1
	beqz	a0, .LBB21_2
	j	.LBB21_1
.LBB21_1:
	lw	a2, -20(s0)
	lw	a1, -16(s0)
	lw	a0, 0(a1)
	sub	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB21_2
.LBB21_2:
	lbu	a0, -22(s0)
	andi	a0, a0, 1
	beqz	a0, .LBB21_4
	j	.LBB21_3
.LBB21_3:
	lw	a2, -20(s0)
	lw	a1, -16(s0)
	lw	a0, 0(a1)
	add	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB21_4
.LBB21_4:
	lbu	a0, -23(s0)
	andi	a0, a0, 1
	beqz	a0, .LBB21_6
	j	.LBB21_5
.LBB21_5:
	lw	a2, -20(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	sub	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB21_6
.LBB21_6:
	lbu	a0, -24(s0)
	andi	a0, a0, 1
	beqz	a0, .LBB21_8
	j	.LBB21_7
.LBB21_7:
	lw	a2, -20(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	add	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB21_8
.LBB21_8:
	lw	a0, -16(s0)
	lw	a0, 0(a0)
	bgez	a0, .LBB21_10
	j	.LBB21_9
.LBB21_9:
	lw	a1, -16(s0)
	li	a0, 0
	sw	a0, 0(a1)
	j	.LBB21_10
.LBB21_10:
	lw	a0, -16(s0)
	lw	a0, 0(a0)
	li	a1, 201
	blt	a0, a1, .LBB21_12
	j	.LBB21_11
.LBB21_11:
	lw	a1, -16(s0)
	li	a0, 200
	sw	a0, 0(a1)
	j	.LBB21_12
.LBB21_12:
	lw	a0, -12(s0)
	lw	a0, 0(a0)
	bgez	a0, .LBB21_14
	j	.LBB21_13
.LBB21_13:
	lw	a1, -12(s0)
	li	a0, 0
	sw	a0, 0(a1)
	j	.LBB21_14
.LBB21_14:
	lw	a0, -12(s0)
	lw	a0, 0(a0)
	li	a1, 353
	blt	a0, a1, .LBB21_16
	j	.LBB21_15
.LBB21_15:
	lw	a1, -12(s0)
	li	a0, 352
	sw	a0, 0(a1)
	j	.LBB21_16
.LBB21_16:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end21:
	.size	_Z8moveBoatRiS_ibbbb, .Lfunc_end21-_Z8moveBoatRiS_ibbbb
                                        # -- End function
	.globl	_Z10fireBasketiii               # -- Begin function _Z10fireBasketiii
	.p2align	2
	.type	_Z10fireBasketiii,@function
_Z10fireBasketiii:                      # @_Z10fireBasketiii
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 64
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lui	a0, %hi(baskets)
	addi	a0, a0, %lo(baskets)
	sw	a0, -24(s0)
	sw	a0, -28(s0)
	addi	a0, a0, 32
	sw	a0, -32(s0)
	j	.LBB22_1
.LBB22_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -28(s0)
	lw	a1, -32(s0)
	beq	a0, a1, .LBB22_6
	j	.LBB22_2
.LBB22_2:                               #   in Loop: Header=BB22_1 Depth=1
	lw	a0, -28(s0)
	sw	a0, -36(s0)
	lw	a0, -36(s0)
	lbu	a0, 12(a0)
	andi	a0, a0, 1
	bnez	a0, .LBB22_4
	j	.LBB22_3
.LBB22_3:
	lw	a0, -12(s0)
	sw	a0, -52(s0)
	lw	a0, -16(s0)
	sw	a0, -48(s0)
	lw	a0, -20(s0)
	sw	a0, -44(s0)
	li	a0, 1
	sb	a0, -40(s0)
	lw	a1, -36(s0)
	lw	a0, -40(s0)
	sw	a0, 12(a1)
	lw	a0, -44(s0)
	sw	a0, 8(a1)
	lw	a0, -48(s0)
	sw	a0, 4(a1)
	lw	a0, -52(s0)
	sw	a0, 0(a1)
	j	.LBB22_6
.LBB22_4:                               #   in Loop: Header=BB22_1 Depth=1
	j	.LBB22_5
.LBB22_5:                               #   in Loop: Header=BB22_1 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 16
	sw	a0, -28(s0)
	j	.LBB22_1
.LBB22_6:
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end22:
	.size	_Z10fireBasketiii, .Lfunc_end22-_Z10fireBasketiii
                                        # -- End function
	.p2align	2                               # -- Begin function _GLOBAL__sub_I_main.cpp
	.type	_GLOBAL__sub_I_main.cpp,@function
_GLOBAL__sub_I_main.cpp:                # @_GLOBAL__sub_I_main.cpp
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
.Lfunc_end23:
	.size	_GLOBAL__sub_I_main.cpp, .Lfunc_end23-_GLOBAL__sub_I_main.cpp
	.cfi_endproc
                                        # -- End function
	.type	MEMORY_ADDRESS,@object          # @MEMORY_ADDRESS
	.data
	.globl	MEMORY_ADDRESS
	.p2align	2, 0x0
MEMORY_ADDRESS:
	.word	24576
	.size	MEMORY_ADDRESS, 4

	.type	GET_BUTTON_F1,@object           # @GET_BUTTON_F1
	.bss
	.globl	GET_BUTTON_F1
	.p2align	2, 0x0
GET_BUTTON_F1:
	.word	0
	.size	GET_BUTTON_F1, 4

	.type	GET_BUTTON_F2,@object           # @GET_BUTTON_F2
	.globl	GET_BUTTON_F2
	.p2align	2, 0x0
GET_BUTTON_F2:
	.word	0
	.size	GET_BUTTON_F2, 4

	.type	GET_BUTTON_UP,@object           # @GET_BUTTON_UP
	.globl	GET_BUTTON_UP
	.p2align	2, 0x0
GET_BUTTON_UP:
	.word	0
	.size	GET_BUTTON_UP, 4

	.type	GET_BUTTON_DOWN,@object         # @GET_BUTTON_DOWN
	.globl	GET_BUTTON_DOWN
	.p2align	2, 0x0
GET_BUTTON_DOWN:
	.word	0
	.size	GET_BUTTON_DOWN, 4

	.type	GET_BUTTON_LEFT,@object         # @GET_BUTTON_LEFT
	.globl	GET_BUTTON_LEFT
	.p2align	2, 0x0
GET_BUTTON_LEFT:
	.word	0
	.size	GET_BUTTON_LEFT, 4

	.type	GET_BUTTON_RIGHT,@object        # @GET_BUTTON_RIGHT
	.globl	GET_BUTTON_RIGHT
	.p2align	2, 0x0
GET_BUTTON_RIGHT:
	.word	0
	.size	GET_BUTTON_RIGHT, 4

	.type	GET_NES_B,@object               # @GET_NES_B
	.globl	GET_NES_B
	.p2align	2, 0x0
GET_NES_B:
	.word	0
	.size	GET_NES_B, 4

	.type	GET_NES_Y,@object               # @GET_NES_Y
	.globl	GET_NES_Y
	.p2align	2, 0x0
GET_NES_Y:
	.word	0
	.size	GET_NES_Y, 4

	.type	GET_NES_SELECT,@object          # @GET_NES_SELECT
	.globl	GET_NES_SELECT
	.p2align	2, 0x0
GET_NES_SELECT:
	.word	0
	.size	GET_NES_SELECT, 4

	.type	GET_NES_START,@object           # @GET_NES_START
	.globl	GET_NES_START
	.p2align	2, 0x0
GET_NES_START:
	.word	0
	.size	GET_NES_START, 4

	.type	GET_NES_UP,@object              # @GET_NES_UP
	.globl	GET_NES_UP
	.p2align	2, 0x0
GET_NES_UP:
	.word	0
	.size	GET_NES_UP, 4

	.type	GET_NES_DOWN,@object            # @GET_NES_DOWN
	.globl	GET_NES_DOWN
	.p2align	2, 0x0
GET_NES_DOWN:
	.word	0
	.size	GET_NES_DOWN, 4

	.type	GET_NES_LEFT,@object            # @GET_NES_LEFT
	.globl	GET_NES_LEFT
	.p2align	2, 0x0
GET_NES_LEFT:
	.word	0
	.size	GET_NES_LEFT, 4

	.type	GET_NES_RIGHT,@object           # @GET_NES_RIGHT
	.globl	GET_NES_RIGHT
	.p2align	2, 0x0
GET_NES_RIGHT:
	.word	0
	.size	GET_NES_RIGHT, 4

	.type	GET_NES_A,@object               # @GET_NES_A
	.globl	GET_NES_A
	.p2align	2, 0x0
GET_NES_A:
	.word	0
	.size	GET_NES_A, 4

	.type	GET_NES_X,@object               # @GET_NES_X
	.globl	GET_NES_X
	.p2align	2, 0x0
GET_NES_X:
	.word	0
	.size	GET_NES_X, 4

	.type	GET_NES_L,@object               # @GET_NES_L
	.globl	GET_NES_L
	.p2align	2, 0x0
GET_NES_L:
	.word	0
	.size	GET_NES_L, 4

	.type	GET_NES_R,@object               # @GET_NES_R
	.globl	GET_NES_R
	.p2align	2, 0x0
GET_NES_R:
	.word	0
	.size	GET_NES_R, 4

	.type	baskets,@object                 # @baskets
	.globl	baskets
	.p2align	2, 0x0
baskets:
	.zero	32
	.size	baskets, 32

	.type	_ZN11SproutLandsL5WaterE,@object # @_ZN11SproutLandsL5WaterE
	.section	.rodata,"a",@progbits
	.p2align	1, 0x0
_ZN11SproutLandsL5WaterE:
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	46895                           # 0xb72f
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.half	40625                           # 0x9eb1
	.size	_ZN11SproutLandsL5WaterE, 2048

	.type	_ZN11SproutLandsL12PiknikbasketE,@object # @_ZN11SproutLandsL12PiknikbasketE
	.p2align	1, 0x0
_ZN11SproutLandsL12PiknikbasketE:
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	0                               # 0x0
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	0                               # 0x0
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	50395                           # 0xc4db
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	50395                           # 0xc4db
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	61033                           # 0xee69
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	18978                           # 0x4a22
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	18978                           # 0x4a22
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	18978                           # 0x4a22
	.half	0                               # 0x0
	.half	0                               # 0x0
	.size	_ZN11SproutLandsL12PiknikbasketE, 512

	.type	_ZN11SproutLandsL5BoatsE,@object # @_ZN11SproutLandsL5BoatsE
	.p2align	1, 0x0
_ZN11SproutLandsL5BoatsE:
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	46169                           # 0xb459
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	46169                           # 0xb459
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	46169                           # 0xb459
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	46169                           # 0xb459
	.half	46169                           # 0xb459
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	37655                           # 0x9317
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	37655                           # 0x9317
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	37655                           # 0x9317
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	37655                           # 0x9317
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	43991                           # 0xabd7
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	37655                           # 0x9317
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	37655                           # 0x9317
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	37655                           # 0x9317
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	56803                           # 0xdde3
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	37655                           # 0x9317
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	50395                           # 0xc4db
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.half	63417                           # 0xf7b9
	.zero	1470
	.size	_ZN11SproutLandsL5BoatsE, 9216

	.section	.init_array,"aw",@init_array
	.p2align	2, 0x0
	.word	_GLOBAL__sub_I_main.cpp
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
	.addrsig_sym _ZN4Hapi4InitEv
	.addrsig_sym _ZN4Hapi12SetTargetFPSEi
	.addrsig_sym _ZN4Hapi9LoadImageEPcii
	.addrsig_sym _ZN4Hapi12StartDrawingEv
	.addrsig_sym _ZN4Hapi5ClearENS_5ColorE
	.addrsig_sym _ZN4Hapi4DrawEjiiiiiii
	.addrsig_sym _Z15updateAnimationRiS_ii
	.addrsig_sym _ZN4Hapi10EndDrawingEv
	.addrsig_sym _Z13updateBasketsv
	.addrsig_sym _Z8moveBoatRiS_ibbbb
	.addrsig_sym _Z10fireBasketiii
	.addrsig_sym _GLOBAL__sub_I_main.cpp
	.addrsig_sym MEMORY_ADDRESS
	.addrsig_sym GET_BUTTON_F1
	.addrsig_sym GET_BUTTON_F2
	.addrsig_sym GET_BUTTON_UP
	.addrsig_sym GET_BUTTON_DOWN
	.addrsig_sym GET_BUTTON_LEFT
	.addrsig_sym GET_BUTTON_RIGHT
	.addrsig_sym GET_NES_B
	.addrsig_sym GET_NES_Y
	.addrsig_sym GET_NES_SELECT
	.addrsig_sym GET_NES_START
	.addrsig_sym GET_NES_UP
	.addrsig_sym GET_NES_DOWN
	.addrsig_sym GET_NES_LEFT
	.addrsig_sym GET_NES_RIGHT
	.addrsig_sym GET_NES_A
	.addrsig_sym GET_NES_X
	.addrsig_sym GET_NES_L
	.addrsig_sym GET_NES_R
	.addrsig_sym baskets
	.addrsig_sym _ZN11SproutLandsL5WaterE
	.addrsig_sym _ZN11SproutLandsL12PiknikbasketE
	.addrsig_sym _ZN11SproutLandsL5BoatsE
