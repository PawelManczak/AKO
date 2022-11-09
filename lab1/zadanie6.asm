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
	tekst_pocz db 10, 'Prosz', 169, ' napisa', 134, ' jaki', 152,' tekst ' ;w konsoli latin 2, w mb w1250
	koniec_t db ?
	magazyn db 80 dup (?)
	win1250magazyn db 80 dup (?) 
	nowa_linia db 10
	liczba_znakow dd ?
	tytul db 'tytul'
.code
_main PROC
; wy�wietlenie tekstu informacyjnego
; liczba znak�w tekstu
	 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
	 push ecx
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
ptl: mov dl, magazyn[ebx] ; pobranie kolejnego znakusd


; taki switch case
	 cmp dl, 165
	 je a_z_ogonkiem
	 cmp dl, 134
	 je c_z_ogonkiem
	 cmp dl, 169
	 je e_z_ogonkiem
	 cmp dl, 136
	 je l_z_ogonkiem
	 cmp dl, 228
	 je n_z_ogonkiem
	 cmp dl, 162
	 je o_z_ogonkiem
	 cmp dl, 152
	 je s_z_ogonkiem
	 cmp dl, 171
	 je z_z_ogonkiem
	 cmp dl, 190
	 je z_z_kropka


	 cmp dl, 'a'
	 jb dalej ; skok, gdy znak nie wymaga zamiany
	 cmp dl, 'z'
	 ja dalej ; skok, gdy znak nie wymaga zamiany
	  
	 sub dl, 20H ; zamiana na wielkie litery
	 jmp pDalej

	 a_z_ogonkiem:
		mov dl, 164
		jmp pDalej
	 c_z_ogonkiem:
		mov dl, 143
		jmp pDalej
	 e_z_ogonkiem:
		mov dl, 168
		jmp pDalej
	 l_z_ogonkiem:
		mov dl, 157
		jmp pDalej
	 n_z_ogonkiem:
		mov dl, 227
		jmp pDalej
	 o_z_ogonkiem:
		mov dl, 224
		jmp pDalej
	 s_z_ogonkiem:
		mov dl, 151
		jmp pDalej
	 z_z_ogonkiem:
		mov dl, 141
		jmp pDalej
	 z_z_kropka:
		mov dl, 189
		jmp pDalej

	 

	 
pDalej: mov magazyn[ebx], dl ; odes�anie znaku do pami�ci
dalej: inc ebx ; inkrementacja indeksu
loop ptl ; sterowanie p�tl�

; wy�wietlenie przekszta�conego tekstu
	 push liczba_znakow
	 push OFFSET magazyn
	 push 1
	 call __write ; wy�wietlenie przekszta�conego tekstu
	 add esp, 12 ; usuniecie parametr�w ze stosu

;-----
;; WINDOWS 1250 
;-----

	 ;mov liczba_znakow, eax
	; rejestr ECX pe�ni rol� licznika obieg�w p�tli
	 mov ecx, eax
	 mov ebx, 0 ; indeks pocz�tkowy


	 ptl2: mov dl, magazyn[ebx] ; pobranie kolejnego znakusd

	 ; switcase  
	 cmp dl, 164
	 je a_z_ogonkiem2
	 cmp dl, 143
	 je c_z_ogonkiem2
	 cmp dl, 168
	 je e_z_ogonkiem2
	 cmp dl, 157
	 je l_z_ogonkiem2
	 cmp dl, 227
	 je n_z_ogonkiem2
	 cmp dl, 224
	 je o_z_ogonkiem2
	 cmp dl, 151
	 je s_z_ogonkiem2
	 cmp dl, 141
	 je z_z_ogonkiem2
	 cmp dl, 189
	 je z_z_kropka2

	jmp dalej2 ; nie trzeba nic robic

	 a_z_ogonkiem2:
		mov dl, 165
		jmp pDalej2
	 c_z_ogonkiem2:
		mov dl, 198
		jmp pDalej2
	 e_z_ogonkiem2:
		mov dl, 202
		jmp pDalej2
	 l_z_ogonkiem2:
		mov dl, 163
		jmp pDalej2
	 n_z_ogonkiem2:
		mov dl, 209
		jmp pDalej2
	 o_z_ogonkiem2:
		mov dl, 211
		jmp pDalej2
	 s_z_ogonkiem2:
		mov dl, 140
		jmp pDalej2
	 z_z_ogonkiem2:
		mov dl, 143
		jmp pDalej2
	 z_z_kropka2:
		mov dl, 175
		jmp pDalej2

	 
	 pDalej2: mov magazyn[ebx], dl ; odes�anie znaku do pami�ci
	 dalej2: inc ebx ; inkrementacja indeksu
	 loop ptl2 ; sterowanie p�tl�



	 push 0 ; MB_OK
	 push OFFSET tytul
	 push OFFSET magazyn
	 push 0; NULL
	 call _MessageBoxA@16



	 push 0
	 call _ExitProcess@4 ; zako�czenie programu
_main ENDP
END