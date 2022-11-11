.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main
.data
znaki db 12 dup (?)
obszar db 12 dup (?)
dziesiec db 10 ; mnoınik
dekoder db '0123456789ABCDEF'
spacja db ' '
minus db '-'
zero db '0'

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
cmp ax, 0
jne niezero


push dword PTR 1 ; liczba wyæwietlanych znak—w
push dword PTR OFFSET zero ; adres wyæw. obszaru
push dword PTR 1; numer urzˆdzenia (ekran ma numer 1)
call __write ; wyæwietlenie liczby na ekranie
add esp, 12 ; usuni«cie parametr—w ze stosu

push dword PTR 1 ; liczba wyæwietlanych znak—w
push dword PTR OFFSET spacja ; adres wyæw. obszaru
push dword PTR 1; numer urzˆdzenia (ekran ma numer 1)
call __write ; wyæwietlenie liczby na ekranie
add esp, 12 ; usuni«cie parametr—w ze stosu

popa
ret
niezero:


not ax
inc ax

mov esi, 10

ptl:
	mov ah, 0 ;zerowanie reszty
	;mozliwe, ze nie bedzie zerowac?
	div dziesiec
	add ah, 30h
	mov znaki[esi], ah
	
	dec esi
	cmp al, 0
	jne ptl

push dword PTR 1 ; liczba wyæwietlanych znak—w
push dword PTR OFFSET minus ; adres wyæw. obszaru
push dword PTR 1; numer urzˆdzenia (ekran ma numer 1)
call __write ; wyæwietlenie liczby na ekranie
add esp, 12 ; usuni«cie parametr—w ze stosu


push dword PTR 12 ; liczba wyæwietlanych znak—w
push dword PTR OFFSET znaki ; adres wyæw. obszaru
push dword PTR 1; numer urzˆdzenia (ekran ma numer 1)
call __write ; wyæwietlenie liczby na ekranie
add esp, 12 ; usuni«cie parametr—w ze stosu

push dword PTR 1 ; liczba wyæwietlanych znak—w
push dword PTR OFFSET spacja ; adres wyæw. obszaru
push dword PTR 1; numer urzˆdzenia (ekran ma numer 1)
call __write ; wyæwietlenie liczby na ekranie
add esp, 12 ; usuni«cie parametr—w ze stosu

popa
ret
wyswietl_u2 ENDP		

wyswietl_nkb PROC
pusha
;dynamiczna zmienna 12 bitowa
sub esp, 12
mov edi, esp


mov esi, 11


ptl2:
	mov ah, 0

	div dziesiec
	
	add ah, 30h
	mov [edi][esi], ah

	dec esi
	cmp al, 0
	jne ptl2

	inc esi
	ptl3:
	dec esi
	mov ah, 0
	mov [edi][esi], ah
	
	
	cmp esi, 0
	ja ptl3

	
;mov byte PTR [edi][11], 10
push  12 ; liczba wyæwietlanych znak—w
push   edi ; adres wyæw. obszaru
push  1; numer urzˆdzenia (ekran ma numer 1)

call __write ; wyæwietlenie liczby na ekranie
add esp, 12 ; usuni«cie parametr—w ze stosu

push dword PTR 1 ; liczba wyæwietlanych znak—w
push dword PTR OFFSET spacja ; adres wyæw. obszaru
push dword PTR 1; numer urzˆdzenia (ekran ma numer 1)
call __write ; wyæwietlenie liczby na ekranie
add esp, 12 ; usuni«cie parametr—w ze stosu

add esp, 12 ; usuni«cie parametr—w ze stosu
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

; max iloæ znak—w wczytywanej liczby

; wartoæ binarna wprowadzonej liczby znajduje si« teraz w EAX

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

push 0
call _ExitProcess@4
_main ENDP
END