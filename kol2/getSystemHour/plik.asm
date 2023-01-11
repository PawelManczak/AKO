.686
.model flat

extern _malloc : proc
extern _GetSystemTime@4 : proc

public _godzina

.code
_godzina PROC
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    mov eax, 16
    push eax
    call _malloc ; w eax adres
    add esp, 4

    push eax
    call _GetSystemTime@4
    movzx eax, word ptr [eax+8] ; get only hour

    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
_godzina ENDP
END