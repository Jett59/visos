#include <descriptors.h>
#include <kernel16.h>
#include <io.h>
#include <pm.h>

static descriptor_ptr null_idt = {
    .size = 0,
    .ptr = 0
};
static descriptor_ptr flat_gdt_ptr;
static gdt_entry flat_gdt [3] __attribute__ ((aligned(16)));

void build_flat_gdt ()
{
    flat_gdt[1] = create_descriptor (0x00000000, 0xFFFFFFFF, GDT_CODE_PL0);
    puts ("Code: ");
    puthex (flat_gdt[1]);
    putchar ('\n');
    flat_gdt[2] = create_descriptor (0x00000000, 0xFFFFFFFF, GDT_DATA_PL0);
    puts ("Data: ");
    puthex (flat_gdt[2]);
    putchar ('\n');
    flat_gdt_ptr.size = sizeof (flat_gdt)-1;
    flat_gdt_ptr.ptr = (u32) &flat_gdt;
}

void disable_all_interrupts ()
{
    __asm__ volatile ("cli\n\t"); // clear the interrupt flag so no irqs can be processed
    outb (0x80, 0x70); // write 0x80 (disable) to the nmi controler thing
    io_delay (); // delay for a bit so the message has time to arrive
}

void enter_protected_mode ()
{
    puts ("Clearing all interrupts so cpu doesn't crash\n");
    disable_all_interrupts ();
    puts ("building the gdt\n");
    build_flat_gdt ();
    LOAD_GDT (flat_gdt_ptr);
    puts ("Installing the empty idt\n");
    LOAD_IDT (null_idt);
    puts ("Jumping into protected mode!\n");
    puts ("See you on the other side!\n");
    protected_mode_jump ();
}