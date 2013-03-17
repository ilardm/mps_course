#include        <stdio.h>

#include        "main.h"

static const int FERMATN = 5;

int main(int argc, char** argv)
{
    int i = 0;
    int fn = 0;

    for ( i = 0; i < FERMATN; ++i ) {
        fn = ( 1 << (1 << i) ) + 1;

        printf( "fn[%d] = %d\n", i+1, fn );
    }

    return 0;
}
