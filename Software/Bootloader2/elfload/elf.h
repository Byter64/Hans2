/*    $OpenBSD: exec_elf.h,v 1.53 2014/01/03 03:00:39 guenther Exp $    */
/*
 * Copyright (c) 1995, 1996 Erik Theisen.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/* imported sys/exec_elf.h from OpenBSD */

#ifndef ELF_H
#define ELF_H
#include <stdint.h>

typedef uint8_t     Elf_Byte;

typedef uint32_t    Elf32_Addr;    /* Unsigned program address */
typedef uint32_t    Elf32_Off;     /* Unsigned file offset */
typedef int32_t     Elf32_Sword;   /* Signed large integer */
typedef uint32_t    Elf32_Word;    /* Unsigned large integer */
typedef uint16_t    Elf32_Half;    /* Unsigned medium integer */

typedef uint64_t    Elf64_Addr;
typedef uint64_t    Elf64_Off;
typedef int32_t     Elf64_Shalf;

#ifdef __alpha__
typedef int64_t     Elf64_Sword;
typedef uint64_t    Elf64_Word;
#else
typedef int32_t     Elf64_Sword;
typedef uint32_t    Elf64_Word;
#endif

typedef int64_t     Elf64_Sxword;
typedef uint64_t    Elf64_Xword;

typedef uint32_t    Elf64_Half;
typedef uint16_t    Elf64_Quarter;

/*
 * e_ident[] identification indexes
 * See http://www.sco.com/developers/gabi/latest/ch4.eheader.html
 */
#define EI_MAG0        0        /* file ID */
#define EI_MAG1        1        /* file ID */
#define EI_MAG2        2        /* file ID */
#define EI_MAG3        3        /* file ID */
#define EI_CLASS       4        /* file class */
#define EI_DATA        5        /* data encoding */
#define EI_VERSION     6        /* ELF header version */
#define EI_OSABI       7        /* OS/ABI ID */
#define EI_ABIVERSION  8        /* ABI version */
#define EI_PAD         9        /* start of pad bytes */
#define EI_NIDENT     16        /* Size of e_ident[] */

/* e_ident[] magic number */
#define    ELFMAG0        0x7f       /* e_ident[EI_MAG0] */
#define    ELFMAG1        'E'        /* e_ident[EI_MAG1] */
#define    ELFMAG2        'L'        /* e_ident[EI_MAG2] */
#define    ELFMAG3        'F'        /* e_ident[EI_MAG3] */
#define    ELFMAG        "\177ELF"   /* magic */
#define    SELFMAG        4          /* size of magic */

/* e_ident[] file class */
#define    ELFCLASSNONE    0        /* invalid */
#define    ELFCLASS32    1          /* 32-bit objs */
#define    ELFCLASS64    2          /* 64-bit objs */
#define    ELFCLASSNUM    3         /* number of classes */

/* e_ident[] data encoding */
#define ELFDATANONE    0            /* invalid */
#define ELFDATA2LSB    1            /* Little-Endian */
#define ELFDATA2MSB    2            /* Big-Endian */
#define ELFDATANUM     3            /* number of data encode defines */

/* e_ident[] Operating System/ABI */
#define ELFOSABI_SYSV        0    /* UNIX System V ABI */
#define ELFOSABI_HPUX        1    /* HP-UX operating system */
#define ELFOSABI_NETBSD      2    /* NetBSD */
#define ELFOSABI_LINUX       3    /* GNU/Linux */
#define ELFOSABI_HURD        4    /* GNU/Hurd */
#define ELFOSABI_86OPEN      5    /* 86Open common IA32 ABI */
#define ELFOSABI_SOLARIS     6    /* Solaris */
#define ELFOSABI_MONTEREY    7    /* Monterey */
#define ELFOSABI_IRIX        8    /* IRIX */
#define ELFOSABI_FREEBSD     9    /* FreeBSD */
#define ELFOSABI_TRU64       10   /* TRU64 UNIX */
#define ELFOSABI_MODESTO     11   /* Novell Modesto */
#define ELFOSABI_OPENBSD     12   /* OpenBSD */
#define ELFOSABI_ARM         97   /* ARM */
#define ELFOSABI_STANDALONE  255  /* Standalone (embedded) application */

/* e_ident */
#define IS_ELF(ehdr) ((ehdr).e_ident[EI_MAG0] == ELFMAG0 && \
                      (ehdr).e_ident[EI_MAG1] == ELFMAG1 && \
                      (ehdr).e_ident[EI_MAG2] == ELFMAG2 && \
                      (ehdr).e_ident[EI_MAG3] == ELFMAG3)

/* ELF Header */
typedef struct {
    unsigned char    e_ident[EI_NIDENT];     /* ELF Identification */
    Elf32_Half       e_type;                 /* object file type */
    Elf32_Half       e_machine;              /* machine */
    Elf32_Word       e_version;              /* object file version */
    Elf32_Addr       e_entry;                /* virtual entry point */
    Elf32_Off        e_phoff;                /* program header table offset */
    Elf32_Off        e_shoff;                /* section header table offset */
    Elf32_Word       e_flags;                /* processor-specific flags */
    Elf32_Half       e_ehsize;               /* ELF header size */
    Elf32_Half       e_phentsize;            /* program header entry size */
    Elf32_Half       e_phnum;                /* number of program header entries */
    Elf32_Half       e_shentsize;            /* section header entry size */
    Elf32_Half       e_shnum;                /* number of section header entries */
    Elf32_Half       e_shstrndx;             /* section header table's "section
                                                header string table" entry offset */
} Elf32_Ehdr;

typedef struct {
    unsigned char    e_ident[EI_NIDENT];    /* Id bytes */
    Elf64_Quarter    e_type;                /* file type */
    Elf64_Quarter    e_machine;             /* machine type */
    Elf64_Half       e_version;             /* version number */
    Elf64_Addr       e_entry;               /* entry point */
    Elf64_Off        e_phoff;               /* Program hdr offset */
    Elf64_Off        e_shoff;               /* Section hdr offset */
    Elf64_Half       e_flags;               /* Processor flags */
    Elf64_Quarter    e_ehsize;              /* sizeof ehdr */
    Elf64_Quarter    e_phentsize;           /* Program header entry size */
    Elf64_Quarter    e_phnum;               /* Number of program headers */
    Elf64_Quarter    e_shentsize;           /* Section header entry size */
    Elf64_Quarter    e_shnum;               /* Number of section headers */
    Elf64_Quarter    e_shstrndx;            /* String table index */
} Elf64_Ehdr;

/* e_type */
#define ET_NONE        0        /* No file type */
#define ET_REL         1        /* relocatable file */
#define ET_EXEC        2        /* executable file */
#define ET_DYN         3        /* shared object file */
#define ET_CORE        4        /* core file */
#define ET_NUM         5        /* number of types */
#define ET_LOPROC      0xff00   /* reserved range for processor */
#define ET_HIPROC      0xffff   /*  specific e_type */

/* e_machine */
#define EM_NONE        0        /* No Machine */
#define EM_M32         1        /* AT&T WE 32100 */
#define EM_SPARC       2        /* SPARC */
#define EM_386         3        /* Intel 80386 */
#define EM_68K         4        /* Motorola 68000 */
#define EM_88K         5        /* Motorola 88000 */
#define EM_486         6        /* Intel 80486 - unused? */
#define EM_860         7        /* Intel 80860 */
#define EM_MIPS        8        /* MIPS R3000 Big-Endian only */
#define EM_RISCV	   243		/* RISCV*/
/*
 * Don't know if EM_MIPS_RS4_BE,
 * EM_SPARC64, EM_PARISC,
 * or EM_PPC are ABI compliant
 */
#define EM_MIPS_RS4_BE 10        /* MIPS R4000 Big-Endian */
#define EM_SPARC64     11        /* SPARC v9 64-bit unofficial */
#define EM_PARISC      15        /* HPPA */
#define EM_SPARC32PLUS 18        /* Enhanced instruction set SPARC */
#define EM_PPC         20        /* PowerPC */
#define EM_ARM         40        /* ARM AArch32 */
#define EM_ALPHA       41        /* DEC ALPHA */
#define EM_SH          42        /* Hitachi/Renesas Super-H */
#define EM_SPARCV9     43        /* SPARC version 9 */
#define EM_IA_64       50        /* Intel IA-64 Processor */
#define EM_AMD64       62        /* AMD64 architecture */
#define EM_VAX         75        /* DEC VAX */
#define EM_AARCH64     183       /* ARM AArch64 */

/* Non-standard */
#define EM_ALPHA_EXP   0x9026        /* DEC ALPHA */


/* Version */
#define EV_NONE        0        /* Invalid */
#define EV_CURRENT     1        /* Current */
#define EV_NUM         2        /* number of versions */

/* Section Header */
typedef struct {
    Elf32_Word    sh_name;      /* name - index into section header
                                 * string table section */
    Elf32_Word    sh_type;      /* type */
    Elf32_Word    sh_flags;     /* flags */
    Elf32_Addr    sh_addr;      /* address */
    Elf32_Off     sh_offset;    /* file offset */
    Elf32_Word    sh_size;      /* section size */
    Elf32_Word    sh_link;      /* section header table index link */
    Elf32_Word    sh_info;      /* extra information */
    Elf32_Word    sh_addralign; /* address alignment */
    Elf32_Word    sh_entsize;   /* section entry size */
} Elf32_Shdr;

typedef struct {
    Elf64_Half    sh_name;       /* section name */
    Elf64_Half    sh_type;       /* section type */
    Elf64_Xword   sh_flags;      /* section flags */
    Elf64_Addr    sh_addr;       /* virtual address */
    Elf64_Off     sh_offset;     /* file offset */
    Elf64_Xword   sh_size;       /* section size */
    Elf64_Half    sh_link;       /* link to another */
    Elf64_Half    sh_info;       /* misc info */
    Elf64_Xword   sh_addralign;  /* memory alignment */
    Elf64_Xword   sh_entsize;    /* table entry size */
} Elf64_Shdr;

/* Special Section Indexes */
#define SHN_UNDEF     0             /* undefined */
#define SHN_LORESERVE 0xff00        /* lower bounds of reserved indexes */
#define SHN_LOPROC    0xff00        /* reserved range for processor */
#define SHN_HIPROC    0xff1f        /*   specific section indexes */
#define SHN_ABS       0xfff1        /* absolute value */
#define SHN_COMMON    0xfff2        /* common symbol */
#define SHN_HIRESERVE 0xffff        /* upper bounds of reserved indexes */

/* sh_type */
#define SHT_NULL     0        /* inactive */
#define SHT_PROGBITS 1        /* program defined information */
#define SHT_SYMTAB   2        /* symbol table section */
#define SHT_STRTAB   3        /* string table section */
#define SHT_RELA     4        /* relocation section with addends*/
#define SHT_HASH     5        /* symbol hash table section */
#define SHT_DYNAMIC  6        /* dynamic section */
#define SHT_NOTE     7        /* note section */
#define SHT_NOBITS   8        /* no space section */
#define SHT_REL      9        /* relation section without addends */
#define SHT_SHLIB    10       /* reserved - purpose unknown */
#define SHT_DYNSYM   11       /* dynamic symbol table section */
#define SHT_NUM      12       /* number of section types */
#define SHT_LOPROC   0x70000000    /* reserved range for processor */
#define SHT_HIPROC   0x7fffffff    /*  specific section header types */
#define SHT_LOUSER   0x80000000    /* reserved range for application */
#define SHT_HIUSER   0xffffffff    /*  specific indexes */

/* Section names */
#define ELF_BSS         ".bss"        /* uninitialized data */
#define ELF_DATA        ".data"       /* initialized data */
#define ELF_DEBUG       ".debug"      /* debug */
#define ELF_DYNAMIC     ".dynamic"    /* dynamic linking information */
#define ELF_DYNSTR      ".dynstr"     /* dynamic string table */
#define ELF_DYNSYM      ".dynsym"     /* dynamic symbol table */
#define ELF_FINI        ".fini"       /* termination code */
#define ELF_GOT         ".got"        /* global offset table */
#define ELF_HASH        ".hash"       /* symbol hash table */
#define ELF_INIT        ".init"       /* initialization code */
#define ELF_REL_DATA    ".rel.data"   /* relocation data */
#define ELF_REL_FINI    ".rel.fini"   /* relocation termination code */
#define ELF_REL_INIT    ".rel.init"   /* relocation initialization code */
#define ELF_REL_DYN     ".rel.dyn"    /* relocation dynamic link info */
#define ELF_REL_RODATA  ".rel.rodata" /* relocation read-only data */
#define ELF_REL_TEXT    ".rel.text"   /* relocation code */
#define ELF_RODATA      ".rodata"     /* read-only data */
#define ELF_SHSTRTAB    ".shstrtab"   /* section header string table */
#define ELF_STRTAB      ".strtab"     /* string table */
#define ELF_SYMTAB      ".symtab"     /* symbol table */
#define ELF_TEXT        ".text"       /* code */


/* Section Attribute Flags - sh_flags */
#define SHF_WRITE        0x1           /* Writable */
#define SHF_ALLOC        0x2           /* occupies memory */
#define SHF_EXECINSTR    0x4           /* executable */
#define SHF_TLS          0x400         /* thread local storage */
#define SHF_MASKPROC     0xf0000000    /* reserved bits for processor
                                        *  specific section attributes */

/* Symbol Table Entry */
typedef struct elf32_sym {
    Elf32_Word    st_name;     /* name - index into string table */
    Elf32_Addr    st_value;    /* symbol value */
    Elf32_Word    st_size;     /* symbol size */
    unsigned char st_info;     /* type and binding */
    unsigned char st_other;    /* 0 - no defined meaning */
    Elf32_Half    st_shndx;    /* section header index */
} Elf32_Sym;

typedef struct {
    Elf64_Half    st_name;    /* Symbol name index in str table */
    Elf_Byte      st_info;    /* type / binding attrs */
    Elf_Byte      st_other;   /* unused */
    Elf64_Quarter st_shndx;   /* section index of symbol */
    Elf64_Xword   st_value;   /* value of symbol */
    Elf64_Xword   st_size;    /* size of symbol */
} Elf64_Sym;

/* Symbol table index */
#define STN_UNDEF    0        /* undefined */

/* Extract symbol info - st_info */
#define ELF32_ST_BIND(x)    ((x) >> 4)
#define ELF32_ST_TYPE(x)    (((unsigned int) x) & 0xf)
#define ELF32_ST_INFO(b,t)  (((b) << 4) + ((t) & 0xf))

#define ELF64_ST_BIND(x)    ((x) >> 4)
#define ELF64_ST_TYPE(x)    (((unsigned int) x) & 0xf)
#define ELF64_ST_INFO(b,t)  (((b) << 4) + ((t) & 0xf))

/* Symbol Binding - ELF32_ST_BIND - st_info */
#define STB_LOCAL    0        /* Local symbol */
#define STB_GLOBAL   1        /* Global symbol */
#define STB_WEAK     2        /* like global - lower precedence */
#define STB_NUM      3        /* number of symbol bindings */
#define STB_LOPROC  13        /* reserved range for processor */
#define STB_HIPROC  15        /*  specific symbol bindings */

/* Symbol type - ELF32_ST_TYPE - st_info */
#define STT_NOTYPE    0        /* not specified */
#define STT_OBJECT    1        /* data object */
#define STT_FUNC      2        /* function */
#define STT_SECTION   3        /* section */
#define STT_FILE      4        /* file */
#define STT_TLS       6        /* thread local storage */
#define STT_LOPROC    13       /* reserved range for processor */
#define STT_HIPROC    15       /*  specific symbol types */

/* Relocation entry with implicit addend */
typedef struct {
    Elf32_Addr    r_offset;    /* offset of relocation */
    Elf32_Word    r_info;      /* symbol table index and type */
} Elf32_Rel;

/* Relocation entry with explicit addend */
typedef struct {
    Elf32_Addr    r_offset;    /* offset of relocation */
    Elf32_Word    r_info;      /* symbol table index and type */
    Elf32_Sword   r_addend;
} Elf32_Rela;

/* Extract relocation info - r_info */
#define ELF32_R_SYM(i)         ((i) >> 8)
#define ELF32_R_TYPE(i)        ((unsigned char) (i))
#define ELF32_R_INFO(s,t)      (((s) << 8) + (unsigned char)(t))

typedef struct {
    Elf64_Xword    r_offset;    /* where to do it */
    Elf64_Xword    r_info;      /* index & type of relocation */
} Elf64_Rel;

typedef struct {
    Elf64_Xword    r_offset;    /* where to do it */
    Elf64_Xword    r_info;      /* index & type of relocation */
    Elf64_Sxword    r_addend;   /* adjustment value */
} Elf64_Rela;

#define    ELF64_R_SYM(info)    ((info) >> 32)
#define    ELF64_R_TYPE(info)   ((info) & 0xFFFFFFFF)
#define    ELF64_R_INFO(s,t)    (((s) << 32) + (__uint32_t)(t))

#if defined(__mips64__) && defined(__MIPSEL__)
/*
 * The 64-bit MIPS ELF ABI uses a slightly different relocation format
 * than the regular ELF ABI: the r_info field is split into several
 * pieces (see gnu/usr.bin/binutils/include/elf/mips.h for details).
 */
#undef    ELF64_R_SYM
#undef    ELF64_R_TYPE
#undef    ELF64_R_INFO
#define   ELF64_R_TYPE(info)   (swap32((info) >> 32))
#define   ELF64_R_SYM(info)    ((info) & 0xFFFFFFFF)
#define   ELF64_R_INFO(s,t)    (((__uint64_t)swap32(t) << 32) + (__uint32_t)(s))
#endif /* __mips64__ && __MIPSEL__ */

/* Program Header */
typedef struct {
    Elf32_Word    p_type;     /* segment type */
    Elf32_Off     p_offset;   /* segment offset */
    Elf32_Addr    p_vaddr;    /* virtual address of segment */
    Elf32_Addr    p_paddr;    /* physical address - ignored? */
    Elf32_Word    p_filesz;   /* number of bytes in file for seg. */
    Elf32_Word    p_memsz;    /* number of bytes in mem. for seg. */
    Elf32_Word    p_flags;    /* flags */
    Elf32_Word    p_align;    /* memory alignment */
} Elf32_Phdr;

typedef struct {
    Elf64_Half    p_type;     /* entry type */
    Elf64_Half    p_flags;    /* flags */
    Elf64_Off     p_offset;   /* offset */
    Elf64_Addr    p_vaddr;    /* virtual address */
    Elf64_Addr    p_paddr;    /* physical address */
    Elf64_Xword   p_filesz;   /* file size */
    Elf64_Xword   p_memsz;    /* memory size */
    Elf64_Xword   p_align;    /* memory & file alignment */
} Elf64_Phdr;

/* Segment types - p_type */
#define PT_NULL        0          /* unused */
#define PT_LOAD        1          /* loadable segment */
#define PT_DYNAMIC     2          /* dynamic linking section */
#define PT_INTERP      3          /* the RTLD */
#define PT_NOTE        4          /* auxiliary information */
#define PT_SHLIB       5          /* reserved - purpose undefined */
#define PT_PHDR        6          /* program header */
#define PT_TLS         7          /* thread local storage */
#define PT_LOOS        0x60000000 /* reserved range for OS */
#define PT_HIOS        0x6fffffff /*  specific segment types */
#define PT_LOPROC      0x70000000 /* reserved range for processor */
#define PT_HIPROC      0x7fffffff /*  specific segment types */

#define PT_OPENBSD_RANDOMIZE 0x65a3dbe6 /* fill with random data */
#define PT_GANDR_KERNEL      0x67646b6c /* gdkl */


/* Segment flags - p_flags */
#define PF_X        0x1        /* Executable */
#define PF_W        0x2        /* Writable */
#define PF_R        0x4        /* Readable */
#define PF_MASKPROC 0xf0000000    /* reserved bits for processor */
                    /*  specific segment flags */

/* Dynamic structure */
typedef struct {
    Elf32_Sword    d_tag;    /* controls meaning of d_val */
    union {
        Elf32_Word d_val;    /* Multiple meanings - see d_tag */
        Elf32_Addr d_ptr;    /* program virtual address */
    } d_un;
} Elf32_Dyn;

typedef struct {
    Elf64_Xword     d_tag;   /* controls meaning of d_val */
    union {
        Elf64_Addr  d_ptr;
        Elf64_Xword d_val;
    } d_un;
} Elf64_Dyn;

/* Dynamic Array Tags - d_tag */
#define DT_NULL        0        /* marks end of _DYNAMIC array */
#define DT_NEEDED      1        /* string table offset of needed lib */
#define DT_PLTRELSZ    2        /* size of relocation entries in PLT */
#define DT_PLTGOT      3        /* address PLT/GOT */
#define DT_HASH        4        /* address of symbol hash table */
#define DT_STRTAB      5        /* address of string table */
#define DT_SYMTAB      6        /* address of symbol table */
#define DT_RELA        7        /* address of relocation table */
#define DT_RELASZ      8        /* size of relocation table */
#define DT_RELAENT     9        /* size of relocation entry */
#define DT_STRSZ      10        /* size of string table */
#define DT_SYMENT     11        /* size of symbol table entry */
#define DT_INIT       12        /* address of initialization func. */
#define DT_FINI       13        /* address of termination function */
#define DT_SONAME     14        /* string table offset of shared obj */
#define DT_RPATH      15        /* string table offset of library
                                 * search path */
#define DT_SYMBOLIC   16        /* start sym search in shared obj. */
#define DT_REL        17        /* address of rel. tbl. w addends */
#define DT_RELSZ      18        /* size of DT_REL relocation table */
#define DT_RELENT     19        /* size of DT_REL relocation entry */
#define DT_PLTREL     20        /* PLT referenced relocation entry */
#define DT_DEBUG      21        /* bugger */
#define DT_TEXTREL    22        /* Allow rel. mod. to unwritable seg */
#define DT_JMPREL     23        /* add. of PLT's relocation entries */
#define DT_BIND_NOW   24        /* Bind now regardless of env setting */
#define DT_LOOS       0x6000000d    /* reserved range for OS */
#define DT_HIOS       0x6ffff000    /*  specific dynamic array tags */
#define DT_LOPROC     0x70000000    /* reserved range for processor */
#define DT_HIPROC     0x7fffffff    /*  specific dynamic array tags */

/* some other useful tags */
#define DT_RELACOUNT  0x6ffffff9    /* if present, number of RELATIVE */
#define DT_RELCOUNT   0x6ffffffa    /* relocs, which must come first */
#define DT_FLAGS_1    0x6ffffffb

/* Dynamic Flags - DT_FLAGS_1 .dynamic entry */
#define DF_1_NOW       0x00000001
#define DF_1_GLOBAL    0x00000002
#define DF_1_GROUP     0x00000004
#define DF_1_NODELETE  0x00000008
#define DF_1_LOADFLTR  0x00000010
#define DF_1_INITFIRST 0x00000020
#define DF_1_NOOPEN    0x00000040
#define DF_1_ORIGIN    0x00000080
#define DF_1_DIRECT    0x00000100
#define DF_1_TRANS     0x00000200
#define DF_1_INTERPOSE 0x00000400
#define DF_1_NODEFLIB  0x00000800
#define DF_1_NODUMP    0x00001000
#define DF_1_CONLFAT   0x00002000

/* ld.so: number of low tags that are used saved internally (0 .. DT_NUM-1) */
#define DT_NUM        (DT_JMPREL+1)

/*
 * Note Definitions
 */
typedef struct {
    Elf32_Word namesz;
    Elf32_Word descsz;
    Elf32_Word type;
} Elf32_Note;

typedef struct {
    Elf64_Half namesz;
    Elf64_Half descsz;
    Elf64_Half type;
} Elf64_Note;

#if defined(ELFSIZE) && (ELFSIZE == 32)
#define Elf_Ehdr    Elf32_Ehdr
#define Elf_Phdr    Elf32_Phdr
#define Elf_Shdr    Elf32_Shdr
#define Elf_Sym     Elf32_Sym
#define Elf_Rel     Elf32_Rel
#define Elf_RelA    Elf32_Rela
#define Elf_Dyn     Elf32_Dyn
#define Elf_Half    Elf32_Half
#define Elf_Word    Elf32_Word
#define Elf_Sword   Elf32_Sword
#define Elf_Addr    Elf32_Addr
#define Elf_Off     Elf32_Off
#define Elf_Nhdr    Elf32_Nhdr
#define Elf_Note    Elf32_Note

#define ELF_R_SYM   ELF32_R_SYM
#define ELF_R_TYPE  ELF32_R_TYPE
#define ELF_R_INFO  ELF32_R_INFO
#define ELFCLASS    ELFCLASS32

#define ELF_ST_BIND ELF32_ST_BIND
#define ELF_ST_TYPE ELF32_ST_TYPE
#define ELF_ST_INFO ELF32_ST_INFO

#elif defined(ELFSIZE) && (ELFSIZE == 64)

#define Elf_Ehdr    Elf64_Ehdr
#define Elf_Phdr    Elf64_Phdr
#define Elf_Shdr    Elf64_Shdr
#define Elf_Sym     Elf64_Sym
#define Elf_Rel     Elf64_Rel
#define Elf_RelA    Elf64_Rela
#define Elf_Dyn     Elf64_Dyn
#define Elf_Half    Elf64_Half
#define Elf_Word    Elf64_Word
#define Elf_Sword   Elf64_Sword
#define Elf_Addr    Elf64_Addr
#define Elf_Off     Elf64_Off
#define Elf_Nhdr    Elf64_Nhdr
#define Elf_Note    Elf64_Note

#define ELF_R_SYM   ELF64_R_SYM
#define ELF_R_TYPE  ELF64_R_TYPE
#define ELF_R_INFO  ELF64_R_INFO
#define ELFCLASS    ELFCLASS64

#define ELF_ST_BIND ELF64_ST_BIND
#define ELF_ST_TYPE ELF64_ST_TYPE
#define ELF_ST_INFO ELF64_ST_INFO

#endif

#endif
