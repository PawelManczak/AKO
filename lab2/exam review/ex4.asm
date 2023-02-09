.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main

.data
znaki	db	12 dup (?) ; deklaracja do przechowywania
						   ; tworzonych cyfr
wejscie db 12 dup (?)
dekoder db '0123456789ABCDEF'

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

wyswietl_EAX_hex PROC
	pusha
	mov esi, 10		; indeks w tablicy 'znaki'
	mov ebx, 16		; dzielnik równy 16

	; konwersja na kod ASCII
	konwersja:
	mov edx, 0		; zerowanie starszej czesci dzielnej
	div ebx		; dzielenie przez 10, reszta w EDX
						; iloraz w EAX
	mov dl, dekoder[edx]	; zamiana reszty z dzielenia na kod ASCII przy pomocy dekodera
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
wyswietl_EAX_hex ENDP

wczytaj_EAX PROC
push ebx
push ebp
push esi
push edi

push dword ptr 12
push dword ptr offset wejscie
push dword ptr 0 ; nr urzadzenia
call __read ; w eax ilosc znakow
add esp, 12

mov esi, 0
mov bl, 10
mov eax, 0

ptl_wej:

	mov dl, wejscie[esi]
	cmp dl, 10; czy enter
	je znak_to_enter
	sub dl, '0' ; w dl liczba
	mul bl; razy 10
	movzx edx, dl
	add eax, edx

	inc esi
jmp ptl_wej

znak_to_enter:

pop edi
pop esi
pop ebp
pop ebx
ret
wczytaj_EAX ENDP

_main PROC
	call wczytaj_EAX	
	call wyswietl_EAX_hex
	push 0
	call _ExitProcess@4
_main ENDP
END