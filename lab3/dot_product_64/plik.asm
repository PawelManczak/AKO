public dot_product

.code
dot_product PROC
push rbp
mov rbp, rsp

push rbx


mov r9, rcx ; wskaznik na 1 wektor
mov r10, rdx ; wskaznik na 2 wektor
mov rcx, r8; n - dlugosc

xor rax, rax; szybkie zerowanie
xor rbx, rbx; wynik
ptl:
xor rax, rax; szybkie zerowanie

mov rax, [r9+rcx*8-8]; pierwszy element do r
imul dword ptr [r10+rcx*8-8]; drugi i mnozenie
add rbx, rax; do sumy

loop ptl

mov rax, rbx

pop rbx
pop rbp
ret
dot_product ENDP

END