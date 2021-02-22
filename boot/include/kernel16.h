#ifndef _kernel_functions_h
#define _kernel_functions_h  "_kernel_functions.h"

//these are used by the main kernel code
#define cls  _kern16_cls()
#define puts  _kern16_puts
void _kern16_cls();
void __fastcall _kern16_puts (char*);

void _kern16_puts (); // not to be called by the main kernel code.
#endif