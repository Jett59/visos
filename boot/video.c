#include <video.h>

Screen screen = {
    .base = &vram_begin,
    .cursor_pos = 0,
    .stdout = 0x0A,
    .stderr = 0x40,
    .current_color = 0x0A,
    .columns = 80,
    .rows = 25
};