	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"Color.cpp"
	.text
	.globl	_ZN4Hapi5ColorC2Ehhhb           # -- Begin function _ZN4Hapi5ColorC2Ehhhb
	.p2align	2
	.type	_ZN4Hapi5ColorC2Ehhhb,@function
_ZN4Hapi5ColorC2Ehhhb:                  # @_ZN4Hapi5ColorC2Ehhhb
# %bb.0:
	srli	a5, a1, 3
	slli	a6, a2, 3
	slli	a5, a5, 11
	andi	a6, a6, 1984
	or	a5, a6, a5
	srli	a6, a3, 2
	andi	a6, a6, 62
	or	a6, a6, a4
	or	a5, a5, a6
	sh	a5, 0(a0)
	sb	a1, 2(a0)
	sb	a2, 3(a0)
	sb	a3, 4(a0)
	sb	a4, 5(a0)
	ret
.Lfunc_end0:
	.size	_ZN4Hapi5ColorC2Ehhhb, .Lfunc_end0-_ZN4Hapi5ColorC2Ehhhb
                                        # -- End function
	.globl	_ZN4Hapi5Color8SetColorEhhhb    # -- Begin function _ZN4Hapi5Color8SetColorEhhhb
	.p2align	2
	.type	_ZN4Hapi5Color8SetColorEhhhb,@function
_ZN4Hapi5Color8SetColorEhhhb:           # @_ZN4Hapi5Color8SetColorEhhhb
# %bb.0:
	srli	a5, a1, 3
	slli	a6, a2, 3
	slli	a5, a5, 11
	andi	a6, a6, 1984
	or	a5, a5, a6
	srli	a6, a3, 2
	andi	a6, a6, 62
	or	a6, a6, a4
	or	a5, a5, a6
	sh	a5, 0(a0)
	sb	a1, 2(a0)
	sb	a2, 3(a0)
	sb	a3, 4(a0)
	sb	a4, 5(a0)
	ret
.Lfunc_end1:
	.size	_ZN4Hapi5Color8SetColorEhhhb, .Lfunc_end1-_ZN4Hapi5Color8SetColorEhhhb
                                        # -- End function
	.globl	_ZN4Hapi5Color6SetRedEh         # -- Begin function _ZN4Hapi5Color6SetRedEh
	.p2align	2
	.type	_ZN4Hapi5Color6SetRedEh,@function
_ZN4Hapi5Color6SetRedEh:                # @_ZN4Hapi5Color6SetRedEh
# %bb.0:
	lhu	a2, 0(a0)
	srli	a3, a1, 3
	slli	a3, a3, 11
	andi	a2, a2, 2047
	or	a2, a2, a3
	sh	a2, 0(a0)
	sb	a1, 2(a0)
	ret
.Lfunc_end2:
	.size	_ZN4Hapi5Color6SetRedEh, .Lfunc_end2-_ZN4Hapi5Color6SetRedEh
                                        # -- End function
	.globl	_ZN4Hapi5Color8SetGreenEh       # -- Begin function _ZN4Hapi5Color8SetGreenEh
	.p2align	2
	.type	_ZN4Hapi5Color8SetGreenEh,@function
_ZN4Hapi5Color8SetGreenEh:              # @_ZN4Hapi5Color8SetGreenEh
# %bb.0:
	lhu	a2, 0(a0)
	slli	a3, a1, 3
	andi	a3, a3, 1984
	andi	a2, a2, -1985
	or	a2, a2, a3
	sh	a2, 0(a0)
	sb	a1, 3(a0)
	ret
.Lfunc_end3:
	.size	_ZN4Hapi5Color8SetGreenEh, .Lfunc_end3-_ZN4Hapi5Color8SetGreenEh
                                        # -- End function
	.globl	_ZN4Hapi5Color7SetBlueEh        # -- Begin function _ZN4Hapi5Color7SetBlueEh
	.p2align	2
	.type	_ZN4Hapi5Color7SetBlueEh,@function
_ZN4Hapi5Color7SetBlueEh:               # @_ZN4Hapi5Color7SetBlueEh
# %bb.0:
	lhu	a2, 0(a0)
	srli	a3, a1, 2
	andi	a3, a3, 62
	andi	a2, a2, -63
	or	a2, a2, a3
	sh	a2, 0(a0)
	sb	a1, 4(a0)
	ret
.Lfunc_end4:
	.size	_ZN4Hapi5Color7SetBlueEh, .Lfunc_end4-_ZN4Hapi5Color7SetBlueEh
                                        # -- End function
	.globl	_ZN4Hapi5Color8SetAlphaEb       # -- Begin function _ZN4Hapi5Color8SetAlphaEb
	.p2align	2
	.type	_ZN4Hapi5Color8SetAlphaEb,@function
_ZN4Hapi5Color8SetAlphaEb:              # @_ZN4Hapi5Color8SetAlphaEb
# %bb.0:
	lhu	a2, 0(a0)
	andi	a2, a2, -2
	or	a2, a2, a1
	sh	a2, 0(a0)
	sb	a1, 5(a0)
	ret
.Lfunc_end5:
	.size	_ZN4Hapi5Color8SetAlphaEb, .Lfunc_end5-_ZN4Hapi5Color8SetAlphaEb
                                        # -- End function
	.globl	_ZN4Hapi5Color8SetColorEhhh     # -- Begin function _ZN4Hapi5Color8SetColorEhhh
	.p2align	2
	.type	_ZN4Hapi5Color8SetColorEhhh,@function
_ZN4Hapi5Color8SetColorEhhh:            # @_ZN4Hapi5Color8SetColorEhhh
# %bb.0:
	lhu	a4, 0(a0)
	srli	a5, a1, 3
	slli	a6, a2, 3
	slli	a5, a5, 11
	andi	a6, a6, 1984
	or	a5, a5, a6
	srli	a6, a3, 2
	andi	a6, a6, 62
	or	a5, a5, a6
	andi	a4, a4, 1
	or	a4, a4, a5
	sh	a4, 0(a0)
	sb	a1, 2(a0)
	sb	a2, 3(a0)
	sb	a3, 4(a0)
	ret
.Lfunc_end6:
	.size	_ZN4Hapi5Color8SetColorEhhh, .Lfunc_end6-_ZN4Hapi5Color8SetColorEhhh
                                        # -- End function
	.globl	_ZN4Hapi5Color10SetColor16Et    # -- Begin function _ZN4Hapi5Color10SetColor16Et
	.p2align	2
	.type	_ZN4Hapi5Color10SetColor16Et,@function
_ZN4Hapi5Color10SetColor16Et:           # @_ZN4Hapi5Color10SetColor16Et
# %bb.0:
	srli	a2, a1, 8
	srli	a3, a1, 3
	slli	a4, a1, 2
	andi	a5, a1, 1
	andi	a2, a2, 248
	andi	a3, a3, 248
	andi	a4, a4, 248
	sh	a1, 0(a0)
	sb	a2, 2(a0)
	sb	a3, 3(a0)
	sb	a4, 4(a0)
	sb	a5, 5(a0)
	ret
.Lfunc_end7:
	.size	_ZN4Hapi5Color10SetColor16Et, .Lfunc_end7-_ZN4Hapi5Color10SetColor16Et
                                        # -- End function
	.globl	_ZN4Hapi5Color6GetRedEv         # -- Begin function _ZN4Hapi5Color6GetRedEv
	.p2align	2
	.type	_ZN4Hapi5Color6GetRedEv,@function
_ZN4Hapi5Color6GetRedEv:                # @_ZN4Hapi5Color6GetRedEv
# %bb.0:
	lbu	a0, 2(a0)
	ret
.Lfunc_end8:
	.size	_ZN4Hapi5Color6GetRedEv, .Lfunc_end8-_ZN4Hapi5Color6GetRedEv
                                        # -- End function
	.globl	_ZN4Hapi5Color8GetGreenEv       # -- Begin function _ZN4Hapi5Color8GetGreenEv
	.p2align	2
	.type	_ZN4Hapi5Color8GetGreenEv,@function
_ZN4Hapi5Color8GetGreenEv:              # @_ZN4Hapi5Color8GetGreenEv
# %bb.0:
	lbu	a0, 3(a0)
	ret
.Lfunc_end9:
	.size	_ZN4Hapi5Color8GetGreenEv, .Lfunc_end9-_ZN4Hapi5Color8GetGreenEv
                                        # -- End function
	.globl	_ZN4Hapi5Color7GetBlueEv        # -- Begin function _ZN4Hapi5Color7GetBlueEv
	.p2align	2
	.type	_ZN4Hapi5Color7GetBlueEv,@function
_ZN4Hapi5Color7GetBlueEv:               # @_ZN4Hapi5Color7GetBlueEv
# %bb.0:
	lbu	a0, 4(a0)
	ret
.Lfunc_end10:
	.size	_ZN4Hapi5Color7GetBlueEv, .Lfunc_end10-_ZN4Hapi5Color7GetBlueEv
                                        # -- End function
	.globl	_ZN4Hapi5Color8GetAlphaEv       # -- Begin function _ZN4Hapi5Color8GetAlphaEv
	.p2align	2
	.type	_ZN4Hapi5Color8GetAlphaEv,@function
_ZN4Hapi5Color8GetAlphaEv:              # @_ZN4Hapi5Color8GetAlphaEv
# %bb.0:
	lbu	a0, 5(a0)
	ret
.Lfunc_end11:
	.size	_ZN4Hapi5Color8GetAlphaEv, .Lfunc_end11-_ZN4Hapi5Color8GetAlphaEv
                                        # -- End function
	.globl	_ZN4Hapi5Color8GetColorEv       # -- Begin function _ZN4Hapi5Color8GetColorEv
	.p2align	2
	.type	_ZN4Hapi5Color8GetColorEv,@function
_ZN4Hapi5Color8GetColorEv:              # @_ZN4Hapi5Color8GetColorEv
# %bb.0:
	lhu	a0, 0(a0)
	ret
.Lfunc_end12:
	.size	_ZN4Hapi5Color8GetColorEv, .Lfunc_end12-_ZN4Hapi5Color8GetColorEv
                                        # -- End function
	.globl	_ZN4Hapi5ColorC1Ehhhb
	.type	_ZN4Hapi5ColorC1Ehhhb,@function
.set _ZN4Hapi5ColorC1Ehhhb, _ZN4Hapi5ColorC2Ehhhb
	.ident	"clang version 21.0.0git"
	.section	".note.GNU-stack","",@progbits
	.addrsig
