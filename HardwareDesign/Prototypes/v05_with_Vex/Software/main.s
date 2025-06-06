	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"main.cpp"
	.text
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
# %bb.0:
	li	a0, 0
	lui	a1, 16
	li	a2, 512
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	sh	a0, 0(a1)
	addi	a0, a0, 1
	addi	a1, a1, 2
	bne	a0, a2, .LBB0_1
# %bb.2:
	lui	a0, %hi(x)
	lw	a0, %lo(x)(a0)
	lui	a1, 16
	addi	a2, a1, 1024
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	lh	a3, 0(a1)
	addi	a1, a1, 2
	sh	a3, 0(a0)
	bne	a1, a2, .LBB0_3
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	j	.LBB0_4
.Lfunc_end0:
	.size	_Z4mainv, .Lfunc_end0-_Z4mainv
                                        # -- End function
	.globl	_Z15updateAnimationRiS_ii       # -- Begin function _Z15updateAnimationRiS_ii
	.p2align	2
	.type	_Z15updateAnimationRiS_ii,@function
_Z15updateAnimationRiS_ii:              # @_Z15updateAnimationRiS_ii
# %bb.0:
	lw	a4, 0(a0)
	addi	a4, a4, -1
	sw	a4, 0(a0)
	beqz	a4, .LBB1_2
# %bb.1:
	ret
.LBB1_2:
	lw	a4, 0(a1)
	add	a2, a4, a2
	rem	a2, a2, a3
	li	a3, 20
	sw	a2, 0(a1)
	sw	a3, 0(a0)
	ret
.Lfunc_end1:
	.size	_Z15updateAnimationRiS_ii, .Lfunc_end1-_Z15updateAnimationRiS_ii
                                        # -- End function
	.type	test1,@object                   # @test1
	.data
	.globl	test1
	.p2align	1, 0x0
test1:
	.half	1                               # 0x1
	.half	65535                           # 0xffff
	.half	1                               # 0x1
	.half	65535                           # 0xffff
	.half	1                               # 0x1
	.half	65535                           # 0xffff
	.half	1                               # 0x1
	.half	65535                           # 0xffff
	.size	test1, 16

	.type	test2,@object                   # @test2
	.globl	test2
	.p2align	1, 0x0
test2:
	.half	65535                           # 0xffff
	.half	1                               # 0x1
	.half	65535                           # 0xffff
	.half	1                               # 0x1
	.half	65535                           # 0xffff
	.half	1                               # 0x1
	.half	65535                           # 0xffff
	.half	1                               # 0x1
	.size	test2, 16

	.type	test3,@object                   # @test3
	.globl	test3
	.p2align	1, 0x0
test3:
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.half	1                               # 0x1
	.size	test3, 16

	.type	test4,@object                   # @test4
	.globl	test4
	.p2align	1, 0x0
test4:
	.zero	16,255
	.size	test4, 16

	.type	x,@object                       # @x
	.globl	x
	.p2align	2, 0x0
x:
	.word	33652732
	.size	x, 4

	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
