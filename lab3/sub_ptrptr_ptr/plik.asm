.686
.model flat

public _odejmowanie
.code
_odejmowanie PROC
push ebp
mov ebp, esp

push ebx
push ecx
push edx

mov ebx, [ebp+8]; ptr na ptr
mov ecx, [ebx]; ptr odjemnej
mov edx, [ebp+12]; ptr odjemnika

mov eax, [ecx]
sub eax, [edx]

pop edx
pop ecx
pop ebx
pop ebp
ret
_odejmowanie ENDP
END