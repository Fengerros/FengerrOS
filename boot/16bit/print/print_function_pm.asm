[bits 32] ; using 32-bit protected mode

; this is how constants are defined
VIDEO_MEMORY equ 0xb8000
GREEN_ON_BLACK equ 0xa ; the color byte for each character

print_string_pm:
    pusha ; store all registers on the stack
    mov edx, VIDEO_MEMORY ; edx is the video memory address

print_string_pm_loop:
    mov al, [ebx] ; [ebx] is the address of our character
    mov ah, GREEN_ON_BLACK ; ah is the color

    cmp al, 0 ; check if end of string
    je print_string_pm_done ; if end of string, jump to done

    mov [edx], ax ; store character + attribute in video memory
    add edx, 2 ; increment video memory address to next character
    inc ebx ; increment string address to next character
    jmp print_string_pm_loop ; jump back to loop

print_string_pm_done:
    popa ; restore all registers
    ret ; return from subroutine