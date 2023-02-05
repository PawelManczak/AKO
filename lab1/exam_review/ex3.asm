; wczytywanie i wy�wietlanie tekstu wielkimi literami
; (inne znaki si� nie zmieniaj�)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkre�lenia)
extern __read : PROC ; (dwa znaki podkre�lenia)
public _main

.data
tekst_pocz db 10, 'Prosz� napisa� jaki� tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?

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
 mov ecx, eax
 mov ebx, 0 ; indeks pocz�tkowy

ptl:
	mov dl, magazyn[ebx] ; pobranie kolejnego znaku

	;trzeba porownywac w latin 2 z jakiegos powodu
		cmp dl, 0A5h; '�'
		jne cc
		mov magazyn[ebx], 0A4h
		jmp dalej
	cc:
		cmp dl, 086h; '�'
		jne ee
		mov magazyn[ebx], 08Fh
		jmp dalej
	ee:
		cmp dl, 0A9h; '�'
		jne ll
		mov magazyn[ebx], 0A8h
		jmp dalej
	
	; itd nie ma sensu tego dalej robic

	cmp dl, 'a'
	jb dalej ; skok, gdy znak nie wymaga zamiany
	cmp dl, 'z'
	ja dalej ; skok, gdy znak nie wymaga zamiany
	sub dl, 20H ; zamiana na wielkie litery
	mov magazyn[ebx], dl; odes�anie znaku do pami�ci
dalej: inc ebx ; inkrementacja indeksu
 loop ptl ; sterowanie p�tl�

; wy�wietlenie przekszta�conego tekstu
 push liczba_znakow
 push OFFSET magazyn
 push 1
 call __write ; wy�wietlenie przekszta�conegotekstu
 add esp, 12 ; usuniecie parametr�w ze stosu
 koniec:
 push 0
 call _ExitProcess@4 ; zako�czenie programu
_main ENDP
END