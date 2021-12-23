#include "decoder.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
/**
 * Main file
 * Iterates through a file and prints out picture
 */
int main(int argc, char *argv[])
{
//File
  if (argc < 2){
    printf("Usage: decoder file\n");
    return 1;
  }
  FILE *fp = fopen(argv[1], "r");
  if (fp == NULL){
    printf("Unable to open input file\n");
    return 1;
  }
  
//Creation of key, first line of the file

  LinkedList key;
  initialize_list(&key);

  char buffer[1000];
  if(fgets(buffer, sizeof(buffer), fp) != NULL){
    int length = 0;
    for (; buffer[length]; length++){
      append_list(&key,buffer[length]);
    }
  }

//Go through each line in file 
//put through XOR, shift, and print
  int count = 0;
  while(fgets(buffer, sizeof(buffer), fp) != NULL){
    int length = 0;
    LinkedList compare;
    initialize_list(&compare);
    for (; buffer[length]; length++){
      //add \n at the end
      if (buffer[length] == '\n'){
        break;
      }
      append_list(&compare,buffer[length]);
    }

    //XOR
    xor_list(&key, &compare);

    //shift
    LinkedListNode *compare_node;
    int track = count;
    //Go through the list
    //keep use track to ensure that appends the correct
    //amount of times
    for(compare_node = compare.head; compare_node != NULL; compare_node = compare_node->next){
      if (track == 0){
        break;
      }
      char add = compare_node->name;
      append_list(&compare, add);
      track -= 1;
    }
    shift_list(count, &compare);

    append_list(&compare, '\n'); 
    count += 1;
    
    //print
    for(compare_node = compare.head; compare_node != NULL; compare_node = compare_node->next){
        if(compare_node->name == '1'){
        printf("%c", 'x');
      }
      else if(compare_node->name == '0'){
        printf("%c", ' ');
      }
      else{
        printf("\n");
      }
    }

    free_list(&compare);
  }
 
  fclose(fp);

  free_list(&key);
  return 1;

}
