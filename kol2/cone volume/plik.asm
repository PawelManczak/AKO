.686
.model flat

extern _malloc : proc
extern _GetSystemTime@4 : proc

public _objetosc_stozka

.data 
trzy db 3

.code
_objetosc_stozka PROC
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    
    ; trzeba pamietac o "i" gdy ladujemy integera na stos

    fild dword ptr [ebp+8] ; r
    fmul st(0), st(0) ; r^2
    fild dword ptr [ebp+12]; R - r^2
    fmul st(0), st(0) ; R^2 - r^2
    fild dword ptr [ebp+8] ; r - R^2 - r^2
    fild dword ptr [ebp+12]; R - r - R^2 - r^2
    fmulp st(1), st(0) ; Rr - R^2 - r^2
    faddp st(1), st(0); Rr + R^2 - r^2
    faddp st(1), st(0); Rr + R^2 + r^2
    fld dword ptr [ebp+16]; h - Rr + R^2 + r^2
    fmulp st(1), st(0); h(Rr + R^2 + r^2)
    fldpi ; pi - h(Rr + R^2 + r^2)
    fmulp st(1), st(0); pi * h(Rr + R^2 + r^2)
    mov eax, 3
    push eax
    fild dword ptr[esp] ; 3 - pi * h(Rr + R^2 + r^2)
    add esp, 4

    fdivp st(1), st(0); pi * h(Rr + R^2 + r^2) / 3 - czyli wynik



    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
_objetosc_stozka ENDP
END