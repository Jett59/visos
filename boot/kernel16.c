#include <kernel16.h>
#include <video.h>

void memset (void* ptr, char value, size_t size)
{
    char * working_ptr = ptr;
    while(size --){
        * (working_ptr+size) = value;
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