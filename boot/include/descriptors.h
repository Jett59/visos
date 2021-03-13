#ifndef _DESCRIPTORS_HEADER
#define _DESCRIPTORS_HEADER  "descriptors"

#include <types.h>
#include <gdt_bits.h>

#define CREATE_GDT_ENTRY(BASE, LIMIT, FLAGS) ( \
((u64)((u64)LIMIT & 0x000F0000) | (((u64)FLAGS << 8) & 0x00F0FF00) | \
((((u64)BASE >> 16) & 0x000000FF) | ((u64)BASE & 0xFF000000)) \
<< 32) | (u32)(((u64)BASE << 16) | ((u64)LIMIT & 0x0000FFFF)))

#define GDT_FLAGS(DESCRIPTOR_TYPE, SYS, LONG, SIZE, GRANULARITY, PRIVILEGE, TYPE) ( \
(u64)SEG_DESCTYPE(DESCRIPTOR_TYPE) | (u64)SEG_PRES(1) | (u64)SEG_SAVL(SYS) | \
(u64)SEG_LONG(LONG) | (u64)SEG_SIZE(SIZE) | (u64)SEG_GRAN(GRANULARITY) | \
(u64)SEG_PRIV(PRIVILEGE) | (u64)TYPE )

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

#endif