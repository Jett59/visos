#include <io.h>

void outb (u8 val, u16 port)
{
    __asm__ volatile ("outb %1,%0\n\t"
    : : "d"(port), "a"(val) : );
}

u8 inb (u16 port)
{
    u8 result;
    __asm__ volatile ("inb %1,%0"
    : "=a"(result) : "d"(port));
    return result;
}