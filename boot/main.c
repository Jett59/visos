#include <kernel16.h>

void kernel_entry (void)
{
    cls();
    puts("Successfully activated kernel!\n");
    puts ("Welcome!");
    for(;;){}
}