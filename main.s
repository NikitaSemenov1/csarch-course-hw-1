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
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 1
	jne	.L2
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
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L4
	mov	rax, QWORD PTR stdin[rip]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L5
.L4:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L6
	cmp	DWORD PTR -52[rbp], 3
	jg	.L7
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
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	jmp	.L5
.L6:
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
	lea	rdx, -44[rbp]
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, .LC7[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	eax, DWORD PTR -44[rbp]
	mov	edi, eax
	call	validate_size@PLT
	test	eax, eax
	je	.L8
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	mov	edx, 25
	mov	esi, 1
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 0
	jmp	.L10
.L8:
	mov	eax, DWORD PTR -44[rbp]
	cdqe
	mov	QWORD PTR -24[rbp], rax
	mov	eax, DWORD PTR -44[rbp]
	cdqe
	mov	rdi, rax
	call	alloc_array@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	alloc_array@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	rdx, QWORD PTR -24[rbp]
	mov	rcx, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	input_array@PLT
	mov	rcx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -32[rbp]
	mov	edx, 5
	mov	rsi, rcx
	mov	rdi, rax
	call	build_array@PLT
	mov	rdx, QWORD PTR -24[rbp]
	mov	rcx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	print_array@PLT
	mov	rax, QWORD PTR stdin[rip]
	cmp	QWORD PTR -8[rbp], rax
	je	.L9
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
.L9:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	free_array@PLT
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	free_array@PLT
	mov	eax, 0
.L10:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
