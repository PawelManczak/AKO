.686
.model flat


public _ASCII_na_UTF16
extern _malloc : proc

.code
_ASCII_na_UTF16 PROC
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    
    mov eax, [ebp+12]; n
    mov edx, 2
    mul edx ; bo utf16
    add edx, 2; koncowka

    push eax
    call _malloc ; adres w eax
    add esp, 4

    mov edi, [ebp+8] ; adres pierw el tab
    mov ecx, [ebp+12]; n

    mov dx, 0
    mov word ptr [eax + 2*ecx - 2], dx ; ostatnie 2 bajty
    dec ecx

    ptl:
        mov dl, 0
        mov [eax + 2*ecx - 2], dl 
        mov dl, [edi + ecx - 1] ; el z tab
        mov [eax + 2*ecx - 3], dl

    loop ptl

        pop edi
        pop esi
        pop ebx
        pop ebp

    ret
_ASCII_na_UTF16 ENDP
END