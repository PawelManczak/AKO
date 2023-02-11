.686
.model flat
extern _ExitProcess@4 : PROC
public _main


.code

_main PROC
	mov eax, 0

	mov ebx, 2

	cmp eax, -5
	setg al
	add bl, al

	push 0
	call _ExitProcess@4
_main ENDP
END