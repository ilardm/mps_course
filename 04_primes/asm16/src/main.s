.thumb
.data
        .set    bipv,31
        .set    bypv,4
        .set    primn,10
        .set    fprime,2
        .set    sievesz,3
        .set    nlimit,bipv*sievesz
        .set    prime,0
        .set    composite,1

prim:   .size   prim,primn*bypv
        .fill   primn,bypv,0
sieve:  .size   sieve,sievesz*bypv
        .fill   sievesz,bypv,0

.text
        bal     main

        /**********************************************************************
        * args:
        * r0    bit number
        *
        * return:
        * r0    bit number
        * r1    byte number
        */
get_sieve_bb:
        push    {r4-r7,lr}

        mov     r4,#0
gsbb_01:
        cmp     r0,#bipv
        subgt   r0,#bipv
        addgt   r4,#1
        bgt     gsbb_01

        mov     r1,r4,lsl #2

        pop     {r4-r7,pc}

        /**********************************************************************
        * args:
        * r0    start address
        * r1    bit number
        *
        * return:
        * r0    bit value
        */
get_sieve_v:
        push    {r4-r7,lr}

        @ save args
        mov     r4,r0
        mov     r5,r1

        @ evaluate bit && byte numbers
        mov     r0,r1
        bl      get_sieve_bb

        @ evlauate bit value
        ldr     r6,[r4,r1]
        mov     r6,r6,lsr r0
        and     r0,r6,#0x01

        pop     {r4-r7,pc}

        /**********************************************************************
        * args:
        * r0    start address
        * r1    bit number
        * r2    bit value
        */
set_sieve_v:
        push    {r4-r7,lr}

        @ store args
        mov     r4,r0
        mov     r5,r1
        mov     r6,r2

        @ evaluate bit && byte numbers
        mov     r0,r1
        bl      get_sieve_bb

        @ construct mask
        mov     r7,#1
        mov     r7,r7, lsl r0

        @ apply mask
        ldr     r8,[r4,r1]
        orr     r8,r8,r7
        str     r8,[r4,r1]

        pop     {r4-r7,pc}

        /**********************************************************************
        *
        */
.global main
.thumb_func
main:
        push    {r4-r7,lr}

        @ fill the sieve
        mov     r4,#fprime

outer_loop:
        ldr     r0,=sieve
        mov     r1,r4
        bl      get_sieve_v

        cmp     r0,#prime
        bne     not_prime

        mul     r5,r4,r4

inner_loop:
        ldr     r0,=sieve
        mov     r1,r5
        mov     r2,#composite
        bl      set_sieve_v

        cmp     r5,#nlimit
        addlt   r5,r5,r4
        blt     inner_loop

not_prime:
        cmp     r4,#nlimit
        addlt   r4,#1
        blt     outer_loop

        @ fill primes array
        mov     r4,#fprime              @ i
        mov     r5,#0                   @ count
        ldr     r6,=prim

next_try:
        ldr     r0,=sieve
        mov     r1,r4
        bl      get_sieve_v

        cmp     r0,#prime

        streq   r4,[r6],#bypv
        addeq   r5,r5,#1

        cmp     r5,#primn
        bge     done_try

        add     r4,r4,#1
        cmp     r4,#nlimit
        blt     next_try

done_try:
        ldr     r6,=prim

        mov     r0,#0
        pop     {r4-r7,pc}

.end
