.686
.model flat

public _avg_wd

.code
_avg_wd PROC
    push ebp
    mov ebp, esp
    push ebx

    mov ecx, [ebp+8] ; n
    mov ebx, [ebp+12] ; wart
    mov edx, [ebp+16]; wagi

    finit
    fldz ; zero jako pocz wart sumy
    
    ptl:
    fld dword ptr [ebx+ecx*4-4] ;el wart - suma
    fld dword ptr [edx+ecx*4-4]; el wagi - el wart - suma
    fmulp st(1), st(0); mnozenie - suma

    faddp st(1), st(0); suna
    loop ptl



    mov ecx, [ebp+8] ; n
    fldz ; sumawag - suma
    plt2:
        fld dword ptr [edx+ecx*4-4]; el - suma wag - suma
        faddp st(1), st(0)
    loop plt2

    fdivp st(1), st(0)

    pop ebx
    pop ebp
    ret
_avg_wd ENDP
END