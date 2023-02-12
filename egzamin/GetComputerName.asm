.686
.model flat

extern _GetComputerNameA@8: PROC
public _main

.data 
miejsce_na_nazwe db 255 dup (?)
rozmiar dw 255

.code
_main PROC
	push ebp
	mov ebp, esp
	sub esp, 255 + 2

	;BOOL GetComputerName (
	;[IN] LPTSTR lpBuffer, // address of name buffer 
	;[IN/OUT] LPDWORD nSize // addr. of size of name buffer
	;);

	; funkcje systemowe -> WinApi -> StdCall:
	; L->P
	; nie trzeba zdejmowac ze stosu

	;wersja z .data
	push offset rozmiar
	push offset miejsce_na_nazwe
	call _GetComputerNameA@8

	;wersja dynamiczna
	
	sub ebp, 2
	push ebp

	sub ebp, 255
	push ebp
	call _GetComputerNameA@8
	add ebp, 257



	pop ebp
	ret
_main ENDP
END