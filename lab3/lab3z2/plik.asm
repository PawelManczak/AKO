.686
.model flat
public _przeciwna
.code
_przeciwna PROC
push ebp
mov ebp, esp; do przyjecia zmiennych ze stosu
push ebx; do obliczen

; stos rosnie w kierunku malejacych adresow
; pierwsze 4 bajty zajmuje slad instrukcji call

; w [ebp + 8] mamy adres zmiennej, bo jest wysylany wskaznik

mov ebx, [ebp + 8] ; ebx ma teraz wart adresu, gdzie jest liczba
mov eax, [ebx]

neg eax

mov  [ebx], eax ; zapis na adres, gdzie liczba sie rzeczywscie znajduje
;neg dword ptr [ebx] ; aleternatywa, bez uzywania ebx

pop ebx
pop ebp
ret
_przeciwna ENDP
 END