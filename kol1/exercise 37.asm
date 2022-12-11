.686 
.model flat

public _main

.data
t db 128 dup (?)
.code

_main PROC


mov ecx, 128 ; <- rozmiar tablicy
ptl:
	mov dl, 0 ; CF z poprzednieg obiegu, zakladamy, ze 0
	JNC nieustawiaj
	mov dl, 1 ; CF z poprzednie jest jednak 1
	nieustawiaj:
	SHL byte ptr t[ecx-1], 1 ; przesuwa i ustawia nowe CF
	mov al, 0 ; musimy zapisac nowe carry, bo or zmienia CF, a potrzebne jest w nastepnym obiegu
	jnc po2ustawianiu
	mov al, 1 ; nowe CF to 1
	po2ustawianiu:
	OR dl, byte ptr t[ecx-1] ; ustawiamy ostatni bit zgodnie ze starym CF

	;ustawiamy cf dla nowego obiegu zgodnie z nowym CF
	stc ; zakladamy, ze CF = 1
	cmp al, 0
	jne juzustawione
	clc ; CF to jednak 0
	juzustawione:
LOOP ptl

JNC koniec ; shl wstawia zera, wiec nie musimy nic zmieniac na ostatnim bicie
mov cl, 0
or byte ptr t[127], byte ptr 1
koniec:

ret
_main ENDP
END