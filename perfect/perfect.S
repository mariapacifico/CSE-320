//
//Data section
//

.data

allperfect: .asciz  "\nAll perfect numbers from 1 to 1000: \n\n"

equal: .asciz "Perfect: %d\n"

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
  fp .req x29
  lr .req x30

  .equ num, 16 
  .equ div, 24
  .equ sum, 32
  .equ size, 48 //must be divisble by 16

  //Store fp and lr and makes space on the stack
  stp fp, lr, [sp, #-size]!
  mov fp, sp
  
  //print statement
  ldr x0,=allperfect
  bl printf
  
  //for loop initialization
  mov x0, #1
  str x0, [fp, #num]

//for(number=1; number<=10000; number++)
num_for:
  //Check num <= 1000
  ldr x0, [fp, #num]
  cmp x0, #1000
  bgt main_done //finish

  //set sum = 0
  mov x0, #0
  str x0, [fp, #sum]

  //for loop initialization
  //set divisor = 1
  mov x0, #1
  str x0, [fp, #div]

//for(number=1; number<=10000; number++)  
div_for:
  //Check divisor < number
  ldr x0, [fp, #num] //num
  ldr x1, [fp, #div] //dive
  cmp x1, x0
  bge check_sum //check num and sum, don't finish
 
  //num % divisor
  //ldiv; x1 = remainder
  ldr x0, [fp, #num] //num
  ldr x1, [fp, #div] //div
  bl ldiv //x1 = remainder
  
  //if remainder == 0
  cmp x1, #0
  beq addsum //then sum += div

  b div_for_repeat 

addsum:
  //sum += div
  ldr x0, [fp, #div] //div
  ldr x1, [fp, #sum] //sum
  add x1, x1, x0    // sum = sum + div
  str x1, [fp, #sum]

  b div_for_repeat

div_for_repeat:
  //div++
  ldr x0, [fp, #div]
  add x0, x0, #1
  str x0, [fp, #div]
  //repeat for loop
  b div_for

check_sum:
  //if num == sum, printf
  ldr x0, [fp, #num] //num
  ldr x1, [fp, #sum] //sum

  cmp x0, x1
  beq print_num

  b num_for_repeat

print_num:
  //printf(num)
  ldr x1, [fp, #num]
  ldr x0,=equal
  bl printf

  b num_for_repeat //repeat num for loop

num_for_repeat:
  //num++
  ldr x0, [fp, #num]
  add x0, x0, #1
  str x0, [fp, #num]
  b num_for //loop

main_done:
  ldp x29, x30, [sp], #size
  ret
