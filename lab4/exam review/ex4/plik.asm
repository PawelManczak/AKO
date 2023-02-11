.686
.XMM
.model flat
public _int2float

.code
_int2float PROC
	push ebp
	mov ebp, esp
	push ebx
	; musza zostac zapamietane: XMM6 - XMM15

	mov eax, [ebp+8]; a
	mov ebx, [ebp+12]; b

	cvtpi2ps xmm5, qword PTR [eax]
	movsd qword ptr [ebx], xmm5

	pop ebx
	pop ebp
	ret

_int2float ENDP
END