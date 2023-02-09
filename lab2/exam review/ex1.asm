.686
.model flat
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main

.data
znaki	db	12 dup (?) ; deklaracja do przechowywania
						   ; tworzonych cyfr
.code
wyswietl_EAX PROC
	pusha
	mov esi, 10		; indeks w tablicy 'znaki'
	mov ebx, 10		; dzielnik równy 10

	; konwersja na kod ASCII
	konwersja:
	mov edx, 0		; zerowanie starszej czesci dzielnej
	div ebx		; dzielenie przez 10, reszta w EDX
						; iloraz w EAX
	add dl, 30h		; zamiana reszty z dzielenia na kod ASCII
	mov znaki[esi], dl	; zapisanie cyfry w kodzie ASCII
	dec esi		; zmniejszenie indeks
	cmp eax, 0		; sprawdzenie czy iloraz = 0
	jne konwersja

	; wypelnienie pozostalych bajtow spacjami
	wypeln:
	or esi, esi
	jz wyswietl		; gdy indeks = 0
	mov byte PTR znaki[esi], 20h	; kod spacji
	dec esi
	jmp wypeln

	wyswietl:
	mov byte PTR znaki[0], 0Ah		; kod nowego wiersza
	mov byte PTR znaki[11], 0Ah
	push dword PTR 12
	push dword PTR OFFSET znaki
	push dword PTR 1
	call __write
	add esp, 12

	popa
	ret
wyswietl_EAX ENDP

_main PROC
	
	mov ecx, 0 ; licznik
	mov eax, 1 ; wart poczatkowa
	mov ebx, 1; stara

	ptl:
		call wyswietl_EAX	
		add eax, ecx

	inc ecx
	cmp ecx, 50
	jb ptl

	push 0
	call _ExitProcess@4
_main ENDP
END