.686 
.model flat

extern	_ExitProcess@4: PROC
public _main

.data
zmienna32 dword	32
zmienna16 dw 16

.code

_main PROC

; wielkosc danych na stosie zalezy od architektury - 32 bitowa = 32 bitu
push 11223344h ; 

push 1
push dword ptr 1

pop ebx ; dword ptr 1 do 32 bitowego rejestru
pop eax ; 1 do 32 bitowego rejestru
; nie ma roznicy

pop ecx
push 1
call _ExitProcess@4

_main ENDP
END