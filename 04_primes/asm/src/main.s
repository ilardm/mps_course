.data
        .set    bipv,32
        .set    bypv,4
        .set    primn,10
        .set    fprime,2
        .set    sievesz,3
        .set    nlimit,bipv*sievesz
        .set    prime,0
        .set    composite,1

prim:   .size   prim,primn*bypv
sieve:  .size   sieve,sievesz*bypv

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
        stmfd   sp!,{r4-r11,lr}

        mov     r1,#0
gsbb_01:        
        cmp     r0,#bipv
        subgt   r0,#bipv
        addgt   r1,#1
        bgt     gsbb_01

        ldmfd   sp!,{r4-r11,pc}
        
        /**********************************************************************
        * args:
        * r0    start address
        * r1    bit number
        *
        * return:
        * r0    bit value
        */
get_sieve_v:
        stmfd   sp!,{r4-r11,lr}

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

        ldmfd   sp!,{r4-r11,pc}

        /**********************************************************************
        * args:
        * r0    start address
        * r1    bit number
        * r2    bit value
        */
set_sieve_v:
        stmfd   sp!,{r4-r11,lr}

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

        ldmfd   sp!,{r4-r11,pc}

        /**********************************************************************
        *
        */
.global main
main:
        stmfd   sp!,{r4-r11,lr}

        @ do smth

        mov     r0,#0
        ldmfd   sp!,{r4-r11,pc}

.end
