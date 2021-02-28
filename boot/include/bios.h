#ifndef _bios_functions_h
#define _bios_functions_h  "bios functions"

typedef union {
    short x;
    struct __attribute__ ((packed)) {
        char low;
        char high;
    } components;
} bios_reg;

typedef struct __attribute__ ((packed)) {
    bios_reg a;
    bios_reg b;
    bios_reg c;
    bios_reg d;
} bios_regs;

extern bios_regs interrupt_registers;

void intcall (char interrupt_num);

#endif