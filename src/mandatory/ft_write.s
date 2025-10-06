%include "macros.inc"

        bits    64
        
        extern  ERRSYM

        global  ft_write

        section .text
; ssize_t ft_write(int fd, const void *buf, size_t count);
ft_write:
        mov     rax, WRITE      ; write
        syscall                 ; rdi = fd, rsi = *buf, rdx = count already set
        cmp     rax, 0
        jge     .end

        neg     rax
        push    rax             ; caller-save register
        call    ERRSYM PLT_SUFFIX
        pop     rdx
        mov     dword [rax], edx
        mov     rax, -1

.end:
        ret