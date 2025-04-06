/* main.c simple program to test assembler program */

#include <stdio.h>

extern long long int my_mul(long long int a, long long int b);
extern long long int n_fact(long long int x);

int main(void)
{
   long long int a = my_mul(3, 5);
   printf("Result of my_mul(3, 5) = %lld\n", a);

    a = n_fact(6);
    printf("%lld\n", a);

    return 0;

}
