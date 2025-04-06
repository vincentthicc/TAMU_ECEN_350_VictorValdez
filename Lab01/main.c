/* main.c simple program to test your assembly program */

#include <stdio.h>

extern long long int test ( long long int b);

int main ( void ){

long long int a = test(4) ;  //Y = 4

printf("Result is = %d\n", a);

return 0;

}
