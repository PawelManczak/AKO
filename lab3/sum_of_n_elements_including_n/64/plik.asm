public sum
.code
sum PROC
push rbp  
mov rbp, rsp  
push rbx

xor rax, rax  ; zerowanie w szybki sposob rax

cmp rcx, 0  
je koniec  
add rax, rdx  
cmp rcx, 1  
je koniec  
add rax, r8  
cmp rcx, 2  
je koniec  
add rax, r9  
cmp rcx, 3  
je koniec  


sub rcx, 3  
; 16 bajtow - 2 parametry przekazywane  ??
; 32 bajty - shadow space  
; 48 bajt - pi¹ty argument
ptl:
add rax, [rbp+40+8*rcx] 
loop ptl


koniec:  

pop rbx  
pop rbp  
ret
sum ENDP
END