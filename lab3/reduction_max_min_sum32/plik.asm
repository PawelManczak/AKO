.686
.model flat

public _reduction
.code
_reduction PROC
push ebp
mov ebp, esp

xor eax, eax; szybkie zerowanie eax

push ebx
push ecx
mov ebx, [ebp+8]; pointer na opierwszy element tablicy
mov ecx, [ebp+12]; rozmiar tab
mov edx, [ebp+16]; reduction type

cmp edx, 0 ; reductionType == 0, czyli suma
jne jedynka
;suma

ptl0: 
add eax, [ebx+ecx*4 -4]; dodanie wartosci kolejnych el tablicy
loop ptl0
jmp koniec

jedynka:
cmp edx, 1 ; reductionType == 1, czyli max
jne dwojka

mov eax, [ebx]

ptl1:
cmp eax, [ebx+ecx*4 -4]
jg kptl1
mov eax, [ebx+ecx*4 -4]
kptl1:
loop ptl1

jmp koniec


dwojka:; reductionType == 2, czyli min

mov eax, [ebx]

ptl2:
cmp eax, [ebx+ecx*4 -4]
jl kptl2
mov eax, [ebx+ecx*4 -4]
kptl2:
loop ptl2

koniec:
pop ecx
pop ebx
pop ebp
ret
_reduction ENDP
END