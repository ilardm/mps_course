#include        <stdio.h>

#include        "main.h"

static const int MARSN = 10;

int main(int argc, char** argv)
{
    int i = 0;
    int mn = 0;

    for ( i = 0; i < MARSN; ++i ) {
        mn = (1 << (i+1)) - 1;

        printf( "mn[%d] = %d\n", i+1, mn );
    }

    return 0;
}
