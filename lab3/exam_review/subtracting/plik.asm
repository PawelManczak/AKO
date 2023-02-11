.686
.model flat

public _odejmowanie

.code
_odejmowanie PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp+8] ; pntr na pntr
	mov eax, [eax] ; pntr
	mov eax, [eax] ; wart

	mov ebx, [ebp+12] ; pntr
	sub eax, [ebx]

	pop ebx
	pop ebp
	ret
_odejmowanie ENDP
END