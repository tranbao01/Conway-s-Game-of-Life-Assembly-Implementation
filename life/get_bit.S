.text
.global get_bit


//
// Get a bit from an array of words.
// x0 - Array of integers
// w1 - Width of the array in bits
// w2 - Desired bit
//
get_bit:
	stp x29,x30,[sp,#-16]!
	stp x19,x20,[sp,#-16]!
	stp x21,x22,[sp,#-16]!
	stp x23,x24,[sp,#-16]!
	stp x25,x26,[sp,#-16]!
	stp x27,x28,[sp,#-16]!
	
	cmp w2,#0
	blt zero
	cmp w2,w1
	bge zero
	
	mov w19,w2
	
	lsr w20,w19,#5
	and w21,w19,#0x1f
	
	lsl w27,w20,#5
	and w21,w19,#0x1f
	
	lsl w27,w20,#2
	ldr w23,[x0,w27,uxtw]
	
	mov w27,#31
	sub w25,w27,w21
	
	lsr w21,w23,w25
	and w0,w21,#1
	
	b get_bit_done
zero:
	mov w0,#0
	b get_bit_done
get_bit_done:
	ldp x27,x28,[sp],#16
	ldp x25,x26,[sp],#16
	ldp x23,x24,[sp],#16
	ldp x21,x22,[sp],#16
	ldp x19,x20,[sp],#16
	ldp x29,x30,[sp],#16
	ret     
