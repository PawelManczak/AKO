.686
.XMM
.model flat
public _pm_jeden

.data
jedynki dd 1.0, 1.0, 1.0, 1.0
.code
_pm_jeden PROC
	push ebp
	mov ebp, esp
	push ebx
	; musza zostac zapamietane: XMM6 - XMM15

	mov eax, [ebp+8]; tab
	movups	xmm0, [eax]
	movups xmm1, xmmword ptr jedynki
	ADDSUBPS xmm0, xmm1
	movups	[eax], xmm0
	pop ebx
	pop ebp
	ret

_pm_jeden ENDP
END