/**
 * A very simple program for demonstration
 */

#include <stdlib.h>
#include <stdio.h>

#include "utils.h"

int main()
{
  const char question[] = "What is the Answer to the Ultimate Question of Life, the Universe and Everything?";

  int answer = deepThought(question);

  printf("%s\n",question);
  printf("> The Answer is %d!\n",answer);

  return(0);
}
