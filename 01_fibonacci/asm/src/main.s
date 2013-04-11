.section .data
        .equ    fibn,10                 @ length of Fib. sequence

.section .bss
        .lcomm  fib,40                  @ array for Fib. sequence

.section .text

        .global main
main:
        push    {ip,lr}

        @ calculate end address of fin array
        mov     r0,#fibn
        mov     r1,#4
        mul     r4,r0,r1
        ldr     r0,=fib
        add     r4,r4,r0

        @ initialize first two numbers
        mov     r1,#0
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
