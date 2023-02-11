.686
.model flat

public _szukaj_elem_max

.code
_szukaj_elem_max PROC
	push ebp
	mov ebp, esp
	push ebx

	mov edx, [ebp+8]
	mov eax, [ebp+8]; poczatkowy max - 1 el
	mov ecx, [ebp+12]; n - liczba el

	ptl:
		mov ebx, [edx + 4*ecx - 4]
		cmp ebx, [eax]
		jl niezmieniaj

			lea eax, [edx + 4*ecx - 4]

		niezmieniaj:
	loop ptl

	pop ebx
	pop ebp
	ret
_szukaj_elem_max ENDP
END