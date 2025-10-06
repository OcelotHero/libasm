%include "macros.inc"

        bits    64
        
        extern  ERRSYM
        extern  FCT_NAME(ft_strlen)
        extern  FCT_NAME(ft_strcpy)
        extern  FCT_NAME(malloc)

        global  ft_strdup

        section .text
; char *ft_strdup(const char *s1);
ft_strdup:
        push    rdi             ; save *s1
        call    FCT_NAME(ft_strlen)
        inc     rax
        mov     rdi, rax
        call    FCT_NAME(malloc) PLT_SUFFIX
        cmp     rax, 0
        je      .end
        
        mov     rdi, rax        ; *dst
        mov     rsi, [rsp]      ; *src
        call    FCT_NAME(ft_strcpy)

.end:
        add     rsp, 8          ; clean up stack
        ret
