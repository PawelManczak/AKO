public sum

.code
sum PROC
	push rbp
	mov rbp, rsp

	; [argumenty przez stos]
	; [shadowspace] - 32 bajty
	; [slad] - 8 bajty !!!!
	; [rbp] - 8 bajtow

	mov rax, 0 ; suma

	cmp rcx, 0 ; nie ma arg
	je koniec

	add rax, rdx
	cmp rcx, 1
	je koniec ; tylko 1

	add rax, r8
	cmp rcx, 2
	je koniec; tylko 2

	add rax, r9
	cmp rcx, 3
	je koniec; tylko 3
	; reszta parametrow przez stos

	sub rcx, 3 ; odejmujemy te z rej
	; jesli nie jest zdefiniowany typ to z automatu bierze OSIEM bajtow
	ptl:
		add rax, [rbp+48 + rcx*8 - 8]
	loop ptl

	koniec:

	pop rbp
	ret
sum ENDP
END