public sum_of_squares

.code
sum_of_squares PROC	
push rbp
mov rbp, rsp
push rbx
xor rax, rax ; szybkie zerowanie rax
xor rbx, rbx ; szybkie zerowanie rbx, suma

xchg rcx, rdx ; lepiej, zeby n bylo od razu w rcx
mov r8, rdx; bo przy mnozeniu rdx moze sie zmieniac
ptl:
mov rax, [r8+rcx*8-8]
mul rax
add rbx, rax
loop ptl

mov rax, rbx

pop rbx
pop rbp
ret
sum_of_squares ENDP
end	