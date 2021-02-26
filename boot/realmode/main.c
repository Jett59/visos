#include <kernel16.h>

void kernel_entry (void)
{
    cls();
    for(;;){
        puts("Successfully activated kernel!\n");
    puts ("Welcome!\n");
    }
}