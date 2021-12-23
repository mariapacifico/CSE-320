#pragma once
#include <stdlib.h>
#include<stdio.h>
#include<string.h>
/**
* Actual nodes in our stack
*/
typedef struct LinkedListNode{
  char name;
  struct LinkedListNode *next;
} LinkedListNode;

/**
* A structure that represents our stack
*/
typedef struct{
  LinkedListNode *head;
  LinkedListNode *tail;
} LinkedList;

// Forward references for functions
void initialize_list(LinkedList *list);
void append_list(LinkedList *list, char name);
void free_list(LinkedList *list);
void xor_list(LinkedList *key, LinkedList *list);
void shift_list(int count, LinkedList *list);
