#include <kernel16.h>
#include <video.h>

void memset (void* ptr, size_t size, char value)
{
    char * working_ptr = ptr;
    while(size --){
        * (working_ptr+size) = value;
    }
}

void cls ()
{
    memset (screen.base, screen.columns*screen.rows*2, 0);
}