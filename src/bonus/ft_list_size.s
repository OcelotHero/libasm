%include "macros.inc"

        bits        64

        global      ft_list_size

        section .text
; int ft_list_size(t_list *begin_list)
ft_list_size:
        xor     rax, rax

.ft_list_size_loop:
        cmp     rdi, 0
        je      .end
        mov     rdi, [rdi + 8]
        inc     rax
        jmp     .ft_list_size_loop

.end:
        ret