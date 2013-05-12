.thumb
.data
        .set    bypv,4
        .set    marsn,10

mars:   .size   mars,bypv*marsn
        .fill   marsn,bypv,0

.text
        bal     main

.global main
.thumb_func
main:
        push    {r4-r7,lr}

        ldr     r4,=mars
        mov     r5,#0                   @ i

loop:
        add     r6,r5,#1
        mov     r7,#1                   @ aux register
        lsl     r7,r6
        sub     r7,r7,#1
        str     r7,[r4,#0]
        add     r4,#bypv

        add     r5,r5,#1
        cmp     r5,#marsn
        blt     loop

done:
        ldr     r4,=mars

        mov     r0,#0
        pop     {r4-r7,pc}

.end
