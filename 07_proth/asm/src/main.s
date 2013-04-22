.data
        .set    bypv,4
        .set    prothn,10
        .set    k,1                     @ must be positive odd integer

proth:  .size   proth,bypv*prothn
        .fill   prothn,bypv,0
        
.text
        bal     main

.global main
main:
        stmfd   sp!,{r4-r11,lr}

        ldr     r4,=proth
        mov     r5,#0                   @ i
        mov     r6,#0                   @ count
        mov     r7,#0                   @ j
        mov     r10,#k

loop:
        add     r8,r5,#1
        mov     r7,#1
        mov     r7,r7,lsl r8

        cmp     r10,r7                  
        mullt   r9,r10,r7               @ pn
        addlt   r9,r9,#1
        strlt   r9,[r4],#4
        addlt   r6,r6,#1

        add     r5,r5,#1

        cmp     r6,#prothn
        blt     loop

done:
        ldr     r4,=proth

        mov     r0,#0
        ldmfd   sp!,{r4-r11,pc}
.end
