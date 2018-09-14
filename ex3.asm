
;Load sector thu 2 va thuc thi

start:
    xor ax, ax
    mov es, ax
    mov bx, 0x8000  ;load 0x8000
    mov cx, 2       ;doc sector 2, track 0
    mov al, 1       
    mov ah, 02      ;doc sector trong disk
    mov dx, 0x80    ;HDD dau tien, head 0
    int 0x13

    jmp 0x800:0
    
times 510-($-$$) db 0
dw 0xAA55

;Buoc 2
;In 1 ky tu
;Dung thuc thi chuong trinh

stage2:
    mov ah, 0x0E    ;Teletype output
    mov al, 'A'     
    mov bl, 0x0F   
    mov bh, 0x0     
    int 0x10        

    jmp $            ;Dung thuc thi

times 1024-($-$$) db 0  
