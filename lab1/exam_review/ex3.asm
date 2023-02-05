; wczytywanie i wyœwietlanie tekstu wielkimi literami
; (inne znaki siê nie zmieniaj¹)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreœlenia)
extern __read : PROC ; (dwa znaki podkreœlenia)
public _main

.data
tekst_pocz db 10, 'Proszê napisaæ jakiœ tekst '
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
 push 1 ; nr urz¹dzenia (tu: ekran - nr 1)
 call __write ; wyœwietlenie tekstu pocz¹tkowego
 add esp, 12 ; usuniecie parametrów ze stosu

; czytanie wiersza z klawiatury
 push 80 ; maksymalna liczba znaków
 push OFFSET magazyn
 push 0 ; nr urz¹dzenia (tu: klawiatura - nr 0)
 call __read ; czytanie znaków z klawiatury
 add esp, 12 ; usuniecie parametrów ze stosu

; kody ASCII napisanego tekstu zosta³y wprowadzone
; do obszaru 'magazyn'
; funkcja read wpisuje do rejestru EAX liczbê
; wprowadzonych znaków
 mov liczba_znakow, eax

; rejestr ECX pe³ni rolê licznika obiegów pêtli
 mov ecx, eax
 mov ebx, 0 ; indeks pocz¹tkowy

ptl:
	mov dl, magazyn[ebx] ; pobranie kolejnego znaku

	;trzeba porownywac w latin 2 z jakiegos powodu
		cmp dl, 0A5h; '¹'
		jne cc
		mov magazyn[ebx], 0A4h
		jmp dalej
	cc:
		cmp dl, 086h; 'æ'
		jne ee
		mov magazyn[ebx], 08Fh
		jmp dalej
	ee:
		cmp dl, 0A9h; 'ê'
		jne ll
		mov magazyn[ebx], 0A8h
		jmp dalej
	
	; itd nie ma sensu tego dalej robic

	cmp dl, 'a'
	jb dalej ; skok, gdy znak nie wymaga zamiany
	cmp dl, 'z'
	ja dalej ; skok, gdy znak nie wymaga zamiany
	sub dl, 20H ; zamiana na wielkie litery
	mov magazyn[ebx], dl; odes³anie znaku do pamiêci
dalej: inc ebx ; inkrementacja indeksu
 loop ptl ; sterowanie pêtl¹

; wyœwietlenie przekszta³conego tekstu
 push liczba_znakow
 push OFFSET magazyn
 push 1
 call __write ; wyœwietlenie przekszta³conegotekstu
 add esp, 12 ; usuniecie parametrów ze stosu
 koniec:
 push 0
 call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END