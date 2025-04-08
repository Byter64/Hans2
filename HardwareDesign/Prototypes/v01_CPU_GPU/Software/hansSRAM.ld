MEMORY
{
  SRAM (wrx): ORIGIN = 0, LENGTH = 24576
}

SECTIONS
{

  .text : 
  {
    ._start
    *(.text.*)
    *(.rodata.*)
    _etext = .;
  } > SRAM

  .bss (NOLOAD) :
  {
    _sbss = .;
    *(.bss .bss.*)
    *(COMMON)
    _ebss = .;
  } > SRAM

  .data :
  {
    _sdata = .;
    *(.data*)
    _edata = .;
  } > SRAM

  .stack (NOLOAD) : 
  {
    . = ALIGN(16);
    . = . + 0x1000;
    . = ALIGN(16);
  }


  .shstrtab : 
  {
    *(.shstrtab)
  }
}