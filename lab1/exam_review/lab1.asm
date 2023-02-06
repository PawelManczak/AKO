; wczytywanie i wyœwietlanie tekstu wielkimi literami
; (inne znaki siê nie zmieniaj¹)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreœlenia)
extern __read : PROC ; (dwa znaki podkreœlenia)
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
public _main

.data
tytul db 'tytul', 10
tekst_pocz db 10, 'Proszê napisaæ jakiœ tekst '
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
 ;mul dwa
 mov ecx, eax
 mov ebx, 0 ; indeks pocz¹tkowy
 mov edi, 0; indeks dest


 mov esi, 0 ; poczatek slowa
 mov dh, 0 ; stary znak
ptl:
	mov edx, 0
	mov dl, magazyn[ebx] ; pobranie kolejnego znaku

	cmp dl, ' '
	jne standard
		;jest spacja:
		;1. bedzie powtorzenie
		;2. trzeba przestawic index
		cmp word ptr magazyn[ebx+1], 'd\'
		jne przestawiamy_index
			;1. obsluga powtorzenia
			
			ptl_przest:
				; esi wskazuje poczatek slowa do powt
				mov al, magazyn[esi]
				mov nowy_magazyn[edi], al
				inc edi
				inc esi
				
				cmp esi, ebx
				jl ptl_przest
				
				
				add ebx, 3
				jmp petla

		przestawiamy_index:
			mov esi, ebx
			
	standard:
		mov nowy_magazyn[edi], dl

dalej: 
 ;stary znak = znak
 mov dh, dl

 inc ebx
 inc edi
 petla:
 loop ptl ; sterowanie pêtl¹

; wyœwietlenie przekszta³conego tekstu
 push 0
 push offset tytul
 push OFFSET nowy_magazyn
 push 0
 call _MessageBoxA@16
 add esp, 12

 koniec:
 push 0
 call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END