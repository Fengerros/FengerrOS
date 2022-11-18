#include "../drivers/screen.h"

void main() {
    disable_cursor();
    //enable_cursor(14, 15);
    clear_screen();

    // *VIDEO_ADDR = 'E';
    // VIDEO_ADDR += 1; 
    // *VIDEO_ADDR = 0xc;

    // VIDEO_ADDR += 1; 

    // *VIDEO_ADDR = 'X';
    // VIDEO_ADDR += 1; 
    // *VIDEO_ADDR = 0xd;

    // VIDEO_ADDR += 1; 

    // *VIDEO_ADDR = ' ';
    // VIDEO_ADDR += 1; 
    // *VIDEO_ADDR = 0xd;

    // VIDEO_ADDR += 1; 
}