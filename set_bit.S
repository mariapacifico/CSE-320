.text
.global set_bit


//
// Get a bit from an array of words.
// x0 - Array of integers
// w1 - Width of the array in bits
// w2 - Desired bit
// w3 - 1 if bit is to be set
//
set_bit:
  stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
  stp x19, x20, [sp, #-16]! 
  stp x21, x22, [sp, #-16]!

  mov w19, w3 //w19 = set bit

  cmp w2, #0 // 0 <= desired
  blt ret_zero

  cmp w2, w1 // desired < width
  bge ret_zero

  //Getting the desired word and bit
  lsr w3, w2, #5   // Determine the word (w3)
  and w4, w2, #0x1f  // Bit index (w4)

  //data + word * 4 
  lsl w6, w3, #2       // word * 4 (w6)
  ldr w7, [x0, w6, uxtw] // data[i]

  //get shift 
  mov w5, #31
  sub w4, w5, w4      // shift = 31 - bit (w4)

  mov w20, w4 // shift = w20
  mov w21, w7 // word = w21
  mov w22, w6 

  cmp w19, #0
  beq set_zero

  b set_one

set_zero:
  mov w1, #1
  lsl w1, w1, w20
  bic w21, w21, w1
  str w21, [x0, w22, uxtw]
  b set_bit_done

set_one:
  mov w1, #1
  lsl w1, w1, w20
  orr w21, w21, w1
  str w21, [x0, w22, uxtw]
  b set_bit_done

ret_zero:
  mov x0, #0

set_bit_done:
  ldp x21, x22, [sp], #16
  ldp x19, x20, [sp], #16
  ldp x29, x30, [sp], #16   
  ret     
