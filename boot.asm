; set the assembler location counter 
ORG 0x7c00
; tell assembler to use 16 bit architecture
BITS 16

start: 
    ; move the address of the message into the si reg
    mov si, message
    call print 
    jmp $

print: 
    mov bx, 0
.loop:
    ; loads char the si register points to into the al register
    ; then increments the si register.
    lodsb
    ; if the character loaded into al register is
    ; the null terminator, end the loop. 
    cmp al, 0
    je .done
    call print_char
    jmp .loop

.done:
    ; return from subroutine
    ret 

print_char:
    ; this is a special interrupt for outputting a char to the screen
    mov ah, 0eh
    ; Invokes the bios
    int 0x10
    ret

message: db "Hello, World!",0

times 510 - ($ - $$) db 0
; define word 
dw 0xAA55