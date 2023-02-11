.686
.model flat
public _srednia_harm

.code
_srednia_harm PROC
	push ebp
	mov ebp, esp

	push esi

	mov esi, [ebp+8]; wsk na tab
	mov ecx, [ebp+12]; n
	
	fldz; 0
	ptl:
		
		fld dword ptr [esi+4*ecx-4] ; a - suma
		fld1 ; 1 - a - suma
		fdiv st(0), st(1) ; 1/a - a - suma
		fxch ; a - 1/a - suma
		fstp st(0); 1/a - suma
		faddp st(1), st(0) ; suma
	loop ptl

	fild dword ptr [ebp+12]; n - suma
	fxch st(1) ; suma - n
	fdivp st(1), st(0) ; n/suma

	pop esi
	pop ebp
	ret

_srednia_harm ENDP
END