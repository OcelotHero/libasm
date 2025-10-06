        bits    64

        global  ft_strcmp

        section .text
; int ft_strcmp(const char *s1, const char *s2)
ft_strcmp:
        xor     rcx, rcx

.loop:
        movzx   rax, BYTE[rdi + rcx]
        movzx   rdx, BYTE[rsi + rcx]
        cmp     rax, rdx
        jne     .end
        test    rax, rax
        jz      .end
        inc     rcx
        jmp     .loop
        
.end:
        sub     rax, rdx
        ret

