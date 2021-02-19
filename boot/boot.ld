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
        . = 0xFE00;
    } > primary
}
MEMORY {
    mbr (rwx) : ORIGIN = 0x7C00, LENGTH = 512
    primary (rwx) : ORIGIN = 0x7E00, LENGTH = 32k
}