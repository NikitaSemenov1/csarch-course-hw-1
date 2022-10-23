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
	push	rbp
	mov	rbp, rsp
	mov	rax, rdi
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	leave
	ret
	.size	alloc_array, .-alloc_array
	.globl	free_array
	.type	free_array, @function
free_array:
	push	rbp
	mov	rbp, rsp
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
	push	rbp
	mov	rbp, rsp
	
	push r12
	push r13
	push r14
	push r15
	
	mov	r12, rdi
	mov	r13, rsi
	mov	r14, rdx
	mov	r15, 0
	jmp	.L5
.L6:
	mov	rax, r15
	lea	rdx, 0[0+rax*4]
	mov	rax, r13
	add	rdx, rax
	mov	rax, r12
	lea	rcx, .LC0[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	add r15, 1
.L5:
	mov	rax, r15
	cmp	rax, r14
	jb	.L6
	nop
	nop
	pop r15
	pop r14
	pop r13
	pop r12
	leave
	ret
	.size	input_array, .-input_array
	.globl	validate_size
	.type	validate_size, @function
validate_size:
	push	rbp
	mov	rbp, rsp
	
	cmp	edi, 0
	js	.L8
	mov	eax, 1000000
	cmp	edi, eax
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
	push	rbp
	mov	rbp, rsp
	push r12
	push r13
	push r14
	push r15
	
	mov	r12, rdi
	mov	r13, rsi
	mov	r14, rdx
	mov	r15, 0
	jmp	.L13
.L14:
	mov	rax, r15
	lea	rdx, 0[0+rax*4]
	mov	rax, r13
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, r12
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	add	r15, 1
.L13:
	mov	rax, r15
	cmp	rax, r14
	jb	.L14
	mov	edi, 10
	call	putchar@PLT
	nop

	pop r15
	pop r14
	pop r13
	pop r12
	
	leave
	ret
	.size	print_array, .-print_array
	.globl	build_array
	.type	build_array, @function
build_array:
	push	rbp
	mov	rbp, rsp
	mov	r9, rdx
	mov	r8, 0
	jmp	.L16
.L19:
	mov	rax, r8
	lea	rdx, 0[0+rax*4]
	mov	rax, rsi
	add	rax, rdx
	mov	DWORD PTR [rax], 0
	mov	rax, r8
	lea	rdx, 0[0+rax*4]
	mov	rax, rdi
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	eax, -5
	jge	.L17
	mov	rax, r8
	lea	rdx, 0[0+rax*4]
	mov	rax, rdi
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, r8
	lea	rcx, 0[0+rax*4]
	mov	rax, rsi
	add	rax, rcx
	sub	edx, 5
	mov	DWORD PTR [rax], edx
	jmp	.L18
.L17:
	mov	rax, r8
	lea	rdx, 0[0+rax*4]
	mov	rax, rdi
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	eax, 5
	jle	.L18
	mov	rax, r8
	lea	rdx, 0[0+rax*4]
	mov	rax, rdi
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, r8
	lea	rcx, 0[0+rax*4]
	mov	rax, rsi
	add	rax, rcx
	add	edx, 5
	mov	DWORD PTR [rax], edx
.L18:
	add	r8, 1
.L16:
	mov	rax, r8
	cmp	rax, r9
	jb	.L19
	nop
	nop
	pop	rbp
	ret
	.size	build_array, .-build_array
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
