#include "decoder.h"
#include <string.h>
/**
 * Adding a 1 into a character stream at a specified bit
 * @param decoded The character stream editing
 * @param maxLen The maximum size for decoded
 * @param bit The bit number that will be edited in decoded
 */
void setBit(char *decoded, int maxLen, int bit){
  int byte = bit / 8;
  if (byte < maxLen){
    int bitIndex = 7 - (bit % 8); 
    decoded[byte] |= 1 << bitIndex;
  }
}

/**
 * Decode an encoded string into a character stream.
 * @param encoded The input string we are decoding
 * @param decoded The output string we produce
 * @param maxLen The maximum size for decoded
 */
void decoder(const char *encoded, char *decoded, int maxLen)
{
  for (int i=0; i < maxLen; i++){
    decoded[i] = 0;
  }
  int bit = 0;

  for( ; *encoded; encoded++){
    switch(*encoded){
      case 'L':
        bit++;
        bit++;
        bit++;
        break;
      case '7':
        bit++;
        bit++;
        setBit(decoded, maxLen, bit++);
        break;
      case 'D':
        bit++;
        setBit(decoded, maxLen, bit++);
        bit++;
        break;
      case 'W':
        bit++;
        setBit(decoded, maxLen, bit++);
        setBit(decoded, maxLen, bit++);
        break;
      case 'm':
        setBit(decoded, maxLen, bit++);
        bit++;
        bit++;
        break;
      case '^':
        setBit(decoded, maxLen, bit++);
        bit++;
        setBit(decoded, maxLen, bit++);
        break;
      case 'O':
        setBit(decoded, maxLen, bit++);
        setBit(decoded, maxLen, bit++);
        bit++;
        break;
      case 't':
        setBit(decoded, maxLen, bit++);
        setBit(decoded, maxLen, bit++);
        setBit(decoded, maxLen, bit++);
        break;
      case 'J':
        bit++;
        bit++;
        break;
      case '%':
        bit++;
        setBit(decoded, maxLen, bit++);
        break;
      case '@':
        setBit(decoded, maxLen, bit++);
        bit++;
        break;
      case '=':
        setBit(decoded, maxLen, bit++);
        setBit(decoded, maxLen, bit++);
        break;
    }
  }
}
           
