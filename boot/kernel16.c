#include <kernel16.h>

void initialise_video_segment () {
    asm ("movw $0xb800, %di"); // video segment is located at 0xB800
    asm ("movw %di, %es"); // move it into es
}

void kernel_entry () {
    initialise_video_segment();
    cls;
    puts("Successfully activated kernel!");
    for (;;){
        continue; // block forever
    }
}