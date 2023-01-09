.686
.model flat
extern _GetSystemInfo@4 : proc 
extern _malloc : proc

public _liczba_procesorow

.code
_liczba_procesorow PROC
    push ebp
    mov ebp, esp
    push ebx
    
    mov eax, 36
    push eax
    call _malloc
    add esp, 4
    mov ebx, eax
    
    push eax
    call _GetSystemInfo@4
    mov eax, [eax+20]

    pop ebx
    pop ebp
    ret
_liczba_procesorow ENDP
END