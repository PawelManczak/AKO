.686
.model flat
public _nowy_exp

.code
_nowy_exp PROC
	push ebp
	mov ebp, esp

	push edi
	push esi
	push ebx

	mov edi, [ebp+8]; x
	
	finit
	fld1; poczatkowa suma

	mov ecx, 19 ; licznik
	mov esi, 1 ; ktory, licznik 1..20
	mov eax, 1 ; dol
	ptl:
		push ecx
		mov ecx, esi

		push edi
		fld dword ptr [esp]; x - ...
		add esp, 4
		sub ecx, 1; bo jeden u gory
		jz po_ptl2
		ptl2:
			push edi
			fld dword ptr [esp]; x - x^c
			add esp, 4
			fmulp st(1), st(0)
		loop ptl2
		po_ptl2:
		; x^c - suma
		pop ecx
		mul esi
		push eax
		fild dword ptr [esp]; dol - x^c - suma
		add esp, 4

		fdivp st(1), st(0); x^c/dol - suma
		faddp st(1), st(0); suma

		inc esi; zwiekszanie licznika
	loop ptl

	pop ebx
	pop esi
	pop edi
	pop ebp
	ret

_nowy_exp ENDP
END