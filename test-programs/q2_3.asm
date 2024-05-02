section .data
	int_format db "%ld",10,0


	global _main
	extern _printf
section .text


_start:	call _main
	mov rax, 60
	xor rdi, rdi
	syscall


_main:	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov esi, 3
	mov [rbp-8], esi
	mov esi, [rbp-8]
	mov [rbp-16], esi
	mov rax, [rbp-16]
	jmp finish_up
finish_up:	add rsp, 32
	leave 
	ret 

