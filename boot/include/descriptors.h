#ifndef _DESCRIPTORS_HEADER
#define _DESCRIPTORS_HEADER  "descriptors"

#include <types.h>
#include <gdt_bits.h>

#define LOAD_GDT(gdt)  __asm__ volatile ("lgdt %0\n\t" \
: : "g"(gdt))
#define LOAD_IDT(PTR)  __asm__ volatile ("lidt %0\n\t" \
: : "g"(PTR))

typedef u64 gdt_entry;

typedef struct __attribute__ ((packed)) {
    u16 size;
    u32 ptr;
} descriptor_ptr;

#define GDT_CODE_PL0 SEG_DESCTYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
SEG_LONG(0)     | SEG_SIZE(1) | SEG_GRAN(1) | \
SEG_PRIV(0)     | SEG_CODE_EXRD

#define GDT_DATA_PL0 SEG_DESCTYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
SEG_LONG(0)     | SEG_SIZE(1) | SEG_GRAN(1) | \
SEG_PRIV(0)     | SEG_DATA_RDWR

#define GDT_CODE_PL3 SEG_DESCTYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
SEG_LONG(0)     | SEG_SIZE(1) | SEG_GRAN(1) | \
SEG_PRIV(3)     | SEG_CODE_EXRD

#define GDT_DATA_PL3 SEG_DESCTYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
SEG_LONG(0)     | SEG_SIZE(1) | SEG_GRAN(1) | \
SEG_PRIV(3)     | SEG_DATA_RDWR

u64 create_descriptor (u32 base, u32 limit, u16 flag);

#endif