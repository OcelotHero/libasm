        bits    64

        global  ft_strcpy

        section .text
; char *ft_strcpy(char *dst, const char *src)
ft_strcpy:
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