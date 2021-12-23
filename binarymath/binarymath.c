#include <stdlib.h>
#include <string.h>
#include "binarymath.h"

char *copy_string(const char *str)
{
  size_t required = strlen(str) + 1;
  char *result = (char *)malloc(required);

  strncpy(result, str, required);
  result[required-1] = '\0';

  return result;
}

/**
 * Increment a BINARY_SIZE binary number expressed as a 
 * character string.
 * @param number The number we are passed
 * @returns Incremented version of the number
 */
char *inc(const char *number)
{
  char *add_number = copy_string(number);
//  free(number);
  if(add_number[BINARY_SIZE - 1] =='0'){
    add_number[BINARY_SIZE -1] += 1;
  }
  else{
    int i;
    for( i = 0; BINARY_SIZE > i; i++){
      if((BINARY_SIZE - i - 1) == 0){
        add_number[0] = '1';
        break;
      }

      if(add_number[BINARY_SIZE - 1 - i] == '1'){
        add_number[BINARY_SIZE - 1 - i] = '0';
      }
      else{
        add_number[BINARY_SIZE - 1 - i ]= '1';
        break;
      }
    }
  }
  
  return add_number;
}


/**
 * Negate a BINARY_SIZE binary number expressed as a character string
 * @param number The number we are passed
 * @returns Incremented version of the number
 */

char *negate(const char *number)
{
  char *reverse = copy_string(number);
  int i;
  for(i= 0; BINARY_SIZE > i; i++){
    if(reverse[i] == '0'){
      reverse[i] = '1';
    }
    else{
      reverse[i] = '0';
    }
  }

  char * negate_number = inc(reverse);
  free(reverse); 
  return negate_number;
}

/**
 * Add two BINARY_SIZE binary numbers expressed as
 * a character string. 
 * @param a First number to add
 * @param b Second number to add
 * @return a + b
 */

char *add(const char *a, const char *b)
{
    //result **MUST BE FREED**
    char *result = (char *)malloc(BINARY_SIZE + 1);

    int carry = 0;
    int i;

    for(i = 0; BINARY_SIZE > i; i++){
      int index = BINARY_SIZE - 1 - i;
      
      if(a[index] == '0' && carry == 0){
        result[index] = b[index];
      }

      if(a[index] == '0' && carry == 1){
        if(b[index]=='0'){
          result[index] = '1';
          carry = 0;
        }
        else{
          result[index] = '0';
        }
      }

      if(a[index] == '1' && carry == 1){
        if(b[index] == '1'){
          result[index] = '1';
        }
        else{
          result[index] = '0';
        }
      }
     if(a[index] == '1' && carry == 0){
        if (b[index] == '0'){
          result[index] = '1';
        }
        else{
          result[index]='0';
          carry = 1;
        }
      }
    }

    return result;
}

/**
 * Subtract two BINARY_SIZE binary numbers expressed as
 * a character string.
 * @param a First number
 * @param b Second number 
 * @return a - b
 */

char *sub(const char *a, const char *b)
{
    char *reverse = copy_string(b);
    int i; 
    for(i= 0; BINARY_SIZE > i; i++){
      if(reverse[i] == '0'){
        reverse[i] = '1';
      }
      else{
        reverse[i] = '0';
      }
    }
    char *increment_reverse = inc(reverse);
    free(reverse);

    char *result = add(a, increment_reverse);
    free(increment_reverse);

    return result;
}
