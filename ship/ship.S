.data
zero: .double 0
four: .double 4
neg_one: .double -1
two: .double 2

.text

.global ship

//d0 = xn0
//d1 = yn0
ship:
  stp x29, x30, [sp, #-16]!

  ldr x2,=zero
  ldr d2,[x2] //x=0

  ldr x3,=zero
  ldr d3,[x3] //y=0

  mov w4, #0 //iteration = 0
  
first_con:
  //(x*x+y*y) < 4
  fmul d5, d2, d2 //d5 = x^2
  fmul d6, d3, d3 //d6 = y^2
  fadd d5, d5, d6 //d5 = x^2 + y^2
  
  ldr x6,=four
  ldr d6,[x6] // d6= 4
  
  fcmp d5, d6 // (x^2 + y^2) < 4
  blt second_con //if true, then check second conditional

  b ship_done //else, finish

second_con:
  //iteration < 255
  cmp w4, #255
  blt x_if //if true, run loop

  b ship_done //else, finish

x_if:
  //x = x >= 0 ? x : -x;
  ldr x5,=zero  
  ldr d5,[x5] //d5 = 0

  fcmp d2, d5 //x < 0
  bge y_if //if false, go to y_if

  //if true: x =-x
  ldr x5,=neg_one
  ldr d5,[x5] //d5 = -1
  fmul d2, d2, d5 //x = x * -1

y_if:
  //y = y >= 0 ? y : -y;
  ldr x5,=zero
  ldr d5,[x5] //d5 = 0

  fcmp d3, d5 //y<0
  bge loop_end //if false, finish loop

  //if true: y=-y
  ldr x5,=neg_one
  ldr d5,[x5] //d5 = -1
  fmul d3, d3, d5 //y = y * -1


loop_end:
  //xn1 = x*x - y*y + xn0;
  fmul d5, d2, d2 //d5 = x^2
  fmul d6, d3, d3 //d6 = y^2
  fsub d5, d5, d6 //d5 = x^2 - y^2
  fadd d5, d5, d0 //d5 = x^2 - y^2 + xn0

  //yn1 = 2*x*y + ny0;
  ldr x6,=two
  ldr d6,[x6] //d6 = 2

  fmul d6, d6, d2 //d6 = 2*x
  fmul d6, d6, d3 //d6 = 2*x*y
  fadd d6, d6, d1 //d6 = 2*x*y+ny0

  //x=xn1
  fmov d2,d5

  //y=yn1
  fmov d3,d6

  //iteration++
  add w4, w4, #1
  b first_con

ship_done:
  mov w0, w4
  ldp x29, x30, [sp], #16
  ret
