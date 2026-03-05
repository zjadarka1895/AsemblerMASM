.model flat
.686
public _simpson
.data

.code
wyznacz_y_i PROC

	push ebp
	mov ebp, esp

	fld dword ptr [ebp + 8]; x_i
	fld dword ptr [ebp + 8]

	fmul st(1), st(0)
	fmul st(1), st(0); st(1) = x ^ 3

	fsin
	fmul; st(0) = x ^ 3 * sin(x)

	fld dword ptr [ebp + 8]
	push 5
	fild dword ptr [esp]
	add esp, 4
	fmul
	fsubp

	pop ebp

	ret 4


wyznacz_y_i ENDP

_simpson PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	finit
	fld dword ptr [ebp + 12]; b st(0)
	fsub dword ptr [ebp + 8]; st(0) = b - a
	fidiv dword ptr [ebp + 16]; st(0) = h, st(1) = b, st(2) = a

	mov ecx, [ebp + 16]
	fld dword ptr [ebp + 8]
	fadd st(0), st(1); st(0) = x1, st(1) = h
	push 0
	fild dword ptr [esp]; suma na szczycie stosu, st(1) = x1, st(2) = 2h
	add esp, 4
	mov eax, 1; i
	sub ecx, 1
	suma:
		fld st(1)
		sub esp, 4
		fstp dword ptr [esp]
		call wyznacz_y_i; st(0) = y_i, st(1) = suma, st(2) = x_i
		
		test eax, 1
		jz parzysta
		fadd st(0), st(0); nieparzyste i->y * 4
		parzysta:
		fadd st(0), st(0); parzyste i->y * 2
		faddp; dodanie do sumy
		
		fld ST(2)
		faddp st(2), st(0); nowy x_i
		add eax, 1
	loop suma

	push[ebp + 8]
	call wyznacz_y_i
	faddp

	push[ebp + 12]
	call wyznacz_y_i
	faddp

	fmulp st(2), st(0); suma wszystkich* h
	FSTP ST(0)
	push 3
	fild dword ptr [esp]
	add esp, 4
	fdiv

	pop ebx
	pop edi
	pop esi
	pop ebp
ret
_simpson ENDP
END











