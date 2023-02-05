.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC ; - UTF-16
public _main
.data

tytul_Unicode dw 'P', 'i', 'e', 's', ' ', 'i', ' ', 'k', 'o', 't', 0

tekst_Unicode dw 'P', 'i', 'e', 's', 0D83Dh, 0DC08h,
					' ', 'i', ' ', 'k', 'o', 't', 0D83Dh, 0DC31h, 0
.code
_main PROC

;int MessageBox(HWND hWnd, LPCTSTR lpText, LPCTSTR lpCaption, UINT uType);

 push 0 
 push OFFSET tytul_Unicode
 push OFFSET tekst_Unicode
 push 0 ; NULL
 call _MessageBoxW@16

 push 0 ; kod powrotu programu
 call _ExitProcess@4
_main ENDP
END