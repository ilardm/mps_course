.section .data
        .equ    leon,10                 @ length of Leo. sequence

.section .bss
        .lcomm  leo,40                  @ array for Leo. sequence

.section .text

        .global main
main:
        push    {ip,lr}

        @ calculate end address of leo array
        mov     r0,#leon
        mov     r1,#4
        mul     r4,r0,r1
        ldr     r0,=leo
        add     r4,r4,r0

        @ initialize first two numbers
        mov     r1,#1
        mov     r2,#1
        stmia   r0!,{r1,r2}

        @ fill leo array
loop:
        ldmdb   r0,{r2,r1}
        add     r3,r2,r1
        add     r3,r3,#1
        str     r3,[r0],#4
        cmp     r0,r4
        blt     loop

        mov     r0,#0
        pop     {ip,pc}

.end
