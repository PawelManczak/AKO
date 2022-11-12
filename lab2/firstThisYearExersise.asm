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

liczba_k db 1

.code

;do eax
wczytaj2 PROC
push eax
push ebx
push ecx
push ebp
push esi
push edi

	;w eax mamamy stringa

	mov edx, eax ; w edx trzymamy eax
	mov ecx, 4
	mov eax, 0; suma

	ptl:
	rol edx, 8
	mov ebx, edx

	and ebx, 000000FFh

	sub ebx, 30h; z chara na cyfre

	mul dwa
	add eax, ebx
	
	loop ptl

	mov edx, eax
pop edi
pop esi
pop ebp
pop ecx
pop ebx
pop eax
		
ret
wczytaj2 ENDP

wypisz12 PROC
pusha



sub esp, 12
mov ebp, esp

mov eax, edx; w eax mamy liczbe

mov ebx, 12; dzielnik
mov esi, 11; index
mov edi, 0
ptl:
	mov edx, 0
	div ebx

	cmp edi, dword ptr liczba_k
	jne dalej

	push eax
	mov al, ' '
	mov [ebp][esi], al
	dec esi
	pop eax

	dalej:

	mov cl, dekoder[edx]
	mov [ebp][esi], cl
	dec esi
	inc edi

cmp eax, 0
jne ptl
mov cl, 0
zer:
	mov [ebp][esi], cl
	dec esi
	cmp esi, -1
	jne zer

push 12
push ebp
push 1
call __write
add esp, 12

add esp,12
popa
ret
wypisz12 ENDP

_main PROC

mov eax, '1100'
call wczytaj2	






call wypisz12

push 0
call _ExitProcess@4
_main ENDP
END