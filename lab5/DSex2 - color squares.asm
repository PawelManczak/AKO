; Program gwiazdki.asm
; Wyświetlanie znaków * w takt przerwań zegarowych
; Uruchomienie w trybie rzeczywistym procesora x86
; lub na maszynie wirtualnej
; zakończenie programu po naciśnięciu klawisza 'x'
; asemblacja (MASM 4.0): masm gwiazdki.asm,,,;
; konsolidacja (LINK 3.60): link gwiazdki.obj;
.386
rozkazy SEGMENT use16
ASSUME CS:rozkazy
;============================================================
; procedura obsługi przerwania zegarowego
wyczysc PROC
		push ax
		push bx
		push cx

		mov ax, 0B800h ;adres pamięci ekranu
		mov es, ax
		mov bx, 0
		ptl2:
			mov byte PTR es:[bx], 0
			mov byte PTR es:[bx+1], 00000000b
			add bx, 2
			cmp bx, 4000
		jb ptl2

		pop cx
		pop bx
		pop ax
		ret
wyczysc ENDP

wypelnij PROC
		push ax
		push bx
		push cx


		mov cx, 4000; default
		mov bx, 0;default
		mov dx, 2; default

		goraW:
		cmp cs:strzalka, 0
		jne dolW
		mov cx, 2000
		mov cs:krok, 2
		dolW:
		cmp cs:strzalka, 3
		jne prawoW
		mov bx, 2000
		mov cs:krok, 2
		prawoW:
		cmp cs:strzalka, 2
		jne lewoW
		mov cs:krok, 160
		jmp dla_pionowych
		lewoW:
		cmp cs:strzalka, 1
		je dla_pionowych


		mov ax, 0B800h ;adres pamięci ekranu
		mov es, ax
	
		mov dl, cs:znak
		ptl:
			mov byte PTR es:[bx], dl ; kod ASCII
			mov al, cs:kolor
			mov byte PTR es:[bx+1], al; kolor

			add bx, cs:krok; zwiększenie o 2 adresu bieżącego w pamięci ekranu

			
		cmp bx, cx
		jb ptl

		jmp koniec_wypelnij

		
		dla_pionowych:
		mov cs:krok, 160
		mov ax, 0B800h ;adres pamięci ekranu
		mov es, ax
	
		mov dl, cs:znak

		mov cs:max_kolumna, 80 ; dla lewego
		mov cs:kolumna, 0 ; dla lewgo

		cmp cs:strzalka, 2
		jne ptl_pion

		mov cs:max_kolumna, 160 ; dla prawego
		mov cs:kolumna, 70 ; dla prawego
		movzx bx, cs:kolumna

		ptl_pion:
			mov byte PTR es:[bx], dl ; kod ASCII
			mov al, cs:kolor
			mov byte PTR es:[bx+1], al; kolor

			add bx, cs:krok
			cmp bx, 4000
			jb st_petl
			add cs:kolumna, 2
			movzx bx, cs:kolumna

		st_petl:	
		push al
		mov al, cs:max_kolumna
		cmp cs:kolumna, al
		pop al
		jb ptl_pion


	koniec_wypelnij:

		pop cx
		pop bx
		pop ax
		ret
wypelnij ENDP

obsluga_zegara PROC
; przechowanie używanych rejestrów
push ax
push bx
push es


cmp cs:licznikCzasu, 18; co sekunde
jne wysw_dalej
mov cs:licznikCzasu, 0; zerowanie llicznika

	cmp cs:licznikK, 0
	jne jedynkaK
	mov cs:kolor, 00000111B
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
	call wyczysc	
	call wypelnij	

	cmp cs:licznikK, 3
	jne zwiekszK
	mov cs:licznikK, -1 ; i tak vedzie zwiekszone zaraz do 0
	zwiekszK:
	inc cs:licznikK


;zapisanie adresu bieżącego do zmiennej 'licznik'
wysw_dalej:
inc cs:licznikCzasu
; odtworzenie rejestrów
pop es
pop bx
pop ax
; skok do oryginalnej procedury obsługi przerwania zegarowego
jmp dword PTR cs:wektor8
; dane programu ze względu na specyfikę obsługi przerwań
; umieszczone są w segmencie kodu
wektor8 dd ?
znak db '*'
krok dw 2
licznikCzasu dw 0; wyswietlanie co 16 cykli
kolor db 00000111B
licznikK db 0
kolumna db 0
max_kolumna db 0
strzalka db 0
obsluga_zegara ENDP
;============================================================
; program główny - instalacja i deinstalacja procedury
; obsługi przerwań
; ustalenie strony nr 0 dla trybu tekstowego
zacznij:
mov al, 0
mov ah, 5
int 10
mov ax, 0
mov ds,ax ; zerowanie rejestru DS
; odczytanie zawartości wektora nr 8 i zapisanie go
; w zmiennej 'wektor8' (wektor nr 8 zajmuje w pamięci 4 bajty
; począwszy od adresu fizycznego 8 * 4 = 32)
mov eax,ds:[32] ; adres fizyczny 0*16 + 32 = 32
mov cs:wektor8, eax

; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara'
mov ax, SEG obsluga_zegara ; część segmentowa adresu
mov bx, OFFSET obsluga_zegara ; offset adresu
cli ; zablokowanie przerwań
; zapisanie adresu procedury do wektora nr 8
mov ds:[32], bx ; OFFSET
mov ds:[34], ax ; cz. segmentowa
sti ;odblokowanie przerwań
; oczekiwanie na naciśnięcie klawisza 'x'
aktywne_oczekiwanie:
mov ah,1
int 16H
; funkcja INT 16H (AH=1) BIOSu ustawia ZF=1 jeśli
; naciśnięto jakiś klawisz
jz aktywne_oczekiwanie
; odczytanie kodu ASCII naciśniętego klawisza (INT 16H, AH=0)
; do rejestru AL

;G, l , P, D
mov ah, 0

in al, 60h
;gora
cmp al, 72
jne lewo
mov cs:strzalka, 0
jmp po_strzalkach
 
lewo:
cmp al, 75  
jne prawo
mov cs:strzalka, 1
jmp po_strzalkach

prawo:
cmp al, 77  
jne dol
mov cs:strzalka, 2
jmp po_strzalkach

dol:
cmp al, 80
jne po_strzalkach	
mov cs:strzalka, 3

po_strzalkach:
mov dl, znak

cmp al, 46 ; c
jne xx
call wyczysc
xx:
mov ah, 0
int 16H 
cmp al, 'x' ; porównanie z kodem litery 'x'
jne aktywne_oczekiwanie ; skok, gdy inny znak
; deinstalacja procedury obsługi przerwania zegarowego
; odtworzenie oryginalnej zawartości wektora nr 8
koniec:
mov eax, cs:wektor8
cli
mov ds:[32], eax ; przesłanie wartości oryginalnej
; do wektora 8 w tablicy wektorów
; przerwań
sti
; zakończenie programu
mov al, 0
mov ah, 4CH
int 21H
rozkazy ENDS
nasz_stos SEGMENT stack
db 128 dup (?)
nasz_stos ENDS
END zacznij