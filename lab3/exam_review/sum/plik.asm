.686
.model flat

public _sum

.code
_sum PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ecx, [ebp+8] ; n

	mov eax, 0 ; suma

	ptl:
		add eax, [ebp+8+ecx*4]
	loop ptl
	
	pop ebx
	pop ebp
	ret
_sum ENDP
END