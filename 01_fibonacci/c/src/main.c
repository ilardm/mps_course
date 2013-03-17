#include        <stdio.h>

#include        "main.h"

static const int FIBN = 10;

int main(int argc, char** argv)
{
    int f[2] = {0, 1};
    int fn = 0;

    int i = 0;
    for ( i = 0; i < FIBN; ++i ) {
        if ( i < 2 ) {
            fn = f[i];
        } else {
            fn = f[0] + f[1];

            f[0] = f[1];
            f[1] = fn;
        }

        printf( "fn[%d] = %d\n", i+1, fn );
    }

    return 0;
}
