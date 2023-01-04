.686
.model flat

public _roznica
.code

_roznica PROC
push ebp
mov ebp, esp

mov eax, [ebp+8]
mov eax, [eax]

mov ecx, [ebp+12]
mov ecx, [ecx]
mov ecx, [ecx]

sub eax, ecx

pop ebp
ret
_roznica ENDP
end