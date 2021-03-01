#ifndef _io_functions_h
#define _io_functions_h  "io functions"

unsigned char inb (unsigned short port);
void outb (unsigned char val, unsigned short port);

void io_delay ();

#endif