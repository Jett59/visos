#ifndef _kernel_functions_h
#define _kernel_functions_h  "_kernel_functions.h"

#include <types.h>

void memset (void* ptr, u8 value, size_t size);
void cls();
void putchar (char ch);
void puts (char* str);
void puthex (u64 num);

void enter_protected_mode ();
#endif