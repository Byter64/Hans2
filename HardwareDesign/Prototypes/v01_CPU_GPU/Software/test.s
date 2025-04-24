	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"test.cpp"
	.text
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
# %bb.0:
	lui	a0, %hi(number)
	lw	a0, %lo(number)(a0)
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	lw	a1, 0(a0)
	addi	a1, a1, 3
	sw	a1, 0(a0)
	j	.LBB0_1
.Lfunc_end0:
	.size	_Z4mainv, .Lfunc_end0-_Z4mainv
                                        # -- End function
	.type	number,@object                  # @number
	.data
	.globl	number
	.p2align	2, 0x0
number:
	.word	34
	.size	number, 4

	.type	test,@object                    # @test
	.globl	test
test:
	.asciz	"Hallo Welt!\000\000\000\000\000\000\000\000\000\000\000"
	.size	test, 23

	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
