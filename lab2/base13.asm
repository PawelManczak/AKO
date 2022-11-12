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
wczytaj13 PROC
	push ebx
	push ecx
	push edx
	push esi
	push edi
	
	sub esp, 12
	mov esi, esp

	push 12
	push esi
	push 0
	call __read
	add esp, 12

	mov eax, 0; suma
	mov ecx, 0

	ptl:
		mov edx, 0
		mov dl, [esi][ecx]

		cmp dl, 10 ; enter
		je koniecFest
		cmp dl, 'a'
		jne checkB
		mov dl, 10
		jmp koniec
		checkB:
		cmp dl, 'b'
		jne checkC
		mov dl, 11
		jmp koniec
		checkC::
		cmp dl, 'c'
		jne cyfra
		mov dl, 12
		jmp koniec

		cyfra:
		sub dl, 30h

		koniec:
		movzx edx, dl
		mul trzynascie
		add eax, edx
		inc ecx
		
		cmp ecx, 12
		jbe ptl

		koniecFest:
	add esp, 12

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
ret
wczytaj13 ENDP



wyswietl13 PROC
pusha
	sub esp, 12
	mov edi, esp

	mov ecx, 12
	mov bl, 0
	zerowanie:
		mov [edi][ecx], bl
	loop zerowanie
		


	mov ebx, 13; dzielnik
	mov esi, 11;index

	ptl:
		mov edx, 0
		div ebx
		mov ecx, 0
		mov cl, dekoder[edx]
		;mov ebp, 'A'
		mov [edi][esi], cl

		dec esi
		cmp eax, 0
		jne ptl


	
	push 12
	push edi
	push 1
	call __write
	add esp, 12

	add esp, 12
popa
ret

wyswietl13 ENDP
_main PROC

call wczytaj13		
call wyswietl13	
push 0
call _ExitProcess@4
_main ENDP
END