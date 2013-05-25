#include        <stdio.h>
#include        <stdlib.h>
#include        <sys/time.h>
#include        <string.h>

#include        "main.h"

#define COND2CHAR(c)    ((c)?'t':'f')
#define USEC_PER_SEC    (1000000)

int main(int argc, char** argv)
{
    char* cmd = NULL;
    int times = 0;
    int i = 0;
    int es = 0;
    int tes = 0;
    struct timeval start;
    struct timeval stop;
    struct timeval avg;

    if ( argc < 3 ) {
        fprintf( stderr, "specify command and times to execute\n" );
        return 1;
    }

    cmd = argv[1];
    times = atoi( argv[2] );

    if (    cmd == NULL
         || times <= 0
        ) {
        fprintf( stderr, "unable to get command(%c) or invalid times(%c)\n"
                 , COND2CHAR(cmd==NULL)
                 , COND2CHAR(times<=0)
            );
    }

    memset( &avg, 0, sizeof(struct timeval) );
    for ( i = 0; i < times; ++i ) {
        memset( &start, 0, sizeof(struct timeval) );
        memset( &stop, 0, sizeof(struct timeval) );

        tes = gettimeofday( &start, NULL );
        es = system( cmd );
        tes |= gettimeofday( &stop, NULL );

        if ( es != 0 ) {
            fprintf( stderr, "command exit status is not good: %d; "
                     "abort tests\n"
                     , es
                );
            break;
        }
        if ( tes != 0 ) {
            fprintf( stderr, "unable to determine start/stop time; "
                     "abort tests\n"
                );
            break;
        }

        es = time_sub( &stop, &start );
        if ( es != 0 ) {
            fprintf( stderr, "unable to determine time difference: %d; "
                     "abort tests\n"
                     , es
                );
            break;
        }

        if ( i != 0 ) {
            es = time_avg( &avg, &stop );
            if ( es != 0 ) {
                fprintf( stderr, "unable to determine avg time: %d; "
                         "abort tests\n"
                         , es
                    );
                break;
            }
        } else {
            memcpy( &avg, &stop, sizeof(struct timeval) );
        }
    }

    if ( es != 0 || tes != 0 ) {
        return 1;
    }

    printf( "'%s' executed %d times with %ld:%06ld duration\n"
            , cmd
            , times
            , avg.tv_sec
            , avg.tv_usec
        );

    return 0;
}

int time_sub( struct timeval* tv1, struct timeval* tv2 )
{
    suseconds_t usec = 0;
    if ( tv1 == NULL
         || tv2 == NULL
        ) {
        return -1;
    }

    tv1->tv_sec -= tv2->tv_sec;
    usec = tv1->tv_usec - tv2->tv_usec;
    if ( usec < 0 ) {
        tv1->tv_sec -= 1;
        usec += USEC_PER_SEC;
    }
    tv1->tv_usec = usec;

    return 0;
}

int time_avg( struct timeval* avg, struct timeval* val )
{
    suseconds_t usec = 0;

    if (    avg == NULL
         || val == NULL
        ) {
        return -1;
    }

    usec = avg->tv_sec * USEC_PER_SEC + avg->tv_usec;
    usec += ( val->tv_sec * USEC_PER_SEC + val->tv_usec );

    usec /= 2;

    avg->tv_usec = ( usec % USEC_PER_SEC );
    avg->tv_sec = ( (usec - avg->tv_usec) / USEC_PER_SEC );

    return 0;
}
