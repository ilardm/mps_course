.thumb
.data
        .set    bypv,4
        .set    belln,10

bell:   .size   belln,bypv*belln
        .fill   belln,bypv,0

.text
        bal     main

        /**********************************************************************
        * args:
        * r0    n
        * r1    k
        *
        * returns:
        * r0    value
        */
stirling:
        push    {r4-r7,lr}

        mov     r4,r0
        mov     r5,r1

        cmp     r4,r5
        bne     stirl_zero_c1
        cmp     r4,#0
        blt     stirl_zero_c1
        mov     r0,#1
        b       stirl_done

stirl_zero_c1:
        cmp     r4,#0
        ble     stirl_zero_c2
        cmp     r5,#0
        beq     stirl_zero

stirl_zero_c2:
        cmp     r5,#0
        bne     stirl_recur
        cmp     r4,#0
        bgt     stirl_zero

stirl_recur:
        cmp     r5,#0
        ble     stirl_done                      @ undef.behav. actually
        cmp     r5,r4
        bge     stirl_done                      @ undef.behav. actually

        mov     r0,r4
        sub     r0,#1
        mov     r1,r5
        sub     r1,#1
        bl      stirling
        mov     r6,r0

        mov     r0,r4
        sub     r0,#1
        mov     r1,r5
        bl      stirling
        mov     r7,r0

        mov     r0,r5
        mul     r0,r7
        add     r0,r6
        b       stirl_done

stirl_zero:
        mov     r0,#0

stirl_done:

        pop     {r4-r7,pc}

        /**********************************************************************
        *
        */
.global main
.thumb_func
main:
        push    {r4-r7,lr}

        ldr     r4,=bell
        mov     r5,#0                   @ i

loop:
        mov     r6,#0                   @ bn
        mov     r7,#0                   @ m

loop_inner:
        mov     r0,r5
        mov     r1,r7
        bl      stirling
        add     r6,r6,r0

        add     r7,r7,#1
        cmp     r7,r5
        ble     loop_inner

        str     r6,[r4,#0]
        add     r4,#bypv
        add     r5,r5,#1
        cmp     r5,#belln
        blt     loop

done:
        ldr     r4,=bell

        mov     r0,#0
        pop     {r4-r7,pc}

.end
