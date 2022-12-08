.686 
.model flat

public _main

.code

_main PROC

;21

sub esp, 4 ; dynamiczna zmienna
mov ebx, esp

; 1 - 2 - 3 - 4 (bajty) - teraz
; 4 - 3 - 2 - 1 (bajty) - cel
mov [ebx], dword ptr 0FFEEAA00h; przykladowa wartosc
mov ax, word ptr [ebx]; pobranie drugiej pary bajtow
; LE - wyzej bedzie "FFEE"

xchg al, ah; eax = X - X - 3 - 4
rol eax, 16; eax = 4 - 3 - X - X

mov ax, word ptr [ebx+2]; eax = 4 - 3 - 1 - 2
xchg al, ah ; eax = 4 - 3 -2 -1


add esp, 4
_main ENDP
END