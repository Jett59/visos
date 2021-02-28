#include <kernel16.h>
#include <bios.h>
#include <memory.h>

#define _A20_TEST_ADDRESS  0x200

#define _A20_CHECK_LOOPS_LONG  256
#define _A20_CHECK_LOOPS_SHORT  64

int a20_disabled_check (int loops)
{
    set_fs (0x0000);
    set_gs (0xFFFF);

    int status = 0;
    int original;
    original = read_fs (_A20_TEST_ADDRESS);
    int new = original+1;
    while (loops --) {
        puts (".");
        write_fs (_A20_TEST_ADDRESS, new);
        puts (",");
        status = read_gs (_A20_TEST_ADDRESS + 0x10) ^ new;
        if (status == 0){
            break;
        }
}
putchar ('\n');
    write_fs (_A20_TEST_ADDRESS, original);
    return status;
}

int test_a20_disabled_short ()
{
    return a20_disabled_check (_A20_CHECK_LOOPS_SHORT);
}
int test_a20_disabled_long ()
{
    return a20_disabled_check (_A20_CHECK_LOOPS_LONG);
}

void enable_a20_bios ()
{
    interrupt_registers.a.x = 0x2401; // bios function to enable a20 line
    intcall (0x15);
}

#define _A20_ENABLE_ATTEMPTS  16

void enable_a20 ()
{
    int status;
    puts ("Checking if a20 is already enabled.\n");
    status = test_a20_disabled_short ();
    puts (status ? "false\n" : "true!\n");
    int loops = _A20_ENABLE_ATTEMPTS;

puts ("About to begin a20 enable loop\n");
    while (loops--) {
        enable_a20_bios ();
        status = test_a20_disabled_short ();
        if (status){
            break;
        }
    }
    if (status == 0) {
        puts ("Error enabling the a20 line!\n");
        for (;;) {}
    }else{
        puts ("a20 line active!\n");
    }
}