.686
.model flat


public _srednia_harm

.data 
zero dd 0.0
dwa dd 2.0
.code

_srednia_harm PROC
push ebp
mov ebp, esp
mov eax, [ebp+8] ; wskaznik na tablice
mov ebx, [ebp+12]; liczba n

push ebx
push edx

mov ecx, ebx ; do petli

mov edx, [eax+ecx*4-1]

finit ; wyzerowanie koprocesora

push ebx
fild dword ptr [esp] ; ladowanie n na wierzcholek
add esp, 4

; S - suma, n - liczba liczb, l - liczba ladowana na stos
fldz ; ladowanie sumy = 0 na wierzcholek
; S - n
ptl:
	fld1 ; 1 - S - n
	fld dword ptr [eax+ecx*4 -4] ; l - 1 - S - n
	fdivp st(1), st(0); 1/l - S - n
	faddp st(1), st(0) ; S -n
loop ptl

; S - n
fdivp st(1), st(0)

pop edx
pop ebx
pop ebp
ret
_srednia_harm ENDP

END