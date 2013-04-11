.section .data
        .equ    lucn,10                 @ length of Luc. sequence

.section .bss
        .lcomm  luc,40                  @ array for Luc. sequence

.section .text

        .global main
main:
        push    {ip,lr}

        @ calculate end address of luc array
        mov     r0,#lucn
        mov     r1,#4
        mul     r4,r0,r1
        ldr     r0,=luc
        add     r4,r4,r0

        @ initialize first two numbers
        mov     r1,#2
        mov     r2,#1
        stmia   r0!,{r1,r2}

        @ fill fib array
loop:
        ldmdb   r0,{r2,r1}
        add     r3,r2,r1
        str     r3,[r0],#4
        cmp     r0,r4
        blt     loop

        mov     r0,#0
        pop     {ip,pc}

.end
