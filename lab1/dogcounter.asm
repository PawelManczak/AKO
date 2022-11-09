; wczytywanie i wyúwietlanie tekstu wielkimi literami
; (inne znaki siÍ nie zmieniajĻ)
.686
.model flat
	extern _ExitProcess@4 : PROC
	extern __write : PROC ; (dwa znaki podkreúlenia)
	extern __read : PROC ; (dwa znaki podkreúlenia)
	public _main

.data
	tekst_pocz db 10, 'Prosze napisac jakis tekst '
	db 'i nacisnac Enter', 10
	koniec_t db ?
	magazyn db 80 dup (?)
	magazyn_wyj db 80 dup (?)
	nowa_linia db 10
	liczba_znakow dd ?
	pies db "pies"
	zmienna dd "asd"

.code 

_main PROC 
	; wyúwietlenie tekstu informacyjnego
	; liczba znakůw tekstu
	 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
	 push ecx
	 push OFFSET tekst_pocz ; adres tekstu
	 push 1 ; nr urzĻdzenia (tu: ekran - nr 1)
	 call __write ; wyúwietlenie tekstu poczĻtkowego
	 add esp, 12 ; usuniecie parametrůw ze stosu
	; czytanie wiersza z klawiatury
	 push 80 ; maksymalna liczba znakůw
	 push OFFSET magazyn
	 push 0 ; nr urzĻdzenia (tu: klawiatura - nr 0)
	 call __read ; czytanie znakůw z klawiatury
	 add esp, 12 ; usuniecie parametrůw ze stosu
	; kody ASCII napisanego tekstu zosta≥y wprowadzone
	; do obszaru 'magazyn'
	; funkcja read wpisuje do rejestru EAX liczbÍ
	; wprowadzonych znakůw

	 mov liczba_znakow, eax

	; rejestr ECX pe≥ni rolÍ licznika obiegůw pÍtli
	 mov ecx, 0 ; counter podst
	 mov ebx, 0 ; index dla nowego slowa
	 mov ESI, 0 ; licznik psow
	 ptl:
	 mov dl, magazyn[ecx]

	 cmp ecx, 5 - 1
	 jb prawie_koniec

	 mov eax, dword ptr magazyn[ecx-4]
	 cmp eax, dword ptr pies ;idk
	 jne prawie_koniec
	 inc ESI
	 sub ebx, 4

	 prawie_koniec:
	 mov al, magazyn[ecx]
	 mov  magazyn_wyj[ebx], al
	 NOP
	 koniec:
	 INC ecx
	 INC ebx

	 cmp ecx, liczba_znakow
	 jb ptl

	 
	 mov liczba_znakow, ebx
	 push liczba_znakow
	 push OFFSET magazyn_wyj
	 push 1
	 call __write ; wyúwietlenie przekszta≥conego
	 add esp, 12 ; usuniecie parametrůw ze stosu

	 mov liczba_znakow, 2
	 
	 cmp esi, 1
	 jne dwa
	 mov esi, "1"
	 dwa:
	 cmp esi, 2
	 jne trzy
	 mov esi, "2"
	 trzy:
	 cmp esi, 3
	 jne cztery
	 mov esi, "3"
	 cztery:
	 cmp esi, 4
	 jne piec
	 mov esi, "4"
	 piec:
	 cmp esi, 5
	 jne szesc
	 mov esi, "5"
	 szesc:
	 cmp esi, 6
	 jne siedem
	 mov esi, "6"
	 siedem:
	 cmp esi, 7
	 jne osiem
	 mov esi, "7"
	 osiem:
	 cmp esi, 8
	 jne dziewiec
	 mov esi, "8"
	 dziewiec:
	 cmp esi, 9
	 jne zero
	 mov esi, "9"
	 zero:
	 cmp esi, 0
	 jne zliczanie
	 mov esi, "0"
	 
	 
	 ;mov bl, zmienna
	 zliczanie:
	 mov zmienna, esi
	 push 1
	 push offset zmienna
	 push 1
	 call __write 
	 push 0
	 call _ExitProcess@4 ; zakoŮczenie programu
_main ENDP
END
