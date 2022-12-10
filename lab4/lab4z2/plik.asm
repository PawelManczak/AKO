.686
.model flat


public _nowy_exp

.code

_nowy_exp PROC

; program liczacy sume pierwszych 20 elementow ciagu
; 1 + x/1 + x^2/(1*2) + x^3/(1*2*3) ...

push ebp
mov ebp, esp
mov eax, [ebp+8] ; liczba x

push ebx
push edx

fld1 ; suma
push eax
fld dword ptr [esp]; x - s
mov ebp, [esp]
add esp, 4


mov edi, 1
mov ecx, 19 ; x^p - s
ptl:

push edi
fild dword ptr [esp] ; edi - x^p - S
add esp, 4

fdivp st(1), st(0); x^p/edi - S
fadd st(1), st(0); x^p/edi - S + st(0)

push eax
fld dword ptr [esp]; x - x^p - S
add esp, 4 

fmulp st(1), st(0) ;x^p+1 - S
inc edi

loop ptl

fstp st(0) ; zdejmujemy, nigdzie nie zapusyjemy

pop edx
pop ebx
pop ebp
ret
_nowy_exp ENDP

END