.686 
.model flat

public _main

.code

_main PROC

;20. Napisaæ fragment programu w asemblerze, który
;zamieni m³odsz¹ (bity 15 – 0) i starsz¹ (bity 31 – 16) czêœæ
;rejestru EDX.

mov edx, 0FFFF0000h

rol edx, 16

_main ENDP
END