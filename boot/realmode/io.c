#include <io.h>

void outb (u8 val, u16 port)
{
    __asm__ volatile ("outb %1,%0\n\t"
    : : "d"(port), "a"(val) : );
}