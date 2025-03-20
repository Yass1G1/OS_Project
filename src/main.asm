org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

;
;   Prints a string to the screen
;

puts:
    ; save register we will modify
    push si
    push ax

.loop:
    lodsb                   ; loads next character in al
    or al, al               ; verify if next character is null
    jz .done

    mov ah, 0x0e            ; call bios interrupt
    mov bh, 0
    int 0x10

    jmp .loop               ; don't understand : where is .loop first call ??

.done:
    pop ax
    pop si
    ret

main:

    ; setup data segments
    mov ax, 0               ; can't write to ds/es directly
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00          ; stack grows downwards from where we loaded memory (org offset)

    ; print message
    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt


msg_hello: db 'Bonjour Monde!', ENDL, 0  ; message follwed by a new line

times 510-($-$$) db 0 ; Fill the rest of the sector with 0s
dw 0AA55h