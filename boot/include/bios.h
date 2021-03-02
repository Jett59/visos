#ifndef _bios_functions_h
#define _bios_functions_h  "bios functions"

#include <types.h>

typedef union {
    u16 x;
    struct __attribute__ ((packed)) {
        u8 low;
        u8 high;
    } components;
} bios_reg;

typedef struct __attribute__ ((packed)) {
    bios_reg a;
    bios_reg b;
    bios_reg c;
    bios_reg d;
} bios_regs;

extern bios_regs interrupt_registers;

void intcall (u8 interrupt_num);

#endif