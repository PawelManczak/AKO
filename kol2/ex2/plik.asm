.686
.model flat

public _kopia_tablicy
extern _malloc: PROC

.data
cztery db 4

.code
_kopia_tablicy PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov eax, [ebp+12]; n
mul cztery
push eax

call _malloc ; w eax jest adres
add esp, 4

push eax

mov edx, [ebp+8] ; adres pierwszej komorki tab
mov ecx, [ebp+12] ; n

push eax
mov eax, ecx
mul cztery
mov ecx, eax ; w ecx jest n*4, bo inty
pop eax

ptl:
	mov ebx, [edx + ecx - 4]
	mov [eax + ecx - 4], ebx
sub ecx, 4
cmp ecx, 0
jge ptl

pop eax
pop edi
pop esi
pop ebx
pop ebp
ret
_kopia_tablicy ENDP
end