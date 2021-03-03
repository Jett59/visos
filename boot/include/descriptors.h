#ifndef _DESCRIPTORS_HEADER
#define _DESCRIPTORS_HEADER  "descriptors"

#include <types.h>

typedef struct __attribute__ ((packed)) {
    u16 size;
    u32 ptr;
} descriptor_ptr;

void load_gdt (descriptor_ptr ptr);

#endif