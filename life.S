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
  stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
  stp x19, x20, [sp, #-16]! 
  stp x21, x22, [sp, #-16]!
  stp x23, x24, [sp, #-16]!
  stp x25, x26, [sp, #-16]!

  //Store x0
  mov x19, x0
  mov w20, w1 //width
  mov w21, w2 //height
  
  //Make new array
  //size: width * height
  mul w0, w20, w21
  mov w1, #4
  bl calloc
  
  //save array
  mov x22, x0
  
  //width * height * 32
  mul w24, w20, w21 // size of array
  lsl w23, w24, #5

  //copy initialization 
  mov x25, #0 //count with size
  mov x26, #0 //ldr and str placement

  //for loop initialization (i = 0) 
  mov w4, #0 // i

// i = 0; i < width x height x 32; i++
forloop:
  mov w5, #0 //count
  //i<width*width*32
  cmp w4, w23
  bge copy_array

  //get_bit:
  //x0: array of integers (x19)
  //w1: width of the array in bits 
  //w2: desired bit

  //left
  //w2 = i -1
  sub w2, w4, #1
  mov w1, w23
  mov x0, x19
  bl get_bit
  add w5, w5, w0

  //right
  // w2 = i + 1
  add w2, w4, #1
  mov w1, w23
  mov x0, x19
  bl get_bit
  add w5, w5, w0

  //above
  // w2 = i - width * 32
  lsl w2, w20, #5 // w2 = width * 32
  sub w2, w4, w2  // i - w2
  mov w1, w23
  mov x0, x19
  bl get_bit
  add w5, w5, w0

  //upper left
  //w2 = i - width * 32 - 1
  lsl w2, w20, #5 // width * 32
  sub w2, w4, w2 //  i - w2
  sub w2, w2, #1 // w2 - 1
  mov w1, w23
  mov x0, x19
  bl get_bit
  add w5, w5, w0

  //upper right
  //w2 = i - width * 32 + 1
  lsl w2, w20, #5 // width * 32
  sub w2, w4, w2 // i - w2
  add w2, w2, #1 // + 1
  mov w1, w23
  mov x0, x19
  bl get_bit
  add w5, w5, w0

  //lower left
  // w2 = i + width * 32 - 1
  lsl w2, w20, #5 // width * 32
  add w2, w2, w4 // w2 + i
  sub w2, w2, #1 // w2 - 1
  mov w1, w23
  mov x0, x19
  bl get_bit
  add w5, w5, w0 

  //below
  // w2 = i + width * 32
  lsl w2, w20, #5 // width * 32
  add w2, w4, w2 // + i
  mov w1, w23
  mov x0, x19
  bl get_bit
  add w5, w5, w0

  //lower right
  // w2 = i + width * 32 + 1
  lsl w2, w20, #5 // width * 32
  add w2, w4, w2 // w2 + i
  add w2, w2, #1 // + 1
  mov w1, w23
  mov x0, x19
  bl get_bit
  add w5, w5, w0
  
  //w5 < 2, set cell to 0
  //if w5 = 2, cell stays the same
  //w5 = 3, cell = 1
  //w5 > 3, cell = 0
  cmp w5, #3 // w5 = #3, then set to one
  beq set_to_one

  cmp w5, #2 // w5 = 2, stay the same
  beq stay_same

  b set_to_zero // w5 > 3 or w5 < 2, set to zero

set_to_one:
//set_bit(x22, w23, w4, #1)
  mov x0, x22
  mov w1, w23
  mov w2, w4
  mov w3, #1
  blt set_bit
  b inc_i

set_to_zero:
//set_bit(x22, w23, w4, #0)
  mov x0, x22
  mov w1, w23
  mov w2, w4
  mov w3, #0
  blt set_bit
  b inc_i

stay_same:
 // get_bit from original
 // get_bit(x19, x23, w4)
  mov x0, x19
  mov w1, w23
  mov w2, w4
  bl get_bit

  //set_bit
  //set_bit(x22, w23, w4, bl get_bit)
  mov w3, w0
  mov x0, x22
  mov w1, w23
  mov w2, w4
  bl set_bit
  b inc_i
  
inc_i:
  add w4, w4, #1 //i++
  b forloop

copy_array:
  //counter < size
  cmp w25, w24
  bge life_done
  
  //Get address from x22
  ldr x7, [x22, x26] 
  //put into x19
  str x7, [x19, x26]

  add w25, w25, #1 //i++
  add x26, x26, #4 // + 4
  b copy_array
  
life_done:
  // free
  mov x0, x22
  bl free 

  //move copied into x0
  mov x0, x19 

  ldp x25, x26, [sp], #16
  ldp x23, x24, [sp], #16
  ldp x21, x22, [sp], #16
  ldp x19, x20, [sp], #16
  ldp x29, x30, [sp], #16

	ret

	
