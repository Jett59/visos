SECTIONS {
    . = 0x7C00;
    .boot : {
        * (.boot)
    }
    .bootdata : {
        * (.bootdata)
    }
    . = 0x7DFD;
    .signature : {
        * (.signature)
    }
}