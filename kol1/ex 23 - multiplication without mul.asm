.686 
.model flat

public _main

.code

_main PROC

;23 - multiplication by 10 without mul and imul oper
; mnozniki to 1, 2, 4 i 8 - inne nie przechodza

mov eax, 2

mov ebx, eax
lea eax, [8*eax + eax]
add eax, ebx


_main ENDP
END