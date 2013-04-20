.data
        .set    bypv,4
        .set    marsn,10
        
mars:   .size   mars,bypv*marsn
        .fill   marsn,bypv,0

.text
        bal     main

.global main
main:
        stmfd   sp!,{r4-r11,lr}

        ldr     r4,=mars
        mov     r5,#0                   @ i
        mov     r7,#1                   @ aux register

loop:   
        add     r6,r5,#1
        mov     r6,r7,lsl r6
        sub     r6,r6,#1
        str     r6,[r4],#bypv
        
        add     r5,r5,#1
        cmp     r5,#marsn
        blt     loop

done:
        ldr     r4,=mars

        mov     r0,#0
        ldmfd   sp!,{r4-r11,pc}
.end
