
.global set_bit


//
// Get a bit from an array of words.
// x0 - Array of integers
// w1 - Width of the array in bits
// w2 - Desired bit
// w3 - 1 if bit is to be set
//
set_bit:
	stp x29,x30,[sp,#-16]!
	stp x19,x20,[sp,#-16]!
	stp x21,x22,[sp,#-16]!
	stp x23,x24,[sp,#-16]!
	stp x25,x26,[sp,#-16]!
	stp x27,x28,[sp,#-16]!
	
	cmp w2,#0
	blt set_bit_done
	cmp w2,w1
	bge set_bit_done
	

	
	mov w19,w2 
	
	lsr w20,w19,#5
	and w21,w19,#0x1f
	
	lsl w23,w20,#2
	ldr w24,[x0,w23,uxtw]
	
	cmp w3,#0
	beq bicc
	
	mov w22,#1
	mov w25,#31
	sub w25,w25,w2
	lsl w22,w22,w25
	
	orr w26,w24,w22
	str w26,[x0,w23,uxtw]
	
	b set_bit_done
bicc:
	mov w22,#1
	mov w25,#31
	sub w25,w25,w2
	lsl w22,w22,w25
	
	bic w26,w24,w22
	str w26,[x0,w23,uxtw]
	b set_bit_done

set_bit_done:
	ldp x27,x28,[sp],#16
	ldp x25,x26,[sp],#16
	ldp x23,x24,[sp],#16
	ldp x21,x22,[sp],#16
	ldp x19,x20,[sp],#16
	ldp x29,x30,[sp],#16
	ret
















	ret     
