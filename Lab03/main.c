/* main.c simple program to test assembler program */

#include <stdio.h>

extern long long int test(long long int a, long long int b);
extern long long int q3();
extern long long int q4(long long int j);

int main(void)
{
    long long int a = test(3, 5);
    printf("Result of test(3, 5) = %lld\n", a);
    long long int b = q3();
    printf("Result of Question 3 = %lld\n", b);
    long long int *my_array = q4(3);
    printf("Result of Question 4: [");
    for (int i = 0; i < 10; i++)
    {
	printf("%lld,", my_array[i]);
	if (i != 9){
	    printf(" ");}
    }
    printf("]");
    return 0;
}
