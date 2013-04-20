.data
        .set    bypv,4
        .set    fermn,5

ferm:   .size   ferm,bypv*fermn
        .fill   fermn,bypv,0

.text
        bal     main

.global main
main:
        stmfd   sp!,{r4-r11,lr}

        ldr     r4,=ferm
        mov     r5,#0                   @ i
        mov     r7,#1                   @ aux register

loop:
        mov     r6,r7,lsl r5
        mov     r6,r7,lsl r6
        add     r6,r6,#1
        str     r6,[r4],#bypv

        add     r5,r5,#1
        cmp     r5,#fermn
        blt     loop

done:
        ldr     r4,=ferm

        mov     r0,#0
        ldmfd   sp!,{r4-r11,pc}
.end
