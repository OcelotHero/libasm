%include "macros.inc"

        bits        64

        global      FT_LST_SORT

        section .text
; void ft_list_sort(t_list **begin_list, int (*cmp)())
FT_LST_SORT:
        test    rdi, rdi
        jz      .end
        test    rsi, rsi
        jz      .end
        cmp     QWORD[rdi], 0
        je      .end
        mov     rax, [rdi]
        cmp     QWORD[rax + 8], 0
        je      .end

        push    rbx                     ; save callee-saved registers
        push    r12
        push    r13
        mov     r12, rdi                ; r12 = begin_list
        mov     r13, rsi                ; r13 = cmp

.outer_loop:
        xor     rbx, rbx                ; swapped = false
        mov     rdi, [r12]              ; current = *begin_list

.inner_loop:
        test    rdi, rdi
        jz      .check_swapped
        mov     rsi, [rdi + 8]          ; next = current->next
        test    rsi, rsi
        jz      .check_swapped

        push    rdi                     ; save current
        push    rsi                     ; save next
        mov     rdi, [rdi]              ; rdi = current->data
        mov     rsi, [rsi]              ; rsi = next->data
        call    r13                     ; call cmp(current->data, next->data)
        pop     rsi                     ; restore next
        pop     rdi                     ; restore current

        cmp     rax, 0
        jle     .no_swap                ;

.swap:
        mov     rax, [rdi]              ; rax = current->data
        mov     rcx, [rsi]              ; rcx = next->data
        mov     [rdi], rcx              ; current->data = next->data
        mov     [rsi], rax              ; next->data = current->data
        mov     rbx, 1                  ; swapped = true

.no_swap:
        mov     rdi, [rdi + 8]          ; current = current->next
        jmp     .inner_loop

.check_swapped:
        test    rbx, rbx                ; if swapped
        jnz     .outer_loop             ; continue sorting

        pop     r13                     ; restore registers
        pop     r12
        pop     rbx

.end:
        ret