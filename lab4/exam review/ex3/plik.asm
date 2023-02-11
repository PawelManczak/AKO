.686
.XMM
.model flat
public _dodaj_tablice

.code
_dodaj_tablice PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp+8]; tab a
	mov ebx, [ebp+12]; tab b
	mov ecx, [ebp+16] ;tab c

	movups xmm1, [eax]
	movups xmm2, [ebx]
	paddsb xmm2, xmm1
	movups [ecx], xmm2

	pop ebx
	pop ebp
	ret

_dodaj_tablice ENDP
END