.686
.model flat

public _pole_kola

.code
_pole_kola PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp+8] ; w eax adres r

    mov eax, [eax] ; w eax wartosc r

    finit
    push eax
    fld dword ptr [esp] ; ladowanie r na wierzcholek stosu koprocesora
    add esp, 4

    fmul st(0), st(0) ; r^2
    fldpi ; pi - r^2
    fmulp st(1), st(0) ; pole

    mov ecx, [ebp+8] ; w ecx adres zmiennej
    fst dword ptr [ecx]

    pop ebp
    ret
_pole_kola ENDP
END