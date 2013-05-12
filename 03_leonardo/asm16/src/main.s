.thumb
.data
        .equ    leon,10                 @ length of Leo. sequence
        .equ    leosz,40                @ size of Leo. array (leon*4 bytes)

.bss
        .lcomm  leo,40                  @ array for Leo. seq.

.text
        bal     main

.global main
.thumb_func
main:
        push    {r4-r7,lr}

        @ store array end address
        ldr     r0,=leo                 @ load array start address
        mov     r4,r0                   @ copy to end-addr registern
        add     r4,r4,#leosz            @ add array length

        @ initialize fist two numbers
        mov     r1,#1
        mov     r2,#1
        stmia   r0!,{r1,r2}             @ store and inc. array ptr

        @ fill aux. shift register
        mov     r5,#4

        @ fill leo array
loop:
        sub     r0,r0,#8                @ move array ptr back (~ldmdb)
        ldmia   r0!,{r1,r2}             @ load registers (~ldmdb)
        add     r3,r2,r1                @ evaluate next Leo. number
        add     r3,r3,#1
        str     r3,[r0,#0]              @ store number (~str r,[b],#s)
        add     r0,r0,r5                @ and inc. array ptr (~str r,[b],#s)
        cmp     r0,r4                   @ check if ptr >= end addr.
        blt     loop                    @ repeat loop if not

done:
        ldr     r0,=leo                 @ just for conv. of debugging

        mov     r0,#0                   @ return 0
        pop     {r4-r7,pc}

.end
