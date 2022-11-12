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
dwa db 2
liczba_znakow db ?

.code

;do eax
wczytaj2 PROC
push ebp
push ecx
push ebx
push edx
sub esp, 12
mov ebp, esp

push 12; liczba znakow
push ebp; miejsce
push 0; klawiatura
call __read
add esp, 12

mov eax, 0 ; suma
mov ecx, 2 ; iloraz
mov ebx, 0; lciznik
ptl:
	mov edx, 0; zerujemy ,zeby przy dodwaniu bylo git
	mov dl, [ebp][ebx]

	cmp dl, 10 ; sprawdzamy, czy enter
	je koniec
	sub dl, 30h

	mul dwa
	add eax, edx
	inc ebx
	jmp ptl


koniec:
add esp, 12 ; dynamiczna tablica

pop edx
pop ebx
pop ecx
pop ebp
ret
wczytaj2 ENDP

wyswietl2 PROC
pusha

sub esp, 12
mov ebp, esp

mov ebx, 2 ; dzielnik
mov edi, 11
ptl:
	mov edx, 0 ;zerujemy reszte
	div ebx

	add dl, 30h
	mov [ebp][edi], dl

	dec edi
	cmp eax, 0
	jne ptl

mov dl, 0
zer:
	mov [ebp][edi], dl
	dec edi
	cmp edi, -1
	jne zer


	push 12
	push ebp
	push 1
	call __write
	add esp, 12

	add esp, 12
popa
ret
wyswietl2 ENDP

_main PROC

movzx eax, zero
call wczytaj2	

call wyswietl2
push 0
call _ExitProcess@4
_main ENDP
END