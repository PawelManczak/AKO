.686
.model flat


public _przemnoz

.code
_przemnoz PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
   
   ; float - Z - WWWW WWWW - M * 23

   ror eax, 23
   ; M * 23 - Z - W*8 ; wykladnik w al
   ; ma byc razy 32, czyli * 2^5 - czyli do wykladnika mozemy dodac 5
   add al, 5

   rol eax, 23 ; cofamy
   
   push eax
   fld dword ptr [esp]
   add esp, 4

    pop ebp
    ret
_przemnoz ENDP
END