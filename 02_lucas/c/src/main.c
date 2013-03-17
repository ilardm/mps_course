#include        <stdio.h>

#include        "main.h"

static const int LUCASN = 10;

int main(int argc, char** argv)
{
    int l[2] = {2, 1};
    int ln = 0;

    int i = 0;
    for ( i = 0; i < LUCASN; ++i ) {
        if ( i < 2 ) {
            ln = l[i];
        } else {
            ln = l[1] + l[0];

            l[0] = l[1];
            l[1] = ln;
        }

        printf( "ln[%d] = %d\n", i+1, ln );
    }

    return 0;
}
