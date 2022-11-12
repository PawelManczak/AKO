.686
.model flat
extern __read : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main
.data
dekoder db '0123456789ABCDEF'

znaki db 12 dup (?)
dziesiec db 10 ; mno¿nik
trzynascie db 13
spacja db ' '
minus db '-'
zero db '0'
liczba_znakow db ?

.code

;do eax
wczytaj10 PROC
push ebp
push esi
push ebx
push ecx

sub esp, 12
mov ebp, esp

push 12
push esi
push 0
call __read
add esp, 12

mov eax, 0 ; suma
mov ebx, 0

ptl:
mov cl, [esi]

cmp cl, 10; czy byl enter
je koniec
sub cl, 30h

movzx ecx, cl ; zero extended

mul dziesiec
add eax, ecx


inc esi
jmp ptl ;takie trochje while(true)

koniec:
add esp, 12

pop ecx
pop ebx
pop esi
pop ebp
ret
wczytaj10 ENDP

wyswietl10 PROC
pusha

	sub esp, 12
	mov ebp, esp; dynamicznie na znaki

	mov edx, 30h
	mov ecx, 12
	zer:
		mov [ebp][ecx-1], edx
	loop zer

	; w eax mamy liczbe 
	mov ebx, 11 ; licznik
	mov ecx, 10; dzielniik
	;mov esi, 0; liczba liter
	ptl:
	mov edx, 0; czyscimy reszte

	div ecx ; reszta jest edx

	add dl, 30h

	mov [ebp][ebx], dl

	;inc esi
	dec ebx
	cmp eax, 0
	ja ptl

	inc ebp
	push 12
	push ebp
	push 1
	call __write
	add esp, 24

popa
ret
wyswietl10 ENDP

_main PROC

movzx eax, zero
call wczytaj10	

call wyswietl10	
push 0
call _ExitProcess@4
_main ENDP
END