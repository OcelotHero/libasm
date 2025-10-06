%include "macros.inc"

        bits        64

        extern      MALLOC

        global      FT_LST_PUSH_F

        section .text
; void ft_list_push_front(t_list **begin_list, void *data)
FT_LST_PUSH_F:
        push    rdi
        push    rsi
        sub     rsp, 8                  ; align stack
        mov     rdi, 16
        call    MALLOC PLT_SUFFIX
        add     rsp, 8
        pop     rsi
        pop     rdi
        test    rax, rax
        jz      .end

        mov     [rax], rsi              ; new->data = data
        mov     rdx, [rdi]              ; rdx = *begin_list
        mov     [rax + 8], rdx          ; new->next = rdx
        mov     [rdi], rax              ; *begin_list = new

.end:
        ret