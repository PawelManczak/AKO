.686
.model flat

public _szukaj_elem_min
extern _malloc: PROC
.data
cztery db 4

.code
_szukaj_elem_min PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov ebx, [ebp+8] ; adres pierwszego elementu tablicy
mov ecx, [ebp+12] ; n
mov eax, ebx ; adres min el

ptl:
	mov edx, [ebx+4*ecx - 4]
	cmp edx, [eax]
	ja niemniejsze
	lea eax, [ebx+4*ecx-4]
	niemniejsze:
loop ptl

pop edi
pop esi
pop ebx
pop ebp
ret
_szukaj_elem_min ENDP
end