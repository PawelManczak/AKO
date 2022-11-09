; Przykład wywoływania funkcji MessageBoxA i MessageBoxW
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
extern __read : PROC
public _main
.data
tytul_Unicode dw 'Z','n','a','k','i', 0
tekst_Unicode dw 'T','o',' ','j','e','s','t',' ','p','i','e','s', 0

indeksy dw 1,22, 25, -1
napis db 128 dup (?)
nowy dw 128 dup (?)
liczba_znakow dd ?
znak dw 2695h


.code
_main PROC

push 80 ; maksymalna liczba znaków
 push OFFSET napis
 push 0 ; nr urządzenia (tu: klawiatura - nr 0)
 call __read ; czytanie znaków z klawiatury
 add esp, 12 ; usuniecie parametrów ze stosu
 mov liczba_znakow, eax

 ;czy index sie znajdoje
 mov eax, 0 ; index glowny

 ptl_w:
	mov dl, napis[eax]

	mov ebx, 0


 ptl:

	mov cx, indeksy[ebx*2]
	cmp cx, -1
	je wyjdz; przelecialo juz cala

	;mov bp, indeksy[ebx]

	cmp cx, ax

	jne ptl2

	mov bp, word ptr znak
	mov nowy[eax*2], bp
	inc znak
	jmp pom

	ptl2:
	INC ebx
	jmp ptl
wyjdz:

;mov vh, dx
;mov dh, dl
mov dh, 0
;mov dl, 0

mov nowy[eax*2], dx
pom:
INC eax
cmp eax, liczba_znakow
jb ptl_w






 push 0 ; stala MB_OK
; adres obszaru zawierającego tytuł
 push OFFSET tytul_Unicode
; adres obszaru zawierającego tekst
 push OFFSET nowy
 push 0 ; NULL
 call _MessageBoxW@16

 dass:
 push 0 ; kod powrotu programu
 call _ExitProcess@4

_main ENDP
END