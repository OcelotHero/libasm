%include "macros.inc"

        bits    64

        global  FT_STRCPY

        section .text
; char *ft_strcpy(char *dst, const char *src)
FT_STRCPY:
        xor     rcx, rcx

.loop:
        mov     al, [rsi + rcx]
        mov     [rdi + rcx], al
        test    al, al
        jz      .end
        inc     rcx
        jmp     .loop

.end:
        mov     rax, rdi
        ret