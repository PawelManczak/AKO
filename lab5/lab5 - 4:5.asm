; Program gwiazdki.asm
; Wy�wietlanie znak�w * w takt przerwa� zegarowych
; Uruchomienie w trybie rzeczywistym procesora x86
; lub na maszynie wirtualnej
; zako�czenie programu po naci�ni�ciu klawisza 'x'
; asemblacja (MASM 4.0): masm gwiazdki.asm,,,;
; konsolidacja (LINK 3.60): link gwiazdki.obj;
.386
rozkazy SEGMENT use16
	ASSUME CS:rozkazy
;============================================================
; procedura obs�ugi przerwania zegarowego
wyczysc PROC
		push ax
		push bx
		push cx

		mov ax, 0A000h ;adres pamięci ekranu
		mov es, ax
		mov bx, 0
		ptl2:
			mov byte PTR es:[bx], 0
			add bx, 1
			cmp bx, 320*200
			jb ptl2

		pop cx
		pop bx
		pop ax
wyczysc ENDP

obsluga_zegara PROC
; przechowanie u�ywanych rejestr�w
push ax
push bx
push es
; wpisanie adresu pami�ci ekranu do rejestru ES - pami��
; ekranu dla trybu tekstowego zaczyna si� od adresu B8000H,
; jednak do rejestru ES wpisujemy warto�� B800H,
; bo w trakcie obliczenia adresu procesor ka�dorazowo mno�y
; zawarto�� rejestru ES przez 16
mov ax, 0a000h ;adres pami�ci ekranu
mov es, ax

mov dx, cs:licznikCzasu
cmp dx, 2 ;tutaj w zaleznosci od czasu
jne koniec
mov dx, 0
mov cs:licznikCzasu, dx

	;cmp cs:licznikK, 0
	;jne jedynkaK
	;mov cs:kolor, 00000111B
	jmp wyp

	jedynkaK:
	cmp cs:licznikK, 1
	jne dwojkaK
	mov cs:kolor, 00000100B
	jmp wyp

	dwojkaK:
	cmp cs:licznikK, 2
	jne trojkaK
	mov cs:kolor, 00000101B
	jmp wyp

	trojkaK:
	cmp cs:licznikK, 3
	jne czworkaK
	mov cs:kolor, 00000001B
	jmp wyp

	czworkaK:
	mov cs:kolor, 00000011B

	wyp:
	cmp cs:licznikK, 3
	jne zwiekszK
	mov cs:licznikK, -1 ; i tak vedzie zwiekszone zaraz do 0
	zwiekszK:
	inc cs:licznikK

	cmp cs:kolor, 8
	jb dsdd
	mov cs:kolor, -1
	dsdd:
	inc cs:kolor

	
; zmienna 'licznik' zawiera adres bie��cy w pami�ci ekranu
mov bx, cs:licznik
; przes�anie do pami�ci ekranu kodu ASCII wy�wietlanego znaku
; i kodu koloru: bia�y na czarnym tle (do nast�pnego bajtu)

push dx
call wyczysc	
mov cx, 90

ptl_g:
add cs:pozycja, 10

mov dx, 0
push ax
mov ax, cs:pozycja
div cs:czteryK
pop ax ; w dx mamy reszte

mov bx, dx

push al

mov al, cs:kolor
;mov byte PTR es:[bx], '*' ; kod ASCII
mov byte PTR es:[bx], 3; kolor

pop al

sub cx, 2
cmp cx, 0 ; obsluga petli
ja ptl_g
pop dx

cmp cs:pozycja, 16000
jbe dds
mov cs:pozycja, 0
dds:
; sprawdzenie czy adres bie��cy osi�gn�� koniec pami�ci ekranu

; zmiany w bx
cmp bx, 4000
jb bezzmiany
;add cs:kolumna, 2
mov bx, cs:kolumna

bezzmiany:


cmp bx,4000
jb wysw_dalej ; skok gdy nie koniec ekranu
; wyzerowanie adresu bie��cego, gdy ca�y ekran zapisany
mov bx, 0
;zapisanie adresu bie��cego do zmiennej 'licznik'
wysw_dalej:
mov cs:licznik,bx
; odtworzenie rejestr�w


koniec:
add dx, 1
mov cs:licznikCzasu, dx

pop es
pop bx
pop ax
; skok do oryginalnej procedury obs�ugi przerwania zegarowego
jmp dword PTR cs:wektor8
; dane programu ze wzgl�du na specyfik� obs�ugi przerwa�
; umieszczone s� w segmencie kodu
licznik dw 320 ; wy�wietlanie pocz�wszy od 2. wiersza
wektor8 dd ?
licznikCzasu dw 0; wyswietlanie co 16 cykli
kolumna dw 0; do zliczania kolumn
poziom db 20
kolor db 00000111B
licznikK db 1
pozycja dw 0
czteryK dw 4000
obsluga_zegara ENDP
;============================================================
; program g��wny - instalacja i deinstalacja procedury
; obs�ugi przerwa�
; ustalenie strony nr 0 dla trybu tekstowego
zacznij:
mov ah, 0
mov al, 13H ; nr trybu
int 10H
mov bx, 0
mov es, bx ; zerowanie rejestru ES
mov eax, es:[32] ; odczytanie wektora nr 8


; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara'
mov ax, SEG obsluga_zegara ; cz�� segmentowa adresu
mov bx, OFFSET obsluga_zegara ; offset adresu
cli ; zablokowanie przerwa�
; zapisanie adresu procedury do wektora nr 8
mov ds:[32], bx ; OFFSET
mov ds:[34], ax ; cz. segmentowa
sti ;odblokowanie przerwa�
; oczekiwanie na naci�ni�cie klawisza 'x'
aktywne_oczekiwanie:
mov ah,1
int 16H
; funkcja INT 16H (AH=1) BIOSu ustawia ZF=1 je�li
; naci�ni�to jaki� klawisz
jz aktywne_oczekiwanie
; odczytanie kodu ASCII naci�ni�tego klawisza (INT 16H, AH=0)
; do rejestru AL
mov ah, 0
int 16H
cmp al, 'x' ; por�wnanie z kodem litery 'x'
jne aktywne_oczekiwanie ; skok, gdy inny znak
; deinstalacja procedury obs�ugi przerwania zegarowego
; odtworzenie oryginalnej zawarto�ci wektora nr 8
mov eax, cs:wektor8
cli
mov ds:[32], eax ; przes�anie warto�ci oryginalnej
; do wektora 8 w tablicy wektor�w
; przerwa�
sti
; zako�czenie programu
mov al, 0
mov ah, 4CH
int 21H
rozkazy ENDS
nasz_stos SEGMENT stack
db 128 dup (?)
nasz_stos ENDS
END zacznij