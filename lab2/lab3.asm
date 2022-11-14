.686
.model flat
extern __write: PROC
extern __read: PROC
extern _ExitProcess@4: PROC



public _main
.data 
dziesiec db 10
znaki db 12 dup (?)
spacja db ' '
minus db '-'
liczba_n db 0
liczba db 0
napis db "napis"
.code

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
zeruj PROC
pusha
	mov esi, 0

	ptl:
		mov znaki[esi], 0
		inc esi
		cmp esi, 12
		jb ptl
popa
ret
zeruj ENDP
wyswietl_u2 PROC
pusha

cmp eax, 0
jne dds

mov esi, 121

dds:
not ax
inc ax

mov edi, 10

ptl:

mov ah, 0
div dziesiec
add ah, 30h
mov znaki[edi], ah

dec edi
cmp al, 0
jne ptl


cmp esi, 121
je zz
push dword ptr 1
push dword ptr offset minus
push dword ptr 1
call __write
add esp, 12

zz:
push dword ptr 12
push dword ptr offset znaki
push dword ptr 1
call __write
add esp, 12

push dword ptr 1
push dword ptr offset spacja
push dword ptr 1
call __write
add esp, 12

popa
ret
wyswietl_u2 ENDP

wyswietl_nkb PROC
pusha

mov edi, 10

ptl2:
	mov ah, 0
	div dziesiec
	add ah, 30h
	mov znaki[edi], ah
	dec edi
	cmp al, 0
	jne ptl2


	push dword ptr 12
push dword ptr offset znaki
push dword ptr 1
call __write
add esp, 12

push dword ptr 1
push dword ptr offset spacja
push dword ptr 1
call __write
add esp, 12

popa
ret
wyswietl_nkb ENDP

wyswietl_eax PROC

test ecx, 1
jnz niep
	call wyswietl_nkb	
	ret
niep:
	call wyswietl_u2	

ret
wyswietl_eax ENDP

_main PROC

	
call wczytaj10
mov liczba_n, al

call wczytaj10
mov liczba, al

call zeruj

movzx ecx,  liczba_n
movzx ebx,   liczba; nkb
movzx edx,   liczba; u2

test ecx, 1
jz qwe
mov ebp, 1
dec ecx
qwe:

mov esi, 1; flaga
ptl:
	test ecx, 1

	;jb koniec_petli
	jnz niep
		inc ebx
		mov eax, ebx
		
		call wyswietl_eax
		jmp koniec_petli
		niep:
			
			cmp edx, 0
			jne normalnie

			mov esi,0 
			normalnie:
			dec edx
			mov eax, edx
			

			cmp esi, 0

			jne j1
				call wyswietl_u2	
				jmp koniec_petli
			j1:
				call wyswietl_nkb	
		koniec_petli:
			call zeruj	
			;;;
			cmp ecx, 1
			jne fest
			cmp ebp, 0
			je konieccc
		fest:
loop ptl

konieccc:
push 0
call _ExitProcess@4
_main ENDP

END