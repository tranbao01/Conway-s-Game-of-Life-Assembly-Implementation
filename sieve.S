//
// Data section
//
.data

usage: .asciz "Usage: sieve <size>\n";

minsize: .asciz "Sieve size must be at least 2\n" 
primes: .asciz "Primes:"
return: .asciz "\n"
number: .asciz "%d"
//
// Text section
//

.text

.global main

//
// main(argc, argv)
// w0: The number of arguments
// x1: Pointer to an array of string pointers
// 
main: 
    stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
    stp x19, x20, [sp, #-16]!   // Push x19 and x20 onto the stack
    stp x21, x22, [sp, #-16]!   // Push x21 and x22 onto the stack
    
    cmp w0,#2
    bge args_ok

    ldr x0,=usage
    bl printf

    mov w0, #1
    b main_return

args_ok:
    ldr x0,[x1,#8]
    bl atoi

    cmp w0,#2
    bge size_ok

    ldr x0,=minsize
    bl printf

    mov w0,#1
    b main_return

size_ok:
    size .req w19
    mov size,w0
    
    add w0,size,#1
    mov w1,#4
    bl calloc

    sieve .req x20
    mov sieve, x0
  
    mov x0,sieve
    mov w1, size
    bl initialize    

    mov x0,sieve
    mov w1,size
    bl sieve_it

    mov x0,sieve
    mov w1,size
    bl display   
 
    mov x0,sieve
    bl free
 
    mov x0,#0
main_return:
    ldp x21, x22, [sp], #16     // Restore x21 and x22 from the stack
    ldp x19, x20, [sp], #16     // Restore x19 and x20 from the stack
    ldp x29, x30, [sp], #16     // Restore fp and lr from the stack
    ret
    
    .unreq size
    .unreq sieve
//
// display(int* sieve, int size)
// x0: Pointer to an array of integers
// w1: Size of the array
//
display:
    stp x29,x30,[sp,#-16]!
    stp x19,x20,[sp,#-16]!
    stp x21,x22,[sp,#-16]!
    size .req w19
    sieve .req x20
    mov size, w1
    mov sieve, x0

    ldr x0,=primes
    bl printf
   

    i .req w21
    mov i, #2
display_loop:
    cmp i,size
    bgt display_loop_end
    
    lsl w1,i,#2
    ldr w0, [sieve,w1,uxtw]

    cmp w0,#0
    beq display_skip
 
    ldr x0,=number
    mov w1,i
    bl printf

display_skip:
    add i,i,#1
    b display_loop

display_loop_end:
    ldr x0,=return
    bl printf
display_return:
    ldp x21,x22,[sp],#16
    ldp x19,x20,[sp],#16
    ldp x29,x30,[sp],#16
    ret
    
    .unreq size
    .unreq sieve
    .unreq i
///
/// intialize(int*sieve, int size)
/// x0: Pointer to an array of integers
/// w1: Size of the array
///
initialize:
	stp x29,x30,[sp,#-16]!
	stp x19,x20,[sp,#-16]!
	stp x21,x22,[sp,#-16]!

	size .req w19
	sieve .req x20
	mov size, w1
	mov sieve, x0

	i .req w21
	mov i, #2
initialize_loop:
	cmp i,size
	bgt initialize_loop_end
	
	mov w0,#1	
	lsl w1,i,#2
	str w0,[sieve,w1,uxtw]

	add i,i,#1
	b initialize_loop
initialize_loop_end:

init_done:
	ldp x21,x22,[sp],#16
	ldp x19,x20,[sp],#16
	ldp x29,x30,[sp],#16
	ret

	.unreq size	
	.unreq sieve
	.unreq i
//
// sieve_it(int *sieve, int size)
// x0: Pointer to an array of integers
// w1: size of the array
//
sieve_it:
	stp x29,x30,[sp,#-16]!
	stp x19,x20,[sp,#-16]!
	stp x21,x22,[sp,#-16]!

	size .req w19
	sieve .req x20
	mov size, w1
	mov sieve, x0

	i .req w21
	mov i,#2
	j .req w22
	mov j, #2
sieve_it_loop:
	lsr w2,size,#1
	cmp i,w2
	bgt sieve_it_loop_end


  	
	lsl j,i,#1

sieve_it_loop2:
	mov w0,#0

	cmp j,size
	bgt sieve_it_loop3
	
	lsl w1,j,#2
	str w0,[sieve,w1,uxtw]
	
	add j,j,i
	b sieve_it_loop2
sieve_it_loop3:
	add i,i,#1
	b sieve_it_loop
sieve_it_loop_end:
	
sieve_it_done:
	ldp x21,x22,[sp],#16
	ldp x19,x20,[sp],#16
	ldp x29,x30,[sp],#16
	ret
	.unreq size
	.unreq i
	.unreq sieve
	.unreq j





















