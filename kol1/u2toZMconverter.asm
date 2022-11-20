.686 
.model flat

extern	_ExitProcess@4: PROC
public _main

.data
.code

_main PROC

mov ebx, -1000

bt ebx, 31 ; ustawia carry
jc ujemne
jmp koniec

ujemne:

neg ebx
or ebx, 0A0000000h

koniec:
push 1
call _ExitProcess@4

_main ENDP
END