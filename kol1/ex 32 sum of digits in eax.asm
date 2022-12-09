.686 
.model flat

public _main

.data
dziesiec dd 10; do dzielenia wygodnie miec w pamieci, nie mozna zrobic czegos takiego jak div 10
.code

_main PROC

;32. Napisaæ fragment programu w asemblerze, który
;obliczy sumê cyfr dziesiêtnych liczby zawartej w rejestrze
;EAX. Wynik obliczenia wpisaæ do rejestru CL. Przyk³ad:
;jeœli w rejestrze EAX znajduje siê liczba 1111101
;(dziesiêtnie 125), to po wykonaniu fragmentu rejestr CL
;powinien zawieraæ 00001000

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