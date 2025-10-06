%include "macros.inc"

        bits        64

        global      FT_LST_SIZE

        section .text
; int ft_list_size(t_list *begin_list)
FT_LST_SIZE:
        xor     rax, rax

.ft_list_size_loop:
        cmp     rdi, 0
        je      .end
        mov     rdi, [rdi + 8]
        inc     rax
        jmp     .ft_list_size_loop

.end:
        ret