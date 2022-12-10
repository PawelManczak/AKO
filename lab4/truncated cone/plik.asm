.686
.XMM
.model flat
public _objetosc_stozka
.data
trzy dd 3.0
.code
_objetosc_stozka PROC
push ebp
mov ebp, esp

push ebx

mov eax, [ebp+8] ; duze R
mov ebx, [ebp+12] ; male r
mov ecx, [ebp+16] ; H

finit ; zerowanie koprocesora

; duzy stozek
push eax
fild dword ptr [esp] ; R
add esp, 4
fmul st(0), st(0) ; R^2
fld1 ; 1 - R^2
fld trzy; 3 - 1 - R^2
fdivp st(1), st(0) ; 1/3 - R^2
fmulp st(1), st(0) ; (1/3)*R^2

push ecx
fld dword ptr [esp] ; H - (1/3)*R^2
add esp, 4 
fmulp st(1), st(0); obj duzego stozka na stosie, czyli D

; maly stozek
push ebx
fild dword ptr [esp] ; r - D
add esp, 4
fmul st(0), st(0) ; r^2 - D
fld1 ; 1 - r^2 - D
fld trzy; 3 - 1 - r^2 - D
fdivp st(1), st(0) ; 1/3 - r^2 - D
fmulp st(1), st(0) ; (1/3)*r^2 - D

; male h
; h = r*H/R
push ebx
fild dword ptr [esp] ; r - (1/3)*r^2 - D
add esp, 4

push ecx
fld dword ptr [esp] ; H - r - (1/3)*r^2 - D
add esp, 4 

fmulp st(1), st(0) ; rH - (1/3)*r^2 - D

push eax
fild dword ptr [esp] ; R - rH - (1/3)*r^2 - D
add esp, 4 

fdivp st(1), st(0) ; h - (1/3)*r^2 - D
fmulp st(1), st(0) ; d - D
fsubp st(1), st(0) ; D-d = wynik/pi

fldpi ; pi - wynik/pi
fmulp st(1), st(0) ; wynik

pop ebx
pop ebp
ret
_objetosc_stozka ENDP
END