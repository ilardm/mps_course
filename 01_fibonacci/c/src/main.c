#include        <stdio.h>

#include        "main.h"

#define FIBN    (10)

int main(int argc, char** argv)
{
    int f[FIBN] = {0};
    int i = 0;

    f[1] = 1;
    for ( i = 2; i < FIBN; ++i ) {
        f[i] = f[i-1] + f[i-2];
    }

    return 0;
}
