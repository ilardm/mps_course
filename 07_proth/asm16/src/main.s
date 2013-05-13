.thumb
.data
        .set    bypv,4
        .set    prothn,10
        .set    k,1                     @ must be positive odd integer

proth:  .size   proth,bypv*prothn
        .fill   prothn,bypv,0

.text
        bal     main

.global main
.thumb_func
main:
        push    {r4-r7,lr}

        ldr     r4,=proth
        mov     r5,#0                   @ i
        mov     r6,#0                   @ count
        mov     r7,#0                   @ j
        mov     r0,#k

loop:
        add     r1,r5,#1
        mov     r7,#1
        lsl     r7,r1

        cmp     r0,r7
        bge     main_01
        mov     r2,r0                   @ pn
        mul     r2,r7
        add     r2,r2,#1
        str     r2,[r4,#0]
        add     r4,#bypv
        add     r6,r6,#1

main_01:
        add     r5,r5,#1

        cmp     r6,#prothn
        blt     loop

done:
        ldr     r4,=proth

        mov     r0,#0
        pop     {r4-r7,pc}

.end
