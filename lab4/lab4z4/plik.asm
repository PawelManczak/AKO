.686
.XMM ; zezwolenie na asemblacje rozkazow z grupy SSE
.model flat


public _int2float

.code

_int2float PROC
push ebp 
mov ebp, esp  
push esi  
push edi  
push ebx 
mov esi, [ebp+8] ; inty
mov edi, [ebp+12] ; tablica wyjsciowa we we floatach

cvtpi2ps xmm5, qword PTR [esi]
movq qword ptr [edi], xmm5
pop ebx 
pop edi  
pop esi  
pop ebp  
ret
_int2float ENDP

END