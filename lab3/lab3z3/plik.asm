.686
.model flat
public _odejmij_jeden 
.code
_odejmij_jeden PROC
push ebp
mov ebp, esp

push ebx ; zapisujemy uzywane w podprogramie rejestry
push ecx

; na stosie mamy adres adresu zmiennej
mov eax, [ebp + 8] ; w eax mamy adres adresu zmiennej
mov ebx, [eax] ; w ebx jest teraz pointer
mov ecx, [ebx]; a w ecx wart

dec ecx

mov [ebx], ecx

pop ecx
pop ebx
pop ebp
ret
_odejmij_jeden ENDP
 END