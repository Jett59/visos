#include <descriptors.h>

void load_gdt (descriptor_ptr ptr)
{
    __asm__ volatile ("lgdt %0\n\t"
    : : "g"(ptr) : );
}