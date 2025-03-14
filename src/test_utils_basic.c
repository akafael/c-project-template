/**
 * Sample test without test framework
 */

#include <stdlib.h>
#include <stdio.h>

#include "utils.h"

int main()
{
    printf("\nStarting Tests!\n");
    int testFailCount = 0;

    // Test Preparation
    const int answer = deepThought("How much is 40 + 2?");
    const int expected_answer = 42;

    // Basic test case
    if(answer == expected_answer){
        printf("(1) Test passed!\n");
    }
    else
    {
        printf("(1) Test fail!\n");
        testFailCount += 1;
    }

    return(testFailCount);
}