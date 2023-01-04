.686
.model flat

public _kwadrat
extern _malloc: PROC
.data
cztery db 4

.code

_kwadrat PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov eax, [ebp+8] ; adres pierwszego elementu tablicy

cmp eax, 0
JE koniec
cmp eax, 1
je koniec

lea esi, [esi+4*eax-4]; suma jest liczona osobno w esi

sub eax, 2
push eax
call _kwadrat
add esp, 4

koniec:

add eax, esi

pop esi
sub eax, esi ;odejmujemy od wyniku stan poczatkowy esi
pop edi
pop ebx
pop ebp
ret
_kwadrat ENDP
end