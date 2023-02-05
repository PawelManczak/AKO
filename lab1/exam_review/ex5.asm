; wczytywanie i wy�wietlanie tekstu wielkimi literami
; (inne znaki si� nie zmieniaj�)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkre�lenia)
extern __read : PROC ; (dwa znaki podkre�lenia)
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
public _main

.data
tytul dw 't', 'i', 't', 'l', 'e', 0
tekst_pocz db 10, 'Prosz� napisa� jaki� tekst '
db 'i nacisnac Enter', 0
koniec_t db ?
magazyn db 80 dup (?)
nowy_magazyn db 90 dup (?)
nowa_linia db 10
liczba_znakow dd ?
dwa db 2

.code
_main PROC

 mov ecx, (OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx ; liczba liter
 push OFFSET tekst_pocz ; adres tekstu
 push 1 ; nr urz�dzenia (tu: ekran - nr 1)
 call __write ; wy�wietlenie tekstu pocz�tkowego
 add esp, 12 ; usuniecie parametr�w ze stosu

; czytanie wiersza z klawiatury
 push 80 ; maksymalna liczba znak�w
 push OFFSET magazyn
 push 0 ; nr urz�dzenia (tu: klawiatura - nr 0)
 call __read ; czytanie znak�w z klawiatury
 add esp, 12 ; usuniecie parametr�w ze stosu

; kody ASCII napisanego tekstu zosta�y wprowadzone
; do obszaru 'magazyn'
; funkcja read wpisuje do rejestru EAX liczb�
; wprowadzonych znak�w
 mov liczba_znakow, eax

; rejestr ECX pe�ni rol� licznika obieg�w p�tli
 ;mul dwa
 mov ecx, eax
 mov ebx, 0 ; indeks pocz�tkowy
 mov edi, 0; indeks dest

ptl:
	mov edx, 0
	mov dl, magazyn[ebx] ; pobranie kolejnego znaku

		;w messageBox stosowany jest windows1250l - messageBoxW UTF16
		cmp dl, 0A5h; '�'
		jne cc
		mov word ptr nowy_magazyn[ebx], 0104h
		jmp dalej
	cc:
		cmp dl, 086h; '�'
		jne ee
		mov word ptr nowy_magazyn[ebx], 0106ah
		jmp dalej
	ee:
		cmp dl, 0A9h; '�'
		jne ll
		mov word ptr nowy_magazyn[ebx], 0118h
		jmp dalej
	ll:
	; itd nie ma sensu tego dalej robic

	cmp dl, 'a'
	jb dalej ; skok, gdy znak nie wymaga zamiany
	cmp dl, 'z'
	ja dalej ; skok, gdy znak nie wymaga zamiany
	sub dl, 20H ; zamiana na wielkie litery
	mov nowy_magazyn[edi], dl
	mov nowy_magazyn[edi+1], 0; odes�anie znaku do pami�ci
dalej: add ebx, 1
 add edi, 2; inkrementacja indeksu
 loop ptl ; sterowanie p�tl�

; wy�wietlenie przekszta�conego tekstu
 push 0
 push offset tytul
 push OFFSET nowy_magazyn
 push 0
 call _MessageBoxW@16
 add esp, 12

 koniec:
 push 0
 call _ExitProcess@4 ; zako�czenie programu
_main ENDP
END