.model small
.386
.code

start:
    cli                     ; Disable interrupts
    push ss
    pop ds                 ; Copy SS to DS
    mov ax, es:[0x2]       ; Load AX from ES:0002
    sub ax, 0x40
    mov ss, ax
    sti                     ; Re-enable interrupts
    push es
    push ss
    pop es
    mov si, 0x3F0
    mov di, si
    mov cx, 0x10
    rep movsb              ; Copy 16 bytes from DS:SI to ES:DI
    pop es
    mov ss:[0x3FC], es
    mov bx, ax
    mov dx, cs
    add dx, ss:[0x3F0]
    mov bp, ss:[0x3F0]
    std                    ; Set direction flag (string ops reverse)
LAB_LOOP:
    mov ax, bp
    cmp ax, 0x1000
    jbe LAB_0039
    mov ax, 0x1000
LAB_0039:
    sub bp, ax
    sub dx, ax
    sub bx, ax
    mov ds, dx
    mov es, bx
    mov cl, 0x3
    shl ax, cl
    mov cx, ax
    shl ax, 1
    dec ax
    dec ax
    mov si, ax
    mov di, ax
    rep movsw              ; Copy (AX*2) bytes from SS:SI to ES:DI
    or bp, bp
    jnz LAB_LOOP
    mov si, es
    mov ds, si
    xor si, si
    mov di, cs
    mov es, di
    xor di, di
    mov ax, ds
    add ss:[0x3F6], ax
    jmpf fword ptr ss:[0x3F4]  ; Far jump to protected mode stub

end start
