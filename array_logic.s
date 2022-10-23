	.file	"array_logic.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 4
	.type	NMAX, @object
	.size	NMAX, 4
NMAX:
	.long	1000000
	.text
	.globl	alloc_array
	.type	alloc_array, @function
alloc_array:
	endbr64
	# Стандартный пролог
	push	rbp
	mov	rbp, rsp

	# Структура фрейма:
	# rbp
	# -8 len

	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi # len
	mov	rax, QWORD PTR -8[rbp] 
	sal	rax, 2 # 4 * len
	mov	rdi, rax
	call	malloc@PLT
	leave
	ret
	.size	alloc_array, .-alloc_array
	.globl	free_array
	.type	free_array, @function
free_array:
	endbr64
	# Стандартный пролог
	push	rbp
	mov	rbp, rsp

	# Структура фрейма:
	# rbp
	# -8 array
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi # array
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	free@PLT
	nop
	leave
	ret
	.size	free_array, .-free_array
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	input_array
	.type	input_array, @function
input_array:
	endbr64
	# Стандартный пролог
	push	rbp
	mov	rbp, rsp

	# Структура фрейма:
	# rbp
	# -8 - i
	# -24 - fin
	# -32 - array
	# -40 - len
	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi # file
	mov	QWORD PTR -32[rbp], rsi # array
	mov	QWORD PTR -40[rbp], rdx # len
	mov	QWORD PTR -8[rbp], 0 # i
	jmp	.L5
.L6:
	mov	rax, QWORD PTR -8[rbp] # i
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp] # array
	add	rdx, rax
	
	mov	rax, QWORD PTR -24[rbp]
	lea	rcx, .LC0[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	add	QWORD PTR -8[rbp], 1 # i++
.L5:
	mov	rax, QWORD PTR -8[rbp] # i
	cmp	rax, QWORD PTR -40[rbp] # i < len
	jb	.L6
	nop
	nop
	leave
	ret
	.size	input_array, .-input_array
	.globl	validate_size
	.type	validate_size, @function
validate_size:
	endbr64
	# Стандартный пролог
	push	rbp
	mov	rbp, rsp

	# Структура фрейма:
	# rbp
	# -4 - n	
	mov	DWORD PTR -4[rbp], edi # n
	cmp	DWORD PTR -4[rbp], 0
	js	.L8
	mov	eax, 1000000
	cmp	DWORD PTR -4[rbp], eax # n
	jle	.L9
.L8:
	mov	eax, 1
	jmp	.L11
.L9:
	mov	eax, 0
.L11:
	pop	rbp
	ret
	.size	validate_size, .-validate_size
	.section	.rodata
.LC1:
	.string	"%d "
	.text
	.globl	print_array
	.type	print_array, @function
print_array:
	endbr64
	# Стандартный пролог
	push	rbp
	mov	rbp, rsp

	# Структура фрейма:
	# rbp
	# -8 - i
	# -24 - file
	# -32 - array
	# -40 - len

	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi # file
	mov	QWORD PTR -32[rbp], rsi # array
	mov	QWORD PTR -40[rbp], rdx # len
	mov	QWORD PTR -8[rbp], 0 # i
	jmp	.L13
.L14:
	mov	rax, QWORD PTR -8[rbp] # i
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp] # array
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp] # file
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	add	QWORD PTR -8[rbp], 1 # i
.L13:
	mov	rax, QWORD PTR -8[rbp] # i
	cmp	rax, QWORD PTR -40[rbp] # len
	jb	.L14
	mov	edi, 10 # '\n'
	call	putchar@PLT
	nop
	leave
	ret
	.size	print_array, .-print_array
	.globl	build_array
	.type	build_array, @function
build_array:
	endbr64
	# Стандартный пролог
	push	rbp
	mov	rbp, rsp

	# Структура фрейма:
	# rbp
	# -8 - i
	# -24 - a
	# -32 - b
	# -40 - len
	mov	QWORD PTR -24[rbp], rdi # a
	mov	QWORD PTR -32[rbp], rsi # b
	mov	QWORD PTR -40[rbp], rdx # len
	mov	QWORD PTR -8[rbp], 0 # i
	jmp	.L16
.L19:
	mov	rax, QWORD PTR -8[rbp] # i
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp] # b
	add	rax, rdx
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR -8[rbp] # i
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp] # a
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	eax, -5
	jge	.L17
	mov	rax, QWORD PTR -8[rbp] # i
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp] # a
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp] # i
	lea	rcx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp] # b
	add	rax, rcx
	sub	edx, 5
	mov	DWORD PTR [rax], edx
	jmp	.L18
.L17:
	mov	rax, QWORD PTR -8[rbp] # i
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp] # a
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	eax, 5
	jle	.L18
	mov	rax, QWORD PTR -8[rbp] # i
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp] # a
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp] # i
	lea	rcx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp] # b
	add	rax, rcx
	add	edx, 5
	mov	DWORD PTR [rax], edx
.L18:
	add	QWORD PTR -8[rbp], 1 # i
.L16:
	mov	rax, QWORD PTR -8[rbp] # i
	cmp	rax, QWORD PTR -40[rbp] # len
	jb	.L19
	nop
	nop
	pop	rbp
	ret
