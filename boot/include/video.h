#ifndef video_header_h
#define video_header_h  "video.h"

typedef struct __attribute__((__packed__)) {
    char character;
    char attribute;
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
    unsigned short cursor_pos;
    unsigned char stdout;
    unsigned char stderr;
    unsigned char current_color;
    unsigned char columns;
    unsigned char rows;
} Screen;

// main screen
extern Screen screen;

// start of video ram segment
extern video_cell vram_begin;

#endif