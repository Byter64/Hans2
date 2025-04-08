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
.Lfunc_end2:
	.size	__cxx_global_var_init.2, .Lfunc_end2-__cxx_global_var_init.2
	.cfi_endproc
                                        # -- End function
	.globl	_start                          # -- Begin function _start
	.p2align	2
	.type	_start,@function
_start:                                 # @_start
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
	lui	a0, %hi(_etext)
	addi	a0, a0, %lo(_etext)
	sw	a0, -12(s0)
	lui	a0, %hi(_sdata)
	addi	a0, a0, %lo(_sdata)
	sw	a0, -16(s0)
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	beq	a0, a1, .LBB3_5
	j	.LBB3_1
.LBB3_1:
	j	.LBB3_2
.LBB3_2:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -16(s0)
	lui	a1, %hi(_edata)
	addi	a1, a1, %lo(_edata)
	bgeu	a0, a1, .LBB3_4
	j	.LBB3_3
.LBB3_3:                                #   in Loop: Header=BB3_2 Depth=1
	lw	a0, -12(s0)
	addi	a1, a0, 4
	sw	a1, -12(s0)
	lw	a0, 0(a0)
	lw	a1, -16(s0)
	addi	a2, a1, 4
	sw	a2, -16(s0)
	sw	a0, 0(a1)
	j	.LBB3_2
.LBB3_4:
	j	.LBB3_5
.LBB3_5:
	lui	a0, %hi(_sbss)
	addi	a0, a0, %lo(_sbss)
	sw	a0, -20(s0)
	j	.LBB3_6
.LBB3_6:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
	lui	a1, %hi(_ebss)
	addi	a1, a1, %lo(_ebss)
	bgeu	a0, a1, .LBB3_8
	j	.LBB3_7
.LBB3_7:                                #   in Loop: Header=BB3_6 Depth=1
	lw	a1, -20(s0)
	addi	a0, a1, 4
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, 0(a1)
	j	.LBB3_6
.LBB3_8:
	call	_Z4mainv
	j	.LBB3_9
.LBB3_9:                                # =>This Inner Loop Header: Depth=1
	j	.LBB3_9
.Lfunc_end3:
	.size	_start, .Lfunc_end3-_start
	.cfi_endproc
                                        # -- End function
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	lui	a0, %hi(GPU_CLEAR_COLOR)
	lw	a1, %lo(GPU_CLEAR_COLOR)(a0)
	li	a0, 2047
	sw	a0, 0(a1)
	lui	a0, %hi(GPU_COMMAND_CLEAR)
	lw	a1, %lo(GPU_COMMAND_CLEAR)(a0)
	li	a0, 1
	sw	a0, 0(a1)
	lui	a0, %hi(GPU_IS_BUSY)
	lw	a0, %lo(GPU_IS_BUSY)(a0)
	sw	a0, -12(s0)
	j	.LBB4_1
.LBB4_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_2 Depth 2
	j	.LBB4_2
.LBB4_2:                                #   Parent Loop BB4_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a0, -12(s0)
	lw	a0, 0(a0)
	beqz	a0, .LBB4_4
	j	.LBB4_3
.LBB4_3:                                #   in Loop: Header=BB4_2 Depth=2
	j	.LBB4_2
.LBB4_4:                                #   in Loop: Header=BB4_1 Depth=1
	lui	a0, %hi(GPU_COMMAND_CLEAR)
	lw	a1, %lo(GPU_COMMAND_CLEAR)(a0)
	li	a0, 1
	sw	a0, 0(a1)
	j	.LBB4_1
.Lfunc_end4:
	.size	_Z4mainv, .Lfunc_end4-_Z4mainv
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
	.cfi_def_cfa sp, 16
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	_GLOBAL__sub_I_main.cpp, .Lfunc_end5-_GLOBAL__sub_I_main.cpp
	.cfi_endproc
                                        # -- End function
	.type	GPU_BLOCK,@object               # @GPU_BLOCK
	.data
	.globl	GPU_BLOCK
	.p2align	2, 0x0
GPU_BLOCK:
	.word	32768
	.size	GPU_BLOCK, 4

	.type	GPU_IS_BUSY,@object             # @GPU_IS_BUSY
	.bss
	.globl	GPU_IS_BUSY
	.p2align	2, 0x0
GPU_IS_BUSY:
	.word	0
	.size	GPU_IS_BUSY, 4

	.type	GPU_COMMAND_CLEAR,@object       # @GPU_COMMAND_CLEAR
	.globl	GPU_COMMAND_CLEAR
	.p2align	2, 0x0
GPU_COMMAND_CLEAR:
	.word	0
	.size	GPU_COMMAND_CLEAR, 4

	.type	GPU_CLEAR_COLOR,@object         # @GPU_CLEAR_COLOR
	.globl	GPU_CLEAR_COLOR
	.p2align	2, 0x0
GPU_CLEAR_COLOR:
	.word	0
	.size	GPU_CLEAR_COLOR, 4

	.section	.init_array,"aw",@init_array
	.p2align	2, 0x0
	.word	_GLOBAL__sub_I_main.cpp
	.ident	"clang version 21.0.0git"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __cxx_global_var_init
	.addrsig_sym __cxx_global_var_init.1
	.addrsig_sym __cxx_global_var_init.2
	.addrsig_sym _Z4mainv
	.addrsig_sym _GLOBAL__sub_I_main.cpp
	.addrsig_sym GPU_BLOCK
	.addrsig_sym GPU_IS_BUSY
	.addrsig_sym GPU_COMMAND_CLEAR
	.addrsig_sym GPU_CLEAR_COLOR
	.addrsig_sym _etext
	.addrsig_sym _sdata
	.addrsig_sym _edata
	.addrsig_sym _sbss
	.addrsig_sym _ebss
