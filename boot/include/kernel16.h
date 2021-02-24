#ifndef _kernel_functions_h
#define _kernel_functions_h  "_kernel_functions.h"

typedef unsigned short size_t; // 16bit sizes

void memset (void* ptr, size_t size, char value);
void cls();
void putchar (char ch);
void puts (char* str);
#endif