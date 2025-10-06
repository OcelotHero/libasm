%include "macros.inc"

        bits    64

        global  FCT_NAME(ft_strlen)

        section .text
; size_t ft_strlen(const char *str)
FCT_NAME(ft_strlen):
        xor     rax, rax

.loop:
        cmp     BYTE[rdi + rax], 0
        je      .end
        inc     rax
        jmp     .loop

.end:
        ret