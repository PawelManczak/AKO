.686 
.model flat

extern	_ExitProcess@4: PROC
public _main

.data
zmienna32 dword	32
zmienna16 dw 16

.code

_main PROC

mov esi, 2 ; ladowanie przykladowych wartosci
mov edi, 12 ; ladowanie przykladowych wartosci

xor edi, esi

mov esi, 2; ladowanie przykladowych wartosci
mov edi, 12 ; ^

mov ebx, esi
not ebx; not b
and ebx, edi ; a * not b

mov eax, edi ; a
not eax; not a
and eax, esi; not a * b

or eax, ebx

mov edi, eax

push 1
call _ExitProcess@4

_main ENDP
END