#include        <stdio.h>

#include        "main.h"

static const int BELLN = 10;

int main(int argc, char** argv)
{
    int i = 0;
    int m = 0;
    int bn = 0;

    for ( i = 0; i < BELLN; ++i ) {
        bn = 0;

        for ( m = 0; m <= i; ++m )
            bn += stirling( i, m );

        printf( "bn[%d] = %d\n", i+1, bn );
    }

    return 0;
}

int stirling(int n, int k)
{
    if ( n == k && n >= 0 )
        return 1;

    if (   (n > 0 && k == 0)
        || (k == 0 && k > 0)
        )
        return 0;

    if ( k > 0 && k < n )
        return ( stirling(n-1,k-1) + k*stirling(n-1,k) );

    printf( "undefined behaviour for n(%d), k(%d)\n", n, k );
    return -1;
}
