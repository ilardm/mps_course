#include        <stdio.h>
#include        <stdlib.h>

#include        "main.h"

static const int PROTHN = 10;

int main(int argc, char** argv)
{
    int i = 0;
    int k = 1;
    int j = 0;
    int pn = 0;
    int count = 0;

    if ( argc > 1 ) {
        k = atoi( argv[1] );

        if ( k <= 0 || k % 2 == 0 ) {
            printf( "k must be positive odd integer\n" );
            return 1;
        }
    }

    for ( i = 0, count = 0; count < PROTHN; ++i ) {
        j = 1 << (i+1);

        if ( k < j ) {
            pn = k * j + 1;

            printf( "pn[%d] = %d\n", i+1, pn );
            ++count;
        }
    }

    return 0;
}
