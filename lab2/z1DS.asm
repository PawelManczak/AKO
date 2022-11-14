.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main
.data
znaki db 12 dup (?)
obszar db 12 dup (?)
dziesiec db 10 ; mno¿nik
dekoder db '0123456789ABCDEF'
spacja db ' '
minus db '-'

.code


zeruj_znaki PROC
pusha
	mov esi, 0

	ptl:
		mov znaki[esi], 0
		inc esi
		cmp esi, 12
		jb ptl
popa
ret		
zeruj_znaki ENDP
wyswietl_u2 PROC
pusha

not ax
inc ax

mov edi, 10

ptl:
	mov ah, 0 ;zerowanie reszty
	;mozliwe, ze nie bedzie zerowac?
	div dziesiec
	add ah, 30h
	mov znaki[edi], ah
	
	dec edi
	cmp al, 0
	jne ptl

push dword PTR 1 ; liczba wyœwietlanych znaków
push dword PTR OFFSET minus ; adres wyœw. obszaru
push dword PTR 1; numer urz¹dzenia (ekran ma numer 1)
call __write ; wyœwietlenie liczby na ekranie
add esp, 12 ; usuniêcie parametrów ze stosu


push dword PTR 12 ; liczba wyœwietlanych znaków
push dword PTR OFFSET znaki ; adres wyœw. obszaru
push dword PTR 1; numer urz¹dzenia (ekran ma numer 1)
call __write ; wyœwietlenie liczby na ekranie
add esp, 12 ; usuniêcie parametrów ze stosu

push dword PTR 1 ; liczba wyœwietlanych znaków
push dword PTR OFFSET spacja ; adres wyœw. obszaru
push dword PTR 1; numer urz¹dzenia (ekran ma numer 1)
call __write ; wyœwietlenie liczby na ekranie
add esp, 12 ; usuniêcie parametrów ze stosu

popa
ret
wyswietl_u2 ENDP		

wyswietl_nkb PROC
pusha

mov edi, 10


ptl2:
	mov ah, 0

	div dziesiec
	
	add ah, 30hdincm
	mov znaki[edi], ah

	dec edi
	cmp al, 0
	jne ptl2

	push dword PTR 12 ; liczba wyœwietlanych znaków
push dword PTR OFFSET znaki ; adres wyœw. obszaru
push dword PTR 1; numer urz¹dzenia (ekran ma numer 1)
call __write ; wyœwietlenie liczby na ekranie
add esp, 12 ; usuniêcie parametrów ze stosu

push dword PTR 1 ; liczba wyœwietlanych znaków
push dword PTR OFFSET spacja ; adres wyœw. obszaru
push dword PTR 1; numer urz¹dzenia (ekran ma numer 1)
call __write ; wyœwietlenie liczby na ekranie
add esp, 12 ; usuniêcie parametrów ze stosu


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

; max iloœæ znaków wczytywanej liczby

; wartoœæ binarna wprowadzonej liczby znajduje siê teraz w EAX

mov ecx, 30; licznik petli
mov ebx, 0; nkb
mov edx, 1; u2



ptl:
	


	test ecx, 1
	jnz niep
		
		inc ebx
		mov eax, ebx
		call wyswietl_eax
		jmp koniec_petli
		
	niep:

		dec edx
		mov eax, edx
		call wyswietl_eax


	
	koniec_petli:


		call zeruj_znaki
		

loop ptl

;mov eax, 13
;all wyswietl_EAX
;mov eax,12 
;call wyswietl_EAX
push 0
call _ExitProcess@4
_main ENDP
END