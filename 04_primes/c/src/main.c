#include        <stdio.h>

#include        "main.h"

#define NLIMIT 1000
static const int PRIMESN = 10;
static const int FIRST_PRIME = 2;

typedef enum  PCNUMBERS_ENUM { PRIME, COMPOSITE } PCNUMBERS;

int main(int argc, char** argv)
{
    /* Sieve of Eratosthenes */
    PCNUMBERS sieve[ NLIMIT+1 ] = { PRIME };

    int i = 0;                  /* primes iterator */
    int c = 0;                  /* composites iterator */
    int count = 0;              /* primes count */

    for ( i = FIRST_PRIME; i < NLIMIT; ++i )
        if ( sieve[i] == PRIME )
            for ( c = i*i; c < NLIMIT; c += i )
                sieve[c] = COMPOSITE;

    for ( i = FIRST_PRIME, count = 0; i < NLIMIT && count < PRIMESN ; ++i )
        if ( sieve[i] == PRIME ) {
            printf( ( count < PRIMESN-1 ? "%d, " : "%d\n" ), i );
            ++count;
        }

    return 0;
}
