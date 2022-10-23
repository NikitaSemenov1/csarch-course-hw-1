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
	
	# fin -> r12
	# fout -> r13
	# argc -> r14
	# argv -> r15

	# endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	r14, rdi
	mov	r15, rsi
	cmp	r14, 1
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
	mov	rax, r15
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L4
	mov	r12, QWORD PTR stdin[rip]
	mov	r13, QWORD PTR stdout[rip]
	jmp	.L5
.L4:
	mov	rax, r15
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L6
	cmp	r14, 3
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
	mov	rax, r15
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	r12, rax
	mov	rax, r15
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	r13, rax
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
	lea	rdx, -16[rbp]
	mov	rax, r12
	lea	rcx, .LC7[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	# n, len -> rbx
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	mov rbx, rax
	mov	edi, ebx
	call	validate_size@PLT
	test	eax, eax
	je	.L8
	mov	rax, r13
	mov	rcx, rax
	mov	edx, 25
	mov	esi, 1
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 0
	jmp	.L10
.L8:
	# a -> r14
	# b -> r15
	mov	rdi, rbx
	call	alloc_array@PLT
	mov	r14, rax # a

	mov	rdi, rbx
	call	alloc_array@PLT
	mov	r15, rax # b
	mov	rdx, rbx
	mov	rcx, r14
	mov	rsi, rcx
	mov	rdi, r12
	call	input_array@PLT
	mov	rcx, r15
	mov	rax, r14
	mov	edx, 5
	mov	rsi, rcx
	mov	rdi, rax
	call	build_array@PLT
	mov	rdx, rbx
	mov	rcx, r15
	mov	rsi, rcx
	mov	rdi, r13
	call	print_array@PLT
	mov	rax, QWORD PTR stdin[rip]
	cmp	r12, rax
	je	.L9
	mov	rax, r12
	mov	rdi, rax
	call	fclose@PLT
	mov	rdi, r13
	call	fclose@PLT
.L9:
	mov	rax, r14
	mov	rdi, rax
	call	free_array@PLT
	mov	rax, r15
	mov	rdi, rax
	call	free_array@PLT
	mov	eax, 0
.L10:
	leave
	ret
