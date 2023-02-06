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
tytul db 'tytul', 10
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
 loop ptl ; sterowanie p�tl�

; wy�wietlenie przekszta�conego tekstu
 push 0
 push offset tytul
 push OFFSET nowy_magazyn
 push 0
 call _MessageBoxA@16
 add esp, 12

 koniec:
 push 0
 call _ExitProcess@4 ; zako�czenie programu
_main ENDP
END