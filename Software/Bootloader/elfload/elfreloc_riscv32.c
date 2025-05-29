/* Copyright © 2025, Yannik Stamm
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
 * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */

#include "elfload.h"

#if defined(__riscv32__)

#define R_RISC_NONE				 0
#define R_RISC_32				 1
#define R_RISC_64				 2
#define R_RISC_RELATIVE			 3
#define R_RISC_COPY				 4
#define R_RISC_JUMP_SLOT		 5
#define R_RISC_TLS_DTPMOD32		 6
#define R_RISC_TLS_DTPMOD64		 7
#define R_RISC_TLS_DTPREL32		 8
#define R_RISC_TLS_DTPREL64		 9
#define R_RISC_TLS_TPREL32		10
#define R_RISC_TLS_TPREL64		11
#define R_RISC_TLSDESC			12
#define R_RISC_BRANCH			16
#define R_RISC_JAL				17
#define R_RISC_CALL				18
#define R_RISC_CALL_PLT			19
#define R_RISC_GOT_HI20			20
#define R_RISC_TLS_GOT_HI20		21
#define R_RISC_TLS_GD_HI20		22
#define R_RISC_PCREL_HI20		23
#define R_RISC_PCREL_LO12_I		24
#define R_RISC_PCREL_LO12_S		25
#define R_RISC_HI20				26
#define R_RISC_LO12_I			27
#define R_RISC_LO12_S			28
#define R_RISC_TPREL_HI20		29
#define R_RISC_TPREL_LO12_I		30
#define R_RISC_TPREL_LO12_S		31
#define R_RISC_TPREL_ADD		32
#define R_RISC_ADD8				33
#define R_RISC_ADD16			34
#define R_RISC_ADD32			35
#define R_RISC_ADD64			36
#define R_RISC_SUB8				37
#define R_RISC_SUB16			38
#define R_RISC_SUB32			39
#define R_RISC_SUB64			40
#define R_RISC_GOT32_PCREL		41
#define R_RISC_ALIGN			43
#define R_RISC_RVC_BRANCH		44
#define R_RISC_RVC_JUMP			45
#define R_RISC_RELAX			51
#define R_RISC_SUB6				52
#define R_RISC_SET6				53
#define R_RISC_SET8				54
#define R_RISC_SET16			55
#define R_RISC_SET32			56
#define R_RISC_32_PCREL			57
#define R_RISC_IRELATIVE		58
#define R_RISC_PLT32			59
#define R_RISC_SET_ULEB128		60
#define R_RISC_SUB_ULEB128		61
#define R_RISC_TLSDESC_HI20		62
#define R_RISC_TLSDESC_LOAD_LO12 63
#define R_RISC_TLSDESC_ADD_LO12	64
#define R_RISC_TLSDESC_CALL		65
#define R_RISC_VENDOR		   191

el_status el_applyrela(el_ctx *ctx, Elf_RelA *rel)
{
    uintptr_t *target = (uintptr_t*) (rel->r_offset + ctx->base_load_paddr);
    uint32_t type = ELF_R_TYPE(rel->r_info);
    uint32_t sym  = ELF_R_SYM(rel->r_info);

	if (type >= 192)
	{
		EL_DEBUG("Bad relocation %u. This is a vendor specific relocation!\n", type);
		return EL_BADREL;
	}

    switch (type) {
        case R_RISC_NONE:
            EL_DEBUG("R_RISC_NONE\n");
            break;
        case R_RISC_32:
			return EL_BADREL;
            *target = rel->r_addend + ctx->base_load_vaddr;
            break;

        default:
            EL_DEBUG("Bad relocation %u\n", type);
            return EL_BADREL;

    }

    return EL_OK;
}

/* I just hope, that the linker does not emit relocations without explicit addend
el_status el_applyrel(el_ctx *ctx, Elf_Rel *rel)
{
    uintptr_t *p = (uintptr_t*) (rel->r_offset + ctx->base_load_paddr);
    uint32_t type = ELF_R_TYPE(rel->r_info);
    uint32_t sym  = ELF_R_SYM(rel->r_info);

    switch (type) {
        case R_AARCH64_NONE:
            EL_DEBUG("R_AARCH64_NONE\n");
            break;
        case R_AARCH64_RELATIVE:
            if (sym) {
                EL_DEBUG("R_AARCH64_RELATIVE with symbol ref!\n");
                return EL_BADREL;
            }

            EL_DEBUG("Applying R_AARCH64_RELATIVE reloc @%p\n", p);
            *p += ctx->base_load_vaddr;
            break;

        default:
            EL_DEBUG("Bad relocation %u\n", type);
            return EL_BADREL;

    }

    return EL_OK;
}
*/

#endif
