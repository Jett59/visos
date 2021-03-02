#ifndef _io_functions_h
#define _io_functions_h  "io functions"

#include <types.h>

u8 inb (u16 port);
void outb (u8 val, u16 port);

#endif