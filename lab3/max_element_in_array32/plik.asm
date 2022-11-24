.686
.model flat

public _szukaj_elem_max
.code
_szukaj_elem_max PROC
push ebp
mov ebp, esp

push ebx
push ecx
push edx

mov eax, 0; wynik
mov ebx, [ebp+8]; adres  tablicy, wskaznik na pierwszy element
;mov edx, [ebx]; pierwszy element
mov ecx, [ebp+12]; rozmiar tablicy

mov eax, [ebx]; wart 1 elementu
mov edx, ebx; adres 1 elementu

ptl:
cmp eax, [ebx+4*ecx-4]
ja koniec_ptl
mov eax, [ebx+4*ecx-4]
lea edx, [ebx+4*ecx-4]

koniec_ptl:

loop ptl


mov eax, edx

pop edx
pop ecx
pop ebx
pop ebp
ret
_szukaj_elem_max ENDP
END