/**
 * A very simple program for demonstration
 */

#include <stdlib.h>
#include <stdio.h>
#include "main.h"

int main()
{
  int answer = theAnswerForEverything();
  printf("The Answer for Everything is %d\n",answer);

  return(0);
}

int theAnswerForEverything()
{
  return(42);
}
