%include "macros.inc"

        bits    64

        global  FT_ATOI_BASE

        section .text
; int ft_atoi_base(char *str, char *base)
FT_ATOI_BASE:
        xor     rax, rax
        xor     r8, r8
        xor     r9, r9

.base_check_loop:
        movzx   rdx, BYTE[rsi + r9]
        test    rdx, rdx
        jz      .base_length_check
        cmp     dl, 0x2b                ; '+'
        je      .end
        cmp     dl, 0x2d                ; '-'
        je      .end
        cmp     dl, 0x20                ; ' '
        je      .end
        cmp     dl, 0x09
        jl     .base_dup_check
        cmp     dl, 0x0d
        jle     .end
        
.base_dup_check:
        mov     rcx, r9

.base_dup_check_loop:
        dec     rcx
        cmp     rcx, 0
        jl     .base_dup_check_end
        cmp     BYTE[rsi + rcx], dl
        je      .end
        jmp     .base_dup_check_loop

.base_dup_check_end:
        inc     r9
        jmp     .base_check_loop

.base_length_check:
        cmp     r9, 2
        jl     .end

.skip_whitespace_loop:
        movzx   rdx, BYTE[rdi]
        cmp     dl, 0x09
        jl     .sign_loop
        cmp     dl, 0x0d
        jle     .skip_whitespace
        cmp     dl, 0x20                ; ' '
        jne     .sign_loop

.skip_whitespace:
        inc     rdi
        jmp     .skip_whitespace_loop

.is_negative:
        xor     r8, 1
        
.is_positive:
        inc     rdi
        movzx   rdx, BYTE[rdi]

.sign_loop:
        cmp     dl, 0x2d                ; '-'
        je      .is_negative
        cmp     dl, 0x2b                ; '+'
        je      .is_positive
        
.parse:
        xor     rcx, rcx

.base_search_loop:
        cmp     dl, BYTE[rsi + rcx]
        je      .base_found
        inc     rcx
        cmp     rcx, r9
        jge     .parse_end
        jmp     .base_search_loop

.base_found:
        imul    rax, r9
        add     rax, rcx
        inc     rdi
        mov     dl, BYTE[rdi]
        test    dl, dl
        jnz     .parse

.parse_end:
        cmp     r8, 0
        je      .end
        neg     rax

.end:
        ret