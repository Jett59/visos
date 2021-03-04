#include <descriptors.h>
#include <kernel16.h>
#include <io.h>

static descriptor_ptr flat_gdt_ptr;
static gdt_entry flat_gdt [3] __attribute__ ((aligned(16)));

void build_flat_gdt ()
{
    BUILD_GDT_ENTRY (0x00000000, 0xFFFFFFFF, 0x9A, 0xCF, flat_gdt[1]);
    BUILD_GDT_ENTRY (0x00000000, 0xFFFFFFFF, 0xCF, 0x92, flat_gdt[2]);
    flat_gdt_ptr.size = sizeof (flat_gdt)-1;
    flat_gdt_ptr.ptr = (u32) &flat_gdt;
}

void enter_protected_mode ()
{
    puts ("building the gdt\n");
    build_flat_gdt ();
    LOAD_GDT (flat_gdt_ptr);
    puts ("successfully loaded the gdt\n");
}