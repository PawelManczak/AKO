.686
.model flat

public _sum
.code
_sum PROC
push ebp
mov ebp, esp
push ecx
mov eax, [ebp+8]; pierwszy parametr - n, call ma adres ebp +4

mov ecx, eax

ptl:
add eax, [ebp+8+4*ecx]; sumowanie elementow
loop ptl

pop ecx
pop ebp
ret
_sum ENDP
END