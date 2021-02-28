#include <kernel16.h>
#include <a20.h>

void kernel_entry (void)
{
    cls();
    puts ("ViSOS\n");
    puts ("Welcome!\n");
    enable_a20 ();
    for(;;){}
}