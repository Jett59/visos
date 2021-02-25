#include <kernel16.h>
#include <video.h>

void memset (void* ptr, char value, size_t size)
{
    int * working_ptr = ptr;
    size_t aligned_size = size >> 2; // divide size by four, since int is 32bit
    int remaining_bytes = size - (aligned_size << 2); // get bytes that will be skipped by the (faster) aligned while loop
    char * final_ptr = ptr+size-remaining_bytes; // char pointer, sets the last bytes (if any)
    while (remaining_bytes --){
        * (final_ptr+remaining_bytes) = value; // set the single byte to the value
    }
    int aligned_value = value * 0x01010101; // since one byte is two hex digits, multiplying this with 0x01010101 will make four bytes each of the same value as the one byte
    while(aligned_size --) {
        * (working_ptr+aligned_size) = aligned_value;
    }
}

void cls ()
{
    memset (screen.base, 0, screen.columns*screen.rows*2);
    screen.cursor_pos = 0;
}

void newline()
{
    int row = screen.cursor_pos/screen.columns;
    row++;
    screen.cursor_pos = row*screen.columns;
}

void write_video_cell(video_cell cell)
{
    if(cell.character == '\n')
    {
        newline ();
        return;
    }
    video_cell * destinationCell = screen.base+screen.cursor_pos;
    *destinationCell = cell;
    screen.cursor_pos++;
}

void putchar (char ch)
{
    video_cell cell;
    cell.attribute = screen.current_color;
    cell.character = ch;
    write_video_cell(cell);
}

void puts (char* str)
{
    video_cell cell;
    cell.attribute = screen.current_color;
    while(*str != 0)
    {
        cell.character = *str;
        write_video_cell (cell);
        str++;
    }
}