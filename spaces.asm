.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)
public _main
.data
tytul_Unicode dw 'T','e','k','s','t',' ','w',' '
dw 'f','o','r','m','a','c','i','e',' '
dw 'U','T','F','-','1','6', 0
tekst_Unicode dw 'K','a', 017CH ,'d','y',' ','z','n','a','k',' ' ; dziala utf - 16
dw 'z','a','j','m','u','j','e',' '
dw '1','6',' ','b','i', 't',00F3H ,'w', 0
tytul_Win1250 db 'Tekst w standard123123zie Windows 1250', 0
tekst_Win1250 db 'Ka', 191, 'dy znak zajmuje 8 bit', 241 ,'w', 0 ; tutaj windows 1250

	tekst_pocz db "wpisz"
	koniec_t db ?
	magazyn db 80 dup (?)
	nowy db 80 dup (?)
	nowa_linia db 10
	liczba_znakow dd ?
	ostatni_znak db ?

.code
_main PROC
	 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
	 push ecx
	 push OFFSET tekst_pocz ; adres tekstu
	 push 1 ; nr urządzenia (tu: ekran - nr 1)
	 call __write ; wyświetlenie tekstu początkowego
	 add esp, 12 ; usuniecie parametrów ze stosu

	 

	 push 80 ; maksymalna liczba znaków
	 push OFFSET magazyn
	 push 0 ; nr urządzenia (tu: klawiatura - nr 0)
	 call __read ; czytanie znaków z klawiatury
	 add esp, 12 ; usuniecie parametrów ze stosu
	 mov liczba_znakow, eax

	 mov eax, 0 ; pointer without rejected chars
	 mov ebx, 0 ; pointer with everythink
ptl:
	mov dl, magazyn[eax]
	
	cmp eax, 1
	jb p_dalej

	cmp ostatni_znak, "\"
	jne p_dalej


	cmp dl, "t"
	jne a
	mov nowy[ebx-1], " "
	dec ebx
	jmp dalej

	a:
	cmp dl, "a"
	jne cflag
	mov nowy[ebx-1], "ą"
	dec ebx
	jmp dalej
	
	cflag:

	cmp dl, "c"
	jne e
	mov nowy[ebx-1], "ć"
	dec ebx
	jmp dalej

	e:
	cmp dl, "e"
	jne l
	mov nowy[ebx-1], "ę"
	dec ebx
	jmp dalej

	l:
	cmp dl, "l"
	jne n
	mov nowy[ebx-1], "ł"
	dec ebx
	jmp dalej

	n:
	cmp dl, "n"
	jne o
	mov nowy[ebx-1], "ń"
	dec ebx
	jmp dalej

	o:
	cmp dl, "o"
	jne s
	mov nowy[ebx-1], "ó"
	dec ebx
	jmp dalej

	s:
	cmp dl, "s"
	jne z
	mov nowy[ebx-1], "ś"
	dec ebx
	jmp dalej

	z:
	cmp dl, "z"
	jne p_dalej
	mov nowy[ebx-1], "ż"
	dec ebx
	jmp dalej



p_dalej:
	mov nowy[ebx], dl
dalej:
	
	mov ostatni_znak, dl
	inc eax
	inc ebx

	cmp eax, liczba_znakow
	jb ptl
	
 push 0 ; stała MB_OK
; adres obszaru zawierającego tytuł
 push OFFSET tytul_Win1250 
; adres obszaru zawierającego tekst
 push OFFSET nowy
 push 0 ; NULL
 call _MessageBoxA@16
 push 0 ; stala MB_OK

 push 0 ; kod powrotu programu
 call _ExitProcess@4
_main ENDP
END