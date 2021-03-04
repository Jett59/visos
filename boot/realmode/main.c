#include <kernel16.h>
#include <a20.h>

void kernel_entry (void)
{
    cls();
    puts ("ViSOS\n");
    puts ("Welcome!\n");
    enable_a20 ();
    puts ("making last preparations and transitioning to protected mode!\n");
    enter_protected_mode ();
    puts ("OOPS! Something happened and transition to protected mode failed\n");
    for (;;){}
}