.686
.model flat


public _sortowanie

.code
_sortowanie PROC
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    
    mov ecx, 0; indeks "i"
    mov edx, 0; indeks "j"
    mov edi, [ebp+8]; adres pierwszego el tab

    ptl_zewn:
        mov edx, 0 ; zerowanie "j"
        ptl_wewn:
        mov eax, [edi+8*ecx+4] ; starsza czesc 1 el
        mov ebx, [edi+8*edx+4] ; starsza czesc 2 el

        cmp eax, ebx
        ja wieksze
        jb mniejsze
        ; jesli stasze czesi sa rowne rozpatrujemy mniejsze

        mov eax, [edi+8*ecx] ; mlodsza czesc 1 el
        mov ebx, [edi+8*edx] ; mlodsza czesc 2 el

        cmp eax, ebx
        ja wieksze
        jb mniejsze

        wieksze:
            mov esi, dword ptr [edi+8*ecx] ; w esi jest wart pierwszego el
            xchg dword ptr [edi+8*edx], esi ; 1 czesc
            mov dword ptr [edi+8*ecx], esi

            mov esi, dword ptr [edi+8*ecx+4]
            xchg dword ptr [edi+8*edx+4], esi ; 1 czesc
            mov dword ptr [edi+8*ecx+4], esi
            jmp koniec_ptl_wewn
        mniejsze:
        koniec_ptl_wewn:
        inc edx
        cmp edx, dword ptr [ebp+12]
        jb ptl_wewn

        ;sterowanie ptl zewn
        inc ecx
        cmp ecx, dword ptr [ebp+12]
        jb ptl_zewn

        mov ecx, dword ptr [ebp+12]; n
        mov edx, 0
        mov eax, [ebp+8]
        mov eax, [eax+ecx*8-8]
        mov edx, [ebp+8]
        mov edx, [edx+ecx*8-4]
        ;mov eax, [eax]

        pop edi
        pop esi
        pop ebx
        pop ebp

    ret
_sortowanie ENDP
END