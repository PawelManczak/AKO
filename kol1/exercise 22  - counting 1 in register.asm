.686 
.model flat

public _main

.code

_main PROC

;22 - zliczanie jedynek w eax

mov eax, 00FFFFFFh ; 32 jedynki

mov ebx, 0 ; licznik
mov ecx, 32 ; liczba bitow eax
ptl:
dec ecx; tymaczoswe zmniejszenie ecx
bt eax, ecx ; bt ustawia CF jesli bit jest "1"
inc ecx; przywrocenie wart ecx

jnc koniecptl
inc ebx; zwieksanie licznika
koniecptl:
loop ptl




_main ENDP
END