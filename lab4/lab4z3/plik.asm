.686
.XMM ; zezwolenie na asemblacje rozkazow z grupy SSE
.model flat


public _dodaj_tablice

.code

_dodaj_tablice PROC
push ebp 
mov ebp, esp  
push esi  
push edi  
push ebx 
mov esi, [ebp+8] 
mov ebx, [ebp+12]
mov edi, [ebp+16]  
movups xmm0, xmmword ptr [esi]
movups xmm1, xmmword ptr [ebx]

paddsb	xmm0, xmm1
movups [edi], xmm0
pop ebx 
pop edi  
pop esi  
pop ebp  
ret
_dodaj_tablice ENDP

END