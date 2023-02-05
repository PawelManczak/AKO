; Przyk³ad wywo³ywania funkcji MessageBoxA i MessageBoxW
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC ; - ASCII (American Standard for Information Interchange) - UTF-8
extern _MessageBoxW@16 : PROC ; - UTF-16
public _main
.data

tytul_Unicode dw 'T','e','k','s','t',' ','w',' '
dw 'f','o','r','m','a','c','i','e',' '
dw 'U','T','F','-','1','6', 0

tekst_Unicode dw 'K','a', 017CH ,'d','y',' ','z','n','a','k',' '
dw 'z','a','j','m','u','j','e',' '
dw '1','6',' ','b','i','t', 00F3H,'w', 0

tytul_Win1250 db 'Tekst w standardzie Windows 1250', 0
tekst_Win1250 db 'Ka', 0BFh, 'dy znak zajmuje 8 bit', 0F3h ,'w', 0

.code
_main PROC

;int MessageBox(HWND hWnd, LPCTSTR lpText, LPCTSTR lpCaption, UINT uType);

; korzystanie z MB:
; 1.
 push 0 ; sta³a MB_OK
; 2.
 push OFFSET tytul_Win1250 ; adres obszaru zawieraj¹cego tytu³
 ; 3.
 push OFFSET tekst_Win1250 ; adres obszaru zawieraj¹cego tekst
 ; 4.
 push 0 ; NULL
 ; 5.
 call _MessageBoxA@16; stdCall, wiec nie trzeba zdejmowac argumentow


 push 0 
 push OFFSET tytul_Unicode
 push OFFSET tekst_Unicode
 push 0 ; NULL
 call _MessageBoxW@16

 push 0 ; kod powrotu programu
 call _ExitProcess@4
_main ENDP
END