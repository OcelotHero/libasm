;void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), 
;    void (*free_fct)(void *)) 
;{
;    if (!begin_list || !cmp || !free_fct)
;        return;
;
;    t_list *prev = NULL;
;    t_list *curr = *begin_list;
;    t_list *next = NULL;
;
;    while(curr)
;    {
;        next = curr->next;
;        if (cmp(curr->data, data_ref) == 0)
;        {
;            if (!prev)
;                *begin_list = curr->next;
;            else
;                prev->next = curr->next;
;            free_fct(curr->data);
;            free(curr);
;        }
;        else
;            prev = curr;
;        curr = next;
;    }
;}

%include "macros.inc"

        bits        64

        extern      FCT_NAME(free)

        global      FCT_NAME(ft_list_remove_if)

        section .text
; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
FCT_NAME(ft_list_remove_if):
        test    rdi, rdi
        jz      .end
        test    rdx, rdx
        jz      .end
        test    rcx, rcx
        jz      .end

        ; Save callee-saved registers
        push    rbx
        push    r12
        push    r13
        push    r14
        push    r15

        mov     r12, rdi                ; r12 = begin_list
        mov     r13, rsi                ; r13 = data_ref
        mov     r14, rdx                ; r14 = cmp
        mov     r15, rcx                ; r15 = free_fct
        xor     rbx, rbx                ; prev = NULL
        mov     rax, [r12]              ; curr = *begin_list

.loop:
        test    rax, rax                ; while (curr)
        jz      .cleanup
        mov     rcx, [rax + 8]          ; rcx = curr->next

        push    rax
        push    rcx
        mov     rdi, [rax]              ; rdi = curr->data
        mov     rsi, r13                ; rsi = data_ref
        call    r14                     ; call cmp
        pop     rcx
        pop     rdx

        test    rax, rax                ; if (cmp(...) == 0)
        jnz     .keep_node

.remove_node:
        test    rbx, rbx                ; if (!prev)
        jnz     .update_prev_next
        mov     [r12], rcx              ; *begin_list = next
        jmp     .free_node

.update_prev_next:
        mov     [rbx + 8], rcx          ; prev->next = next

.free_node:
        push    rcx
        push    rdx
        mov     rdi, [rdx]              ; rdi = curr->data
        call    r15                     ; call free_fct
        pop     rdx
        pop     rcx

        push    rcx
        mov     rdi, rdx                ; rdi = curr
        sub     rsp, 8
        call    FCT_NAME(free) PLT_SUFFIX         ; call free
        add     rsp, 8
        pop     rcx

        mov     rax, rcx                ; curr = next
        jmp     .loop

.keep_node:
        mov     rbx, rdx                ; prev = curr
        mov     rax, rcx                ; curr = next
        jmp     .loop

.cleanup:
        ; Restore callee-saved registers
        pop     r15
        pop     r14
        pop     r13
        pop     r12
        pop     rbx

.end:
        ret