.686
.model flat

public _negacja


.code
_negacja PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8] ; pointer
	neg dword ptr [eax]

	pop ebp
	ret
_negacja ENDP
END

