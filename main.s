	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"No parameters are provided\n"
.LC1:
	.string	"-i"
.LC2:
	.string	"-f"
	.align 8
.LC3:
	.string	"Input/output files are not provided\n"
.LC4:
	.string	"r"
.LC5:
	.string	"w"
.LC6:
	.string	"Invalid parameter"
.LC7:
	.string	"%d"
.LC8:
	.string	"Invalid size of the array"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	# Стандартный пролог
	push	rbp  
	mov	rbp, rsp
	# Структура стека:
	# rbp_last
	# -8 - fin
	# -16 - fout
	# -24 - len
	# -32 - a
	# 40 - b
	# -44 - n
	# -52 - argc
	# -64 - argv

	sub	rsp, 64  # выделение памяти для локальных переменных на стеке
	mov	DWORD PTR -52[rbp], edi  # argc
	mov	QWORD PTR -64[rbp], rsi  # argv
	
	# случай отсутствия параметров
	cmp	DWORD PTR -52[rbp], 1 # argc == 1
	jne	.L2
	# fprintf(stderr, "No parameters are provided")
	mov	rax, QWORD PTR stderr[rip]
	mov	rcx, rax 
	mov	edx, 27
	mov	esi, 1 
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 1
	jmp	.L10
.L2:
	# !strcmp(argv[1], "-i")
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8 # argv[1]
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip] # "-i"
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L4
	mov	rax, QWORD PTR stdin[rip]
	mov	QWORD PTR -8[rbp], rax # fin = stdin
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -16[rbp], rax # fout = stdout
	jmp	.L5
.L4:
	# !strcmp(argv[1], "-f")
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8 # argv[1]
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L6
	# if (argc < 4)
	cmp	DWORD PTR -52[rbp], 3
	jg	.L7
	# fprintf(stderr, "Input/output files are not provided")
	mov	rax, QWORD PTR stderr[rip]
	mov	rcx, rax
	mov	edx, 36
	mov	esi, 1
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 1
	jmp	.L10
.L7:
	# fin = fopen(argv[2], "r")
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16 # argv[2]
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax # fin

	# fout = fopen(argv[2], "w")
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax # fout
	jmp	.L5
.L6:
	# fprtinf(stderr, "Invalid parameter")
	mov	rax, QWORD PTR stderr[rip]
	mov	rcx, rax
	mov	edx, 17
	mov	esi, 1
	lea	rax, .LC6[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 1
	jmp	.L10
.L5:
	# fscanf(fin, "%d", &n)
	lea	rdx, -44[rbp] # n
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, .LC7[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	
	# validate_size(n)
	mov	eax, DWORD PTR -44[rbp] # n
	mov	edi, eax
	call	validate_size@PLT
	test	eax, eax
	je	.L8
	# fprintf(fout, "Invalid size of the array")
	mov	rax, QWORD PTR -16[rbp] # fout
	mov	rcx, rax
	mov	edx, 25
	mov	esi, 1
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 0
	jmp	.L10
.L8:
	mov	eax, DWORD PTR -44[rbp] # n
	cdqe
	mov	QWORD PTR -24[rbp], rax # len

	# a = alloc_array(n)
	mov	eax, DWORD PTR -44[rbp] # n
	cdqe
	mov	rdi, rax
	call	alloc_array@PLT
	mov	QWORD PTR -32[rbp], rax # a

	# b = alloc_array(len)
	mov	rax, QWORD PTR -24[rbp] # len
	mov	rdi, rax
	call	alloc_array@PLT
	mov	QWORD PTR -40[rbp], rax # b

	# input_array(fin, a, len)
	mov	rdx, QWORD PTR -24[rbp] # len
	mov	rcx, QWORD PTR -32[rbp] # a
	mov	rax, QWORD PTR -8[rbp] # fin
	mov	rsi, rcx
	mov	rdi, rax
	call	input_array@PLT

	# build_array(a, b, 5)
	mov	rcx, QWORD PTR -40[rbp] # b
	mov	rax, QWORD PTR -32[rbp] # a
	mov	edx, 5
	mov	rsi, rcx
	mov	rdi, rax
	call	build_array@PLT
	mov	rdx, QWORD PTR -24[rbp] # len
	mov	rcx, QWORD PTR -40[rbp] # b
	mov	rax, QWORD PTR -16[rbp] # fout
	mov	rsi, rcx
	mov	rdi, rax
	call	print_array@PLT
	mov	rax, QWORD PTR stdin[rip]
	cmp	QWORD PTR -8[rbp], rax # fin
	je	.L9
	# fclose(fin)
	mov	rax, QWORD PTR -8[rbp] # fin
	mov	rdi, rax
	call	fclose@PLT
	
	# fclose(fout)
	mov	rax, QWORD PTR -16[rbp] # fout
	mov	rdi, rax
	call	fclose@PLT
.L9:
	# free_array(a)
	mov	rax, QWORD PTR -32[rbp] # a
	mov	rdi, rax
	call	free_array@PLT
	# free_array(b)
	mov	rax, QWORD PTR -40[rbp] # b
	mov	rdi, rax
	call	free_array@PLT
	mov	eax, 0
.L10:
	# Стандартный эпилог
	leave
	ret
