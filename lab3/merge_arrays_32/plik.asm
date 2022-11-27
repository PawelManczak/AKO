.686
.model flat

public _merge

.data 
tab sdword 8 dup (?); int
.code
_merge PROC	
push ebp
mov ebp, esp

push ebx
push ecx
push esi

mov eax, [ebp + 8]; wksaznik na pierwsza tab
mov ebx, [ebp + 12]; wksaznik na druga tab
mov ecx, [ebp+16]; liczba n

cmp ecx, 32
jle merge

;blad
xor eax, eax; szybkie zerowanie

pop ebx
pop ecx
pop esi
pop ebp
ret

merge:
mov esi, 0
ptl:
	mov edx, [eax+4*esi] ; zmienna tymczasowa do przenoszenia do danych
	mov tab[esi*8], edx
	mov edx, [ebx+4*esi]
	mov tab[esi*8+4], edx
	inc esi
loop ptl

mov eax, offset tab

pop ebx
pop ecx
pop esi
pop ebp
ret
_merge ENDP
end	