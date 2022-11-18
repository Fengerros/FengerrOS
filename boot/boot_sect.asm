[org 0x7c00]
KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl

    mov bp, 0x9000
    mov sp, bp

    call load_kernel
    call switch_to_pm
    jmp $


%include "print/print_function.asm"
%include "print/print_hex_function.asm" 
%include "disk_load.asm" 
%include "gdt.asm"
%include "protected_mode_switch.asm"
%include "print/print_function_pm.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_string

    mov bx, KERNEL_OFFSET
    mov dh, 16
    mov dl, [BOOT_DRIVE]
    call disk_load

    mov bx, MSG_LOAD_KERNEL_OK
    call print_string
    ret

[bits 32]
BEGIN_PM: ; after the switch we will get here
    ;mov ebx, MSG_PROT_MODE
    ;call print_string_pm ; Note that this will be written at the top left corner
    
    call KERNEL_OFFSET
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel... ", 0
MSG_LOAD_KERNEL_OK db "Kernel loaded :3", 0

BOOT_DRIVE db 0

; =======BOOT_SECTOR=======
times 510-($-$$) db 0
dw 0xaa55
; =====END_BOOT_SECTOR=====