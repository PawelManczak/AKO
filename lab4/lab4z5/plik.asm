.686
.XMM ; zezwolenie na asemblacje rozkazow z grupy SSE
.model flat


public _pm_jeden

.data
jedynki dd 1.0 , 1.0 , 1.0 , 1.0 ; floty maja 4 bajty
.code

_pm_jeden PROC
push ebp
mov ebp, esp

mov eax, [ebp+8]

movups xmm0, [eax]
addsubps xmm0, jedynki

movdqa [eax], xmm0
pop ebp
ret
_pm_jeden ENDP

END