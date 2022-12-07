.686 
.model flat

public _main

.code

_main PROC

mov ebx, -32
bt ebx, 31; testujemy 32 bit (bo od 0)
jc minus
;plus
jmp koniec ;nic nie trzeba zmieniac, bo u2 = nkb dla dodatnich

minus:
neg ebx; u2 -> nkb
or ebx, 0A0000000h; wstawianie "1"jako pierwszego znaku - "-" w systemie ZM
koniec:



_main ENDP
END