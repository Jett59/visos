#include <kernel16.h>

void kernel_entry (void)
{
    cls();
    print_stuff:
    puts ("ViSOS\n");
    puts ("Welcome!\n");
    goto print_stuff;
}