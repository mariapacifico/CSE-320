.text
.global perfect_sqr


/**
 * Determine if a number is a perfect square.
 * x0 - Passed in value: num
 * Returns 1 if num is a perfect square.
*/
perfect_sqr:
    mov x1, #1        //x1 = max = 1
    lsl x1, x1, #32   //x1 <<= 32
    mov x2, #1         //x2 = n_sqr = 1

    //for loop initialization
    mov x3, #1        //x3 = n = 1

    b forloop

forloop:
    //for loop test: n<max
    sub x4, x3, x1
    blt is_not_square       //if n == max
   
    cmp x2, x0 
    beq is_square    //break

    
    subs x4, x0, x2   //x4 = num - sqr
    beq is_not_square   //if num == n_sqr
    
    b after_if
    

after_if:
    add x5, x3, x3    //x5 = n + n = n * 2
    add x5, x5, #1    //x5 += 1
    add x2, x2, x5    //x2 = n_sqr += x5
    
    add x3, x3, #1    // n++
    b forloop

is_square:
    mov x0, #1
    b loopend

is_not_square:
    mov x0, #0
    b loopend

loopend:
    ret

