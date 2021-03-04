SECTIONS {
    .mbr : {
        * (.mbr)
        * (.mbrdata)
        . = 0x7DFE;
        * (.signature)
    } > mbr
    .primary : {
        *(.text)
        *(.data)
        * (.rodata.*)
        bss_begin = .;
        * (.bss);
        bss_end = .;
        . = 0xFE00;
    } > primary
    .vram : {
        * (.vram)
    } > vram
}
MEMORY {
    mbr (rwx) : ORIGIN = 0x7C00, LENGTH = 512
    primary (rwx) : ORIGIN = 0x7E00, LENGTH = 32k
    vram (rw) : ORIGIN = 0xB8000, LENGTH = 0
}