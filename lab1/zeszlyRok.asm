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
nowy db 160 dup (?)
nowa_linia db 10
liczba_znakow dd ?
ostatni db ?
ostatni_index db 0
start dword ?
.code



_main PROC

mov start, 0
 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz ; adres tekstu
 push 1 ; nr urz¹dzenia (tu: ekran - nr 1)
 call __write ; wyœwietlenie tekstu pocz¹tkowego
 add esp, 12 ; usuniecie parametrów ze stosu

 push 80 ; maksymalna liczba znaków
 push OFFSET magazyn
 push 0 ; nr urz¹dzenia (tu: klawiatura - nr 0)
 call __read ; czytanie znaków z klawiatury
 add esp, 12 ; usuniecie parametrów ze stosu


 mov liczba_znakow, eax

 mov ecx, 0 ; rejestr ECX pe³ni rolê licznika obiegów pêtli
 mov eax, 0 ; index ze zmianami


ptl: mov dl, magazyn[ecx] ; pobranie kolejnego znaku
	 mov dh, ostatni
	 cmp dx, '\t'

	 je kopiuj

	 mov nowy[eax], dl
	 cmp ostatni, ' '
	 ;je fest
	 jne dalej
	 mov  start, ecx
	 jmp dalej
	 ;mov start,  al
kopiuj:
	MOV ESI, start
	SUB eax, 1
	copy:

	mov dh, magazyn[ESI]
	mov nowy[eax], dh

	INC eax
	INC esi
	cmp esi, ecx
	jne copy
	SUB eax, 2
dalej:
mov ostatni, dl
INC EAX
INC ecx
cmp ecx, liczba_znakow
jne ptl





 push eax
 push OFFSET nowy
 push 1
 call __write ; wyœwietlenie przekszta³conego tekstu
 add esp, 12 ; usuniecie parametrów ze stosu
 push 0
 fest:call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END