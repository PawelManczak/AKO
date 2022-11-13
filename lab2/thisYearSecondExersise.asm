.686
.model flat
extern __read : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main
.data

dwa db 2
.code

;do eax
wczytaj2 PROC
push ebx
push ecx
push edx
push esi
push edi
push ebp



	sub esp, 4
	mov edi, esp

	

	push 4
	push edi
	push 0
	call __read
	add esp, 12

	cmp edi, 0
	je koniec

	mov eax, 0;suma
	mov ecx, 0
	ptl:
	mov dl, [edi][ecx]
	cmp dl, 10
	je koniec
	sub dl, 30h
	movzx edx, dl

	mov esi, 2
	mul dwa
	add eax, edx

	inc ecx
	cmp ecx, 4
	jb ptl

koniec:

	add esp, 4

pop ebp
pop edi
pop esi
pop edx
pop ecx
pop ebx
ret
wczytaj2 ENDP

wypisz PROC
pusha

	sub esp, 12
	mov edi, esp


	mov ebx, 10; dzielnik
	mov esi, 11
	ptl:
		mov edx, 0; zerowanie reszty
		div ebx ; reszta w edx
		add edx, 30h
		
		mov [edi][esi], dl
		dec esi
	cmp eax, 0
	jne ptl
	

	mov dl, 0
	zera:
		mov [edi][esi], dl
		dec esi
	cmp esi, -1
	jne zera




	push 12
	push edi; 12 + 12
	push 1
	call __write

	add esp, 24
popa
ret
wypisz ENDP


_main PROC

call wczytaj2	

call wypisz






push 0
call _ExitProcess@4
_main ENDP
END