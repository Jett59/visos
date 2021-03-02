#ifndef video_header_h
#define video_header_h  "video.h"

#include <types.h>

typedef struct __attribute__((__packed__)) {
    char character;
    u8 attribute;
} video_cell;
// screen structure
/*
    * base is the base address of the video ram segment associated with this screen
    * cursor_pos is the current cursor position.
    * stdout and stderr are attributes used to distinguish output and error strings.
    * current_color is the current attribute byte to be used with screen output.
*/
typedef struct {
    video_cell * const base;
    size_t cursor_pos;
    u8 stdout;
    u8 stderr;
    u8 current_color;
    u8 columns;
    u8 rows;
} Screen;

// main screen
extern Screen screen;

// start of video ram segment
extern video_cell vram_begin;

#endif