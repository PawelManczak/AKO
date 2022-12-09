.686 
.model flat

public _main

.data
dziesiec dd 10; do dzielenia wygodnie miec w pamieci, nie mozna zrobic czegos takiego jak div 10
.code

_main PROC

;32. Napisa� fragment programu w asemblerze, kt�ry
;obliczy sum� cyfr dziesi�tnych liczby zawartej w rejestrze
;EAX. Wynik obliczenia wpisa� do rejestru CL. Przyk�ad:
;je�li w rejestrze EAX znajduje si� liczba 1111101
;(dziesi�tnie 125), to po wykonaniu fragmentu rejestr CL
;powinien zawiera� 00001000

mov eax, 126 ; przykladowa liczba
mov cl, 0 ; zerowanie sumy

ptl:
mov edx, 0; zerowanie reszty, bo dzielnia jest edx:eax - to jest na kartce
div dziesiec
add cl, dl ; dodanie reszty do sumy, reszta nie bedzie wieksza niz 9, wiec zmiesci sie w gl
cmp eax, 0 ; wykonuj az eax != 0
jne ptl



_main ENDP
END