.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main
.data
znaki db 12 dup (?)
obszar db 12 dup (?)
dziesiec dd 10 ; mno�nik
.code
wyswietl_EAX PROC

mov ebx, 10; dzielnik
mov edi, 10

ptl:
mov edx, 0
DIV ebx
add dl, 30h

mov znaki[edi], dl
dec edi
cmp eax, 0


jne ptl


; wy�wietlenie cyfr na ekranie
push dword PTR 12 ; liczba wy�wietlanych znak�w
push dword PTR OFFSET znaki ; adres wy�w. obszaru
push dword PTR 1; numer urz�dzenia (ekran ma numer 1)
call __write ; wy�wietlenie liczby na ekranie
add esp, 12 ; usuni�cie parametr�w ze stosu






ret
wyswietl_EAX ENDP
wczytaj_EAX PROC

push ebx
push ecx


push dword PTR 12
push dword PTR OFFSET obszar ; adres obszaru pami�ci
push dword PTR 0; numer urz�dzenia (0 dla klawiatury)
call __read ; odczytywanie znak�w z klawiatury
; (dwa znaki podkre�lenia przed read)
add esp, 12 ; usuni�cie parametr�w ze stosu
; bie��ca warto�� przekszta�canej liczby przechowywana jest
; w rejestrze EAX; przyjmujemy 0 jako warto�� pocz�tkow�
mov eax, 0
mov ebx, OFFSET obszar ; adres obszaru ze znakami
pobieraj_znaki:
mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie
; ASCII
inc ebx ; zwi�kszenie indeksu
cmp cl,10 ; sprawdzenie czy naci�ni�to Enter
je byl_enter ; skok, gdy naci�ni�to Enter
sub cl, 30H ; zamiana kodu ASCII na warto�� cyfry
movzx ecx, cl ; przechowanie warto�ci cyfry w
; rejestrze ECX
; mno�enie wcze�niej obliczonej warto�ci razy 10
mul dword PTR dziesiec 
add eax, ecx ; dodanie ostatnio odczytanej cyfry
jmp pobieraj_znaki ; skok na pocz�tek p�tli
byl_enter:

pop ecx
pop ebx

ret
wczytaj_EAX ENDP


_main PROC

; max ilo�� znak�w wczytywanej liczby

; warto�� binarna wprowadzonej liczby znajduje si� teraz w EAX
call wczytaj_EAX	
MUL EAX
call wyswietl_EAX	
push 0
call _ExitProcess@4
_main ENDP
END