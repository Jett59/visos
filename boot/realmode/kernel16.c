#include <kernel16.h>
#include <io.h>
#include <video.h>

void memcpy (void * out, const void * in, size_t count)
{
    while (count--) {
        * (((char *) out) + count) = * (((char *) in) + count);
    }
}

void memset (void* ptr, u8 value, size_t size)
{
    u32 * working_ptr = ptr;
    size_t aligned_size = size >> 2; // divide size by four, since int is 32bit
    int remaining_bytes = size - (aligned_size << 2); // get bytes that will be skipped by the (faster) aligned while loop
    u8 * final_ptr = ptr+size-remaining_bytes; // char pointer, sets the last bytes (if any)
    while (remaining_bytes --){
        * (final_ptr+remaining_bytes) = value; // set the single byte to the value
    }
    u32 aligned_value = value * 0x01010101; // since one byte is two hex digits, multiplying this with 0x01010101 will make four bytes each of the same value as the one byte
    while(aligned_size --) {
        * (working_ptr+aligned_size) = aligned_value;
    }
}

void cls ()
{
    memset (screen.base, 0, screen.columns*screen.rows*2);
    screen.cursor_pos = 0;
}

void scroll_down ()
{
    video_cell * buffer = screen.base + screen.columns * screen.rows;
    memcpy (buffer, screen.base, screen.columns * screen.rows * 2);
    memcpy (screen.base, buffer + screen.columns, screen.columns * screen.rows * 2);
    memset (screen.base + screen.columns * (screen.rows - 1), 0, screen.columns * 2);
    screen.cursor_pos -= screen.columns;
}

void newline()
{
    int row = screen.cursor_pos/screen.columns;
    row++;
    screen.cursor_pos = row*screen.columns;
    if (screen.cursor_pos >= screen.columns * screen.rows)
    {
        scroll_down ();
    }
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
    if (screen.cursor_pos >= screen.columns * screen.rows)
    {
        scroll_down ();
    }
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
