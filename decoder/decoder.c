#include "decoder.h"

/**
 * Initialize a linked list to empty
 * @param list Pointer to the linked list struct
 **/
void initialize_list(LinkedList *list)
{
  list->head = NULL;
  list->tail = NULL;
}
/**
 * Append to a linked list
 * @param list Pointer to the linked list struct
 * @param name char needed to be added to list
 **/
void append_list(LinkedList *list, char name){
  //list **MUST FREE**
  LinkedListNode *node = (LinkedListNode *)calloc(1, sizeof(LinkedListNode));
  node->next = NULL;

  node->name = name;
  //if the list is empty
  if (list->tail == NULL){
    list->head = node;
    list->tail = node;
  }
  else{
    list->tail->next = node;
    list->tail = node;
  }
}
/**
 * Free a list to ensure no leakage
 * @param list Pointer to the linked list struct
 **/
void free_list(LinkedList *list){
  LinkedListNode *node;

  for (node = list -> head; node != NULL; ){
    LinkedListNode *next = node->next;
    free(node);
    node = next;
  }

  list->head = NULL;
  list->tail = NULL;
}
/**
 *Takes two linked list structs and use XOR to edit a list
 @param key Pointer to the linked list struct, not changed
 @param list Pointer to the linked list struct, changed
 **/
void xor_list(LinkedList *key, LinkedList *list){
  LinkedListNode *key_node;
  LinkedListNode *list_node;
  
  key_node = key->head;
  list_node = list->head;

  while(key_node != NULL && list_node != NULL){

    if(key_node->name == '1' && list_node->name == '1'){
      list_node->name = '0';
    }
    else if(key_node->name == '1' && list_node->name == '0'){
      list_node->name = '1';
    }

    key_node = key_node->next;
    list_node = list_node->next;
  }
}

/**
 * Changes the lists head dependent on the count
 * @param count Int that determines how many times list is shifted
 * @param list Pointer to the linked list struct, edited  
 **/
void shift_list(int count, LinkedList *list){
  LinkedListNode *compare_node;

  compare_node = list->head;
  while(count != 0){
    compare_node = compare_node->next; 
    list->head = compare_node;
    count -= 1;
  }
}
