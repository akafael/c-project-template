#include "utest/utest.h"
#include "utils.h"

UTEST(deepThought, arithmeticQuestionSum)
{
    const int answer = deepThought("How much is 40 + 2?");
    const int expected_answer = 42;

    ASSERT_EQ(answer,expected_answer);
}

UTEST(deepThought, arithmeticQuestionProduct)
{
    const int answer = deepThought("How much is 7 time 6?");
    const int expected_answer = 42;

    ASSERT_EQ(answer,expected_answer);
}

UTEST(isEven, trivialTestEven)
{
    const int answer = isEven(2);
    const int expected_answer = 0;

    ASSERT_EQ(answer,expected_answer);
}

UTEST(isEven, trivialTestOdd)
{
    const int answer = isEven(3);
    const int expected_answer = 1;

    ASSERT_EQ(answer,expected_answer);
}

UTEST_MAIN()