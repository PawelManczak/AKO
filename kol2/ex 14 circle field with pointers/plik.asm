.686
.model flat

public _pole_kola


.code
_pole_kola PROC
	push ebp
	mov ebp, esp
	
	mov eax, [ebp+8] ; wskaznik na r
	mov eax, [eax]

	push eax
	fld dword ptr [esp]
	add esp, 4

	fmul st(0), st(0)
	fldpi
	fmulp st(1), st(0)

	mov eax, [ebp+8] ; weax adres

	fst dword ptr [eax]

	
	pop ebp
	ret
_pole_kola ENDP
END