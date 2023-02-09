.686
.model flat

public _odejmij_jeden


.code
_odejmij_jeden PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8] ; pointer na pointer
	mov eax, [eax] ; pointer
	sub [eax], dword ptr 1

	pop ebp
	ret
_odejmij_jeden ENDP
END

