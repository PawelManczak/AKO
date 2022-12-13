.686
.model flat

public _wieksze
extern _malloc: PROC
.data

szesnascie db 16

.code
_wieksze PROC
push ebp
mov ebp, esp

push ebx
push esi
push edi

push 16 ; 4*4, bo float ma 4 bajty
call _malloc
add esp, 4

push eax ; zapisujemy adres pamieci, ktor zwraca nam malloc

mov esi, [ebp+8] ; tablica 1
mov ecx, [ebp+12] ; n
mov ebx, [ebp+16] ; dzielnijk

dec ecx
mov eax, ecx
mul szesnascie ; baza. np dla n = 3 najwyzsza baza bedzie 32 bajtow (128:8 = 16)
mov ecx, eax

finit; zerowanie koprocesora
ptl: ; dla konkretnej podtablicy po 4 elementy
	mov edi, 0; licznik, jesli = 4 to znaczy, ze znalezlismy
	mov edx, 12 ; indeks dla elementow w podtablicy, moze byc 12, 8, 4, 0 - bo floaty

	finit
	wewn:
	add edx, ecx ; zlozenie indeksu zewnetrznego i wewntrznego

		fld dword ptr [esi + edx] ; ladujemy wartosc danej z tablicy
		fst st(1) ; kopiowanie wierzcholka stosu do st(1) d - d , gdzie d to dana z tablicy
		fmul st(0), st(1) ; d^2 - d
		fmul st(0), st(1) ; d^3 - d
		fild dword ptr [ebp+16]; n - d^3 - d

		fcomi st(0), st(1) ; porwnani d^3 z argumentem funkcji
		jae nie_zwiekszamy_edx 
		inc edi	; jesli spelnia warunek to zwiekszamy licznik
		nie_zwiekszamy_edx:
	cmp edi, 4 ; znaleziono - mozna konczyc
	je koniec
	
	fstp st(0) 
	fstp st(0) ; czyszczenie koprocesora
	fstp st(0)

	sub edx, ecx ; usuniecie zlozenia indeksu zewnetrznego i wewntrznego
	sub edx, 4 ; zmniejszamy petle wewn
	cmp edx, -4 ; sterowanie petla wewn, tak jak wyjasnione w lini 37
	jne wewn
	
	
sub ecx, 16
cmp ecx, -16 ; sterowanie petla zewn tak jak w przykladzie z lini 31
jbe ptl

koniec:


pop eax ; w eax jest teraz adres pamieci z malloca

; zapis 4 floatow do do eax, adersu z malloca
mov ebx, dword ptr [esi + edx]
mov [eax], ebx
mov ebx, dword ptr [esi + edx + 4]
mov [eax+4], ebx
mov ebx, dword ptr [esi + edx + 8]
mov [eax+8], ebx
mov ebx, dword ptr [esi + edx + 12]
mov [eax+12], ebx

pop ebp
pop ebx
pop esi
pop edi
ret
_wieksze ENDP
END