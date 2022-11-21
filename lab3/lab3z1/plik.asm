.686
.model flat
public _szukaj4_max
.code
_szukaj4_max PROC
push ebp ; zapisanie zawartoœci EBP na stosie
mov ebp, esp

; wpisanie do eax a // eax = wynik
mov eax, [ebp + 8]


cmp eax, [ebp + 12] 
jg cc ; wynik <  b

mov eax, [ebp + 12] 
cc:
cmp eax, [ebp + 16] 
jg d  ;wynik <  c

mov eax, [ebp + 16] 
d:
cmp eax, [ebp + 20] 
jg koniec ;wynik <  d

mov eax, [ebp + 20] 

koniec:


pop ebp
ret
_szukaj4_max ENDP
 END