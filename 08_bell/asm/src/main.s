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
        stmfd   sp!,{r4-r11,lr}

        mov     r4,r0
        mov     r5,r1

        @ FIXME: bne
        cmp     r4,r5
        bne     stirl_zero_c1
        cmp     r4,#0
        movge   r0,#1
        bge     stirl_done

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

        mul     r0,r5,r7
        add     r0,r6
        b       stirl_done

stirl_zero:
        mov     r0,#0

stirl_done:     

        ldmfd   sp!,{r4-r11,pc}

.global main
main:
        stmfd   sp!,{r4-r11,lr}

        @ actual code here

        mov     r0,#0
        ldmfd   sp!,{r4-r11,pc}
.end
