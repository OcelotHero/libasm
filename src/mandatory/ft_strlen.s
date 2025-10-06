%include "macros.inc"

        bits    64

        global  FT_STRLEN

        section .text
; size_t ft_strlen(const char *str)
FT_STRLEN:
        xor     rax, rax

.loop:
        cmp     BYTE[rdi + rax], 0
        je      .end
        inc     rax
        jmp     .loop

.end:
        ret