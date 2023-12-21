.data


.text

.global life

//
// life iteration calculator
// x0 - int *cells
// w1 - int width in words
// w2 - int height in rows
//
life: 
	stp x29,x30,[sp,#-16]!
	stp x19,x20,[sp,#-16]!
	stp x21,x22,[sp,#-16]!
	stp x23,x24,[sp,#-16]!
	stp x25,x26,[sp,#-16]!
	stp x27,x28,[sp,#-16]!

	ocells .req x19
	width .req w20
	height .req w21
	size .req w22
	totalbits .req w23
	counter1 .req w24
	counter2 .req w25
	newcells .req x26
	sum .req w27

	mov ocells, x0
	mov width, w1
	mov height, w2
	mul size, width, height
	lsl totalbits, size, #5
	mov counter1,#0
	mov counter2,#0
	mov sum,#0
	lsl w28,width,#5
	
	add w0,size,#1
	mov w1,#4
	bl calloc
	
	mov newcells,x0

loopsetbit:
	mov sum,#0
	cmp counter1,totalbits
	bge loopsetbitend
	
	mov x0,ocells
	mov w1,totalbits
	sub w2,counter1,#1
	bl get_bit
	add sum,sum,w0
	
	mov x0,ocells
	mov w1,totalbits
	add w2,counter1,#1
	bl get_bit
	add sum,sum,w0
	
	mov x0,ocells
	mov w1,totalbits
	sub w2,counter1,w28
	bl get_bit
	add sum,sum,w0

	mov x0,ocells
	mov w1,totalbits
	add w2,counter1,w28
	bl get_bit
	add sum,sum,w0
	
	mov x0,ocells
	mov w1,totalbits
	sub w2,counter1,w28
	sub w2,w2,#1
	bl get_bit
	add sum,sum,w0
	
	mov x0,ocells
	mov w1,totalbits
	sub w2,counter1,w28
	add w2,w2,#1
	bl get_bit
	add sum,sum,w0
	
	mov x0,ocells
	mov w1,totalbits
	add w2,counter1,w28
	sub w2,w2,#1
	bl get_bit
	add sum,sum,w0
	
	mov x0,ocells
	mov w1,totalbits
	add w2,counter1,w28
	add w2,w2,#1
	bl get_bit
	add sum,sum,w0
	

	cmp sum,#2
	blt setbit0
	
	cmp sum,#2
	beq setbitnochange
	
	cmp sum,#3
	beq setbit1
	
	
	cmp sum,#3
	bgt setbit0
setbit1:
	mov x0,newcells
	mov w1,totalbits
	mov w2,counter1
	mov w3,#1
	bl set_bit
	b next
setbit0:
	mov x0,newcells
	mov w1,totalbits
	mov w2,counter1
	mov w3,#0
	bl set_bit
	b next	
setbitnochange:
	mov x0,ocells
	mov w1,totalbits
	mov w2,counter1
	bl get_bit	
	
	mov w3,w0
	mov x0,newcells
	mov w1,totalbits
	mov w2,counter1
	bl set_bit
	b next
next:
	add counter1,counter1,#1
	b loopsetbit
loopsetbitend:
	cmp counter2,size
	bge end
	
	lsl w0,counter2,#2
	ldr w1,[newcells,w0,uxtw]
	str w1,[ocells,w0,uxtw] 
	add counter2,counter2,#1
	b loopsetbitend
	//mov x0,ocells
	//mov x1,newcells
	//mov w2,size
	//lsl w2,w2,#2
	//bl memcpy
	
end:
	mov x0,newcells
	bl free
	
	ldp x27,x28,[sp],#16
	ldp x25,x26,[sp],#16
	ldp x23,x24,[sp],#16
	ldp x21,x22,[sp],#16
	ldp x19,x20,[sp],#16
	ldp x29,x30,[sp],#16
	ret
	.unreq ocells
	.unreq width
	.unreq height
	.unreq size
	.unreq totalbits
	.unreq counter1
	.unreq counter2
	.unreq newcells
	.unreq sum
 	















	ret
	
