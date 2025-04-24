	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"main.cpp"
	.text
	.globl	_Z4mainv                        # -- Begin function _Z4mainv
	.p2align	2
	.type	_Z4mainv,@function
_Z4mainv:                               # @_Z4mainv
# %bb.0:
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	j	.LBB0_1
.Lfunc_end0:
	.size	_Z4mainv, .Lfunc_end0-_Z4mainv
                                        # -- End function
	.type	MEMORY_ADDRESS,@object          # @MEMORY_ADDRESS
	.data
	.globl	MEMORY_ADDRESS
	.p2align	2, 0x0
MEMORY_ADDRESS:
	.word	24576
	.size	MEMORY_ADDRESS, 4

	.type	GET_BUTTON_F1,@object           # @GET_BUTTON_F1
	.globl	GET_BUTTON_F1
	.p2align	2, 0x0
GET_BUTTON_F1:
	.word	25088
	.size	GET_BUTTON_F1, 4

	.type	GET_BUTTON_F2,@object           # @GET_BUTTON_F2
	.globl	GET_BUTTON_F2
	.p2align	2, 0x0
GET_BUTTON_F2:
	.word	25092
	.size	GET_BUTTON_F2, 4

	.type	GET_BUTTON_UP,@object           # @GET_BUTTON_UP
	.globl	GET_BUTTON_UP
	.p2align	2, 0x0
GET_BUTTON_UP:
	.word	25096
	.size	GET_BUTTON_UP, 4

	.type	GET_BUTTON_DOWN,@object         # @GET_BUTTON_DOWN
	.globl	GET_BUTTON_DOWN
	.p2align	2, 0x0
GET_BUTTON_DOWN:
	.word	25100
	.size	GET_BUTTON_DOWN, 4

	.type	GET_BUTTON_LEFT,@object         # @GET_BUTTON_LEFT
	.globl	GET_BUTTON_LEFT
	.p2align	2, 0x0
GET_BUTTON_LEFT:
	.word	25104
	.size	GET_BUTTON_LEFT, 4

	.type	GET_BUTTON_RIGHT,@object        # @GET_BUTTON_RIGHT
	.globl	GET_BUTTON_RIGHT
	.p2align	2, 0x0
GET_BUTTON_RIGHT:
	.word	25108
	.size	GET_BUTTON_RIGHT, 4

	.type	GET_NES_B,@object               # @GET_NES_B
	.globl	GET_NES_B
	.p2align	2, 0x0
GET_NES_B:
	.word	25600
	.size	GET_NES_B, 4

	.type	GET_NES_Y,@object               # @GET_NES_Y
	.globl	GET_NES_Y
	.p2align	2, 0x0
GET_NES_Y:
	.word	25604
	.size	GET_NES_Y, 4

	.type	GET_NES_SELECT,@object          # @GET_NES_SELECT
	.globl	GET_NES_SELECT
	.p2align	2, 0x0
GET_NES_SELECT:
	.word	25608
	.size	GET_NES_SELECT, 4

	.type	GET_NES_START,@object           # @GET_NES_START
	.globl	GET_NES_START
	.p2align	2, 0x0
GET_NES_START:
	.word	25612
	.size	GET_NES_START, 4

	.type	GET_NES_UP,@object              # @GET_NES_UP
	.globl	GET_NES_UP
	.p2align	2, 0x0
GET_NES_UP:
	.word	25616
	.size	GET_NES_UP, 4

	.type	GET_NES_DOWN,@object            # @GET_NES_DOWN
	.globl	GET_NES_DOWN
	.p2align	2, 0x0
GET_NES_DOWN:
	.word	25620
	.size	GET_NES_DOWN, 4

	.type	GET_NES_LEFT,@object            # @GET_NES_LEFT
	.globl	GET_NES_LEFT
	.p2align	2, 0x0
GET_NES_LEFT:
	.word	25624
	.size	GET_NES_LEFT, 4

	.type	GET_NES_RIGHT,@object           # @GET_NES_RIGHT
	.globl	GET_NES_RIGHT
	.p2align	2, 0x0
GET_NES_RIGHT:
	.word	25628
	.size	GET_NES_RIGHT, 4

	.type	GET_NES_A,@object               # @GET_NES_A
	.globl	GET_NES_A
	.p2align	2, 0x0
GET_NES_A:
	.word	25632
	.size	GET_NES_A, 4

	.type	GET_NES_X,@object               # @GET_NES_X
	.globl	GET_NES_X
	.p2align	2, 0x0
GET_NES_X:
	.word	25636
	.size	GET_NES_X, 4

	.type	GET_NES_L,@object               # @GET_NES_L
	.globl	GET_NES_L
	.p2align	2, 0x0
GET_NES_L:
	.word	25640
	.size	GET_NES_L, 4

	.type	GET_NES_R,@object               # @GET_NES_R
	.globl	GET_NES_R
	.p2align	2, 0x0
GET_NES_R:
	.word	25644
	.size	GET_NES_R, 4

	.type	baskets,@object                 # @baskets
	.bss
	.globl	baskets
	.p2align	2, 0x0
baskets:
	.zero	32
	.size	baskets, 32

	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project 179d30f8c3fddd3c85056fd2b8e877a4a8513158)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
