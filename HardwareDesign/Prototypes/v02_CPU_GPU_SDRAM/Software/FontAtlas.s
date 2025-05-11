	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"FontAtlas.cpp"
	.text
	.globl	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE # -- Begin function _ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
	.p2align	2
	.type	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE,@function
_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE: # @_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
# %bb.0:
	lw	a3, 12(a2)
	slli	a1, a1, 4
	add	a0, a0, a1
	sw	a3, 12(a0)
	lw	a1, 8(a2)
	sw	a1, 8(a0)
	lw	a1, 4(a2)
	sw	a1, 4(a0)
	lw	a1, 0(a2)
	sw	a1, 0(a0)
	ret
.Lfunc_end0:
	.size	_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE, .Lfunc_end0-_ZN4Hapi9FontAtlas3AddEcNS_9RectangleE
                                        # -- End function
	.globl	_ZN4Hapi9FontAtlasixEc          # -- Begin function _ZN4Hapi9FontAtlasixEc
	.p2align	2
	.type	_ZN4Hapi9FontAtlasixEc,@function
_ZN4Hapi9FontAtlasixEc:                 # @_ZN4Hapi9FontAtlasixEc
# %bb.0:
	slli	a1, a1, 4
	add	a0, a0, a1
	ret
.Lfunc_end1:
	.size	_ZN4Hapi9FontAtlasixEc, .Lfunc_end1-_ZN4Hapi9FontAtlasixEc
                                        # -- End function
	.ident	"clang version 21.0.0git"
	.section	".note.GNU-stack","",@progbits
	.addrsig
