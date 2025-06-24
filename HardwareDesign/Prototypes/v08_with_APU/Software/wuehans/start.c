

asm(
".section .text.startSection\n"
".global _Z4mainv\n"
".global _start\n"

"_start:\n"
/* zero-initialize all registers */
"addi x1, zero, 0\n"
"addi x2, zero, 0\n"
"addi x3, zero, 0\n"
"addi x4, zero, 0\n"
"addi x5, zero, 0\n"
"addi x6, zero, 0\n"
"addi x7, zero, 0\n"
"addi x8, zero, 0\n"
"addi x9, zero, 0\n"
"addi x10, zero, 0\n"
"addi x11, zero, 0\n"
"addi x12, zero, 0\n"
"addi x13, zero, 0\n"
"addi x14, zero, 0\n"
"addi x15, zero, 0\n"
"addi x16, zero, 0\n"
"addi x17, zero, 0\n"
"addi x18, zero, 0\n"
"addi x19, zero, 0\n"
"addi x20, zero, 0\n"
"addi x21, zero, 0\n"
"addi x22, zero, 0\n"
"addi x23, zero, 0\n"
"addi x24, zero, 0\n"
"addi x25, zero, 0\n"
"addi x26, zero, 0\n"
"addi x27, zero, 0\n"
"addi x28, zero, 0\n"
"addi x29, zero, 0\n"
"addi x30, zero, 0\n"
"addi x31, zero, 0\n"

/* set stack pointer */
".equ STACK_START, 0x02000000\n"
"lui sp, %hi(STACK_START)\n"
"addi sp, sp, %lo(STACK_START)\n"

/* push zeros on the stack for argc and argv */
/* (stack is aligned to 16 bytes in riscv calling convention) */
"addi sp,sp,-16\n"
"sw zero,0(sp)\n"
"sw zero,4(sp)\n"
"sw zero,8(sp)\n"
"sw zero,12(sp)\n"

/* jump to libc init */
"j _Z4mainv\n"
//"j main\n"
);