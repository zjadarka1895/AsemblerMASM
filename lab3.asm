; KOD ASM
.686
.model flat
option casemap : none

extern _GetEnvironmentVariableA@12:proc
extern _SetEnvironmentVariableA@8: proc
public _ustaw_zmienna


.data
.code
	_ustaw_zmienna PROC
	push ebp; 
	mov ebp, esp; 
	push esi
	push edi

	mov ebx, [ebp + 8]; nazwa
	mov edx, [ebp + 12]; wartosc

	;sprawdzenie czy zmienna istnieje:
	push 0
	push 0
	push ebx ;nazwa
	call _GetEnvironmentVariableA@12

	cmp eax, 0 ;wynik get env var
	jne zmienna_istnieje

	push edx; wartosc
	push ebx ; nazwa
	call _SetEnvironmentVariableA@8
	jmp koniec

zmienna_istnieje:
	xor eax, eax

koniec:
	xor edx, edx

	pop edi
	pop esi
	pop ebp
	ret 
_ustaw_zmienna ENDP
END


