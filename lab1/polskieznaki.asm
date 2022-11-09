.686	
.model flat
extern _ExitProcess@4 : PROC
	extern __write : PROC ; (dwa znaki podkre�lenia)
	extern __read : PROC ; (dwa znaki podkre�lenia)
	extern _MessageBoxA@16 : PROC
	public _main
.data
	magazyn db 80 dup (?)
	wyj db 80 dup (?)
	liczba_znakow dd ?
	start dd 0
	stop dd 0
	t_start dd 0 ;temp variables
	t_stop dd 0
	maks dd 0
.code

_main PROC
	 push 80 ; maksymalna liczba znak�w
	 push OFFSET magazyn
	 push 0 ; nr urz�dzenia (tu: klawiatura - nr 0)
	 call __read ; czytanie znak�w z klawiatury
	 mov liczba_znakow, eax

	 mov esi, 0; licznik polskich znakow
	 mov ecx, 0

ptl:
	 mov dl, magazyn[ecx]

	 ; sprawdzanie polskich znakow

	 cmp dl, 165 ;�
	 jne spr_czy_nowe
	 INC esi
	 jmp dalej
	 cmp dl, 134 ; �
	 jne spr_czy_nowe
	 INC esi
	 jmp dalej
	 cmp dl, 169 ; �
	 jne spr_czy_nowe
	 INC esi
	 jmp dalej
	 cmp dl, 136; �
	 jne spr_czy_nowe
	 INC esi
	 jmp dalej
	 cmp dl, 228;�
	 jne spr_czy_nowe
	 INC esi
	 jmp dalej
	 cmp dl, 162; �
	 jne spr_czy_nowe
	 INC esi
	 jmp dalej
	 cmp dl, 152;�
	 jne spr_czy_nowe
	 INC esi
	 jmp dalej
	 cmp dl, 171;�
	 jne spr_czy_nowe
	 INC esi
	 jmp dalej
	 cmp dl, 190;�
	 jne spr_czy_nowe
	 INC esi
	 jmp dalej

	 spr_czy_nowe:
	 cmp dl, " "
	 jne dalej

	 cmp esi, maks
	 jb simply_ustaw

	 ; start = t_start
	 ; stop = ecx
	 ; maks = esi

	 mov eax, t_start
	 mov start, eax
	 mov maks, esi
	 mov stop, ecx
	 ; esi = 0
	 mov esi, 0

	 simply_ustaw:
	 mov t_start, ecx


dalej:
inc ecx
cmp ecx, liczba_znakow
jb ptl

;sprawdzenie dla ostatniego slowa
	 cmp esi, maks
	 jb skip
	 DEC ecx
	 mov stop, ecx
	 mov eax, t_start
	 mov start, eax
	 
skip:
	
	mov ecx, start
	mov ebx, 0


ptl2:
	mov dl, magazyn[ecx]
	mov wyj[ebx], dl

	INC ecx
	INC ebx

cmp ecx, stop
jb ptl2



	mov eax, stop
	sub eax, start
	 push eax
	 push OFFSET wyj
	 push 1
	 call __write ; wy�wietlenie przekszta�conego tekstu
	 add esp, 12 ; usuniecie parametr�w ze stosu
		




	 push 0
	 call _ExitProcess@4 ; zako�czenie programu
_main ENDP

END	