#include "screen.h"
#include "../kernel/low_level.h"

void clear_screen() {
    char* VIDEO_ADDR = (char*)0xb8000;
    
    for (int i = 0; i < 80 * 25; i++) {
        *VIDEO_ADDR = ' ';
        VIDEO_ADDR += 1;
        *VIDEO_ADDR = 0x0f;
        VIDEO_ADDR += 1;
    }
    VIDEO_ADDR = (char*)0xb8000;
}

void disable_cursor()
{
    port_byte_out(REG_SCREEN_CTRL, 0x0A);
    port_byte_out(REG_SCREEN_DATA, 0x20);
}

void enable_cursor(unsigned short cursor_start, unsigned short cursor_end)
{
	port_byte_out(REG_SCREEN_CTRL, 0x0A);
	port_byte_out(REG_SCREEN_DATA, (port_byte_in(REG_SCREEN_DATA) & 0xC0) | cursor_start);
 
	port_byte_out(REG_SCREEN_CTRL, 0x0B);
	port_byte_out(REG_SCREEN_DATA, (port_byte_in(REG_SCREEN_DATA) & 0xE0) | cursor_end);
}