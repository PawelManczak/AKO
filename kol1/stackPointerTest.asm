.686 
.model flat

public _main

.code

_main PROC

;20. Napisa� fragment programu w asemblerze, kt�ry
;zamieni m�odsz� (bity 15 � 0) i starsz� (bity 31 � 16) cz��
;rejestru EDX.

mov edx, 0FFFF0000h

rol edx, 16

_main ENDP
END