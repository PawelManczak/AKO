.686 
.model flat

public _main

.code

_main PROC

mov edx, 080000000h
mov ebx, 0FFFFFFFFh
mov eax, 0

; edx : ebx : eax
;przesuwanie o 1 cyklicznie zlaczenia rejestrow 
SHL eax, 1
rcl ebx, 1
rcl edx, 1

jnc koniec
;cf == 1
mov ecx, 1
or edx, ecx

koniec:



_main ENDP
END