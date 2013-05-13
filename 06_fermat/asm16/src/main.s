.thumb
.data
        .set    bypv,4
        .set    fermn,5

ferm:   .size   ferm,bypv*fermn
        .fill   fermn,bypv,0

.text
        bal     main

.global main
.thumb_func
main:
        push    {r4-r7,lr}

        ldr     r4,=ferm
        mov     r5,#0                   @ i

loop:
        mov     r7,#1
        lsl     r7,r5
        mov     r6,#1
        lsl     r6,r7
        add     r6,r6,#1
        str     r6,[r4,#0]
        add     r4,#bypv

        add     r5,r5,#1
        cmp     r5,#fermn
        blt     loop

done:
        ldr     r4,=ferm

        mov     r0,#0
        pop     {r4-r7,pc}

.end
