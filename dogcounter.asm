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
	zmienna db ?

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

	 mov liczba_znakow, 1
	 mov dword ptr zmienna, esi

	 ;mov bl, zmienna
	 
	 push liczba_znakow
	 push offset zmienna
	 push 1
	 call __write ; wyúwietlenie przekszta≥conego
	 add esp, 12 ; usuniecie parametrůw ze stosu


	 push 0
	 call _ExitProcess@4 ; zakoŮczenie programu
_main ENDP
END
