%include "macros.inc"

        bits    64
        
        extern  ERRSYM
        extern  FT_STRLEN
        extern  FT_STRCPY
        extern  MALLOC

        global  FT_STRDUP

        section .text
; char *ft_strdup(const char *s1);
FT_STRDUP:
        push    rdi             ; save *s1
        call    FT_STRLEN
        inc     rax
        mov     rdi, rax
        call    MALLOC PLT_SUFFIX
        cmp     rax, 0
        je      .end
        
        mov     rdi, rax        ; *dst
        mov     rsi, [rsp]      ; *src
        call    FT_STRCPY

.end:
        add     rsp, 8          ; clean up stack
        ret
