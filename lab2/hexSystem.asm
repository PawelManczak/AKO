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
szesnascie db 16
spacja db ' '
minus db '-'
zero db '0'
dwa db 2
liczba_znakow db ?

.code

;do eax
wczytaj16 PROC
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

	cmp dl, 'A'
	jne checkB
	mov dl, 10
	jmp mnozenie
	checkB:
	cmp dl, 'B'
	jne checkC
	mov dl, 11
	jmp mnozenie
	checkC:
	cmp dl, 'C'
	jne checkD
	mov dl, 12
	jmp mnozenie
	checkD:
	cmp dl, 'D'
	jne checkE
	mov dl, 13
	jmp mnozenie
	checkE:
	cmp dl, 'E'
	jne checkF
	mov dl, 14
	jmp mnozenie
	checkF:
	cmp dl, 'F'
	jne przedMnozeniem
	mov dl, 15
	jmp mnozenie
	
	przedMnozeniem:
	sub dl, 30h

	mnozenie:
	mul szesnascie
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
wczytaj16 ENDP

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

wyswietl16 PROC
pusha

sub esp, 12
mov edi, esp

mov ecx, 8 ; petla
mov esi, 0; index

ptl:
rol eax, 4
mov ebx, eax ; kopiowanie EAX do EBX

and ebx, 0000000Fh
mov dl, dekoder[ebx]

mov [edi][esi], dl


inc esi
loop ptl

push 8
push edi
push 1
call __write
add esp, 12

add esp, 12
popa
ret
wyswietl16 ENDP
_main PROC

movzx eax, zero
call wczytaj16	

;mov eax, 18
;rol eax, 5
;and eax, 0100b
;call wyswietl2
call wyswietl16	

;mov eax, 8
;call wyswietl16	
push 0
call _ExitProcess@4
_main ENDP
END