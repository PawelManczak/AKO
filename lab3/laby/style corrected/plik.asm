.686
.model flat


public _wyswietl

.code
_wyswietl PROC
push ebp
mov ebp, esp

push ebx
push esi
push edi


mov ebx, [ebp+8]; wskaznik na tab
mov edx, [ebp+12]; znak
mov esi, [ebp+16]; wunik

mov eax, 0; wuynik
mov edi, 0; licznik
mov esi, -1; flaga
mov cx, [ebx]

ptl:

cmp dword ptr[ebx+edi*2], 0; czy koniec tablicy //tutaj na labach z jakiegos powodu wstawilem
;byte ptr, ale dla podanych danych dziala i tak
je koniec

cmp word ptr[ebx+edi*2], dx
jne nierowne
inc eax; zwiekszamy wynik

cmp esi, -1
jne nierowne

push eax ; co prawda moze utrudniac czytanie, push i popy sa dlatego, ze zabraklo mi rejestrow,
push edi;a bylo malo czasu

lea eax, [ebx+edi*2]; mamy adres w eax
mov edi, [ebp+16]; dostajemy sie do pointera
mov [edi], eax; wstawiamy do pintera adres

pop edi; oddajemy zmienne 
pop eax; wstawione na szybo

mov esi, 1; ustawiamy flage - bo zbieramy pierwszy adres

nierowne:
inc edi

jne ptl; while true dopoki znak to nie bedzie zero

koniec:
mov edi, 0
mov ebx, 0

pop edi
pop esi
pop ebx
pop ebp
ret
_wyswietl ENDP

END