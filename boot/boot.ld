SECTIONS {
    .mbr : {
        * (.mbr)
        * (.mbrdata)
        . = 0x7DFE;
        * (.signature)
    } > mbr
}
MEMORY {
    mbr (rwx) : ORIGIN = 0x7C00, LENGTH = 512
}