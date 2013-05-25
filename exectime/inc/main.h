#ifndef MAIN_H
#define MAIN_H

#include        <sys/time.h>

int main(int argc, char** argv);
int time_sub( struct timeval* tv1, struct timeval* tv2 );
int time_avg( struct timeval* avg, struct timeval* val );

#endif
