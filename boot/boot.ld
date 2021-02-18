SECTIONS {
    . = 0x7C00;
    .mbr : {
        * (.mbr)
    }
    .mbrdata : {
        * (.mbrdata)
    }
    . = 0x7DFE;
    .signature : {
        * (.signature)
    }
}