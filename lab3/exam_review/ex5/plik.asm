public suma_siedmiu_liczb


.code
suma_siedmiu_liczb PROC
	push rbp
	mov rbp, rsp

	mov rax, 0; suma
	; pierwsze 4 - przez rejestry:
	; * RCX, RDX, R8, R9
	add rax, rcx
	add rax, rdx
	add rax, r8
	add rax, r9
	; < Rejestry >		-- liczba bajtow%16 == 0	^
	; < Shadowspace >	-- 32 bajty					I
	; < Slad >			-- 8 bajty					I
	; < RBP >			-- 8 bajtow					I

	; najpierw pushujemy brakujace rejestry
	; pozniej rezerwujemy shadowspace (32 bajty)
	; wywolujemy funkcje
	; wykonujemy prolog


	; pozostale 3 przekazane przez stos
	add rax, [rbp+48]
	add rax, [rbp+56]
	add rax, [rbp+64]

	; wynik w rax
	pop rbp
	ret
suma_siedmiu_liczb ENDP
END

