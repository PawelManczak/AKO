.686
.model flat


public _NWD

.code
_NWD PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
    mov edx, [ebp+12]

    cmp eax, edx
    jb eax_mniejsze
    ja eax_wieksze
    ; rowne 
    jmp koniec

    eax_mniejsze:
        sub edx, eax
        push edx
        push eax        
        call _NWD
        add esp, 8
        jmp koniec

    eax_wieksze:
        sub eax, edx
        push edx
        push eax
        call _NWD
        add esp, 8
        jmp koniec
    koniec:

    pop ebp
    ret
_NWD ENDP
END