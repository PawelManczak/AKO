.686
.model flat

public _szukaj4_max


.code
_szukaj4_max PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp+8]
	mov ebx, [ebp+12]	
	mov ecx, [ebp+16]
	mov edx, [ebp+20]

	;sprawdzamy a
	cmp eax, ebx
	jl bb
		cmp eax, ebx
		jl bb
		cmp eax, ecx
		jl bb

		jmp koniec; a juz wpisane
	bb:
		cmp ebx, eax
		jl cc
		cmp ebx, ecx
		jl cc
		cmp ebx, edx
		jl cc
		mov eax, ebx
		jmp koniec
	cc:
		cmp ecx, eax
		jl ddd
		cmp ecx, ebx
		jl ddd
		cmp ecx, edx
		jl ddd
		mov eax, ecx
		jmp koniec
	ddd:
	mov eax, edx

	koniec:

		
	pop ebx
	pop ebp
	ret
_szukaj4_max ENDP
END

