%include "macros.inc"

        bits    64
        
        extern  ERRSYM

        global  FCT_NAME(ft_read)

        section .text
; ssize_t ft_read(int fd, void *buf, size_t count)
FCT_NAME(ft_read):
        mov     rax, READ       ; read
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