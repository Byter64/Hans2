	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"test.c"
	.text
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
# %bb.0:
	lui	a0, %hi(test)
	lw	a0, %lo(test)(a0)
	lbu	a1, 0(a0)
	beqz	a1, .LBB0_3
# %bb.1:
	addi	a0, a0, 1
	lui	a1, %hi(testa)
	addi	a1, a1, %lo(testa)
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	lbu	a2, -1(a0)
	addi	a2, a2, 1
	sb	a2, 0(a1)
	lbu	a2, 0(a0)
	addi	a0, a0, 1
	addi	a1, a1, 1
	bnez	a2, .LBB0_2
.LBB0_3:
	li	a0, 0
	ret
.Lfunc_end0:
	.size	_Z4mainv, .Lfunc_end0-_Z4mainv
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Hallo Welt adwadaw!"
	.size	.L.str, 20

	.type	test,@object                    # @test
	.data
	.globl	test
	.p2align	2, 0x0
test:
	.word	.L.str
	.size	test, 4

	.type	testa,@object                   # @testa
	.bss
	.globl	testa
testa:
	.zero	20
	.size	testa, 20

	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym testa
