#ifndef _DESCRIPTORS_HEADER
#define _DESCRIPTORS_HEADER  "descriptors"

#include <types.h>

#define BUILD_GDT_ENTRY(BASE, LIMIT, GRANULARITY, ACCESS, DESCRIPTOR) ;\
DESCRIPTOR.base_low = BASE & 0xffff; \
DESCRIPTOR.base_middle = (BASE >> 16) & 0xff; \
DESCRIPTOR.base_high = (BASE >> 24) & 0xff; \
DESCRIPTOR.limit_low = LIMIT & 0xffff; \
DESCRIPTOR.granularity |= (LIMIT >> 16) & 0x0f; \
DESCRIPTOR.granularity |= GRANULARITY & 0xF0; \
DESCRIPTOR.access = ACCESS;

#define LOAD_GDT(gdt)  __asm__ ("lgdt %0\n\t" \
: : "g"(gdt))

typedef struct __attribute__ ((packed)) {
    u16 limit_low;
    u16 base_low;
    u8 base_middle;
    u8 access;
    u8 granularity;
    u8 base_high;
} gdt_entry;

typedef struct __attribute__ ((packed)) {
    u16 size;
    u32 ptr;
} descriptor_ptr;

#endif