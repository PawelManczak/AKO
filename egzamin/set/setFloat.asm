.686
.model flat
extern _ExitProcess@4 : PROC
public _main


.data 
zmienna dd 2.0 
piec dd -5.0
.code
_main PROC
	mov eax, piec; przykladowa wart

	push eax
	fld dword ptr [esp]
	add esp, 4

	push dword ptr -5
	fild dword ptr [esp] ; eax, - -5
	add esp, 4
	fcomi st(0), st(1)

	sete al
	mov ebx, 2
	add bl, al

	push ebx
	fild dword ptr [esp]
	add esp, 4

	fst dword ptr zmienna ; st(0) -> zmienna
	mov ebx, zmienna
	push 0
	call _ExitProcess@4
_main ENDP
END