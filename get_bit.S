.text
.global get_bit


//
// Get a bit from an array of words.
// x0 - Array of integers
// w1 - Width of the array in bits
// w2 - Desired bit
//
get_bit:
  stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
      
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
  sub w4, w5, w4      // shift = 31 -bit (w4)
      
  lsr w7, w7, w4      // Shift bit to lowest bit (lsr word, word, shift)

  and w0, w7, #1      // And with 1 and return value 
  b get_bit_done

ret_zero:
  mov x0, #0

get_bit_done:
  ldp x29, x30, [sp], #16
	ret     
