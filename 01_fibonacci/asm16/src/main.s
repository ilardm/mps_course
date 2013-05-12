.thumb
.data
        .equ    fibn,10                 @ length of Fib. sequence
        .equ    fibsz,40                @ size of Fib. array (fibn*4 bytes)

.bss
        .lcomm  fib,40                  @ array for Fib. seq.

.text
        bal     main

/** First 10 Fibonacci numbers generation
 *
 * r0   points to n-th number memory address
 * r1   n - 1 number
 * r2   n - 2 number
 * r3   n-th number
 * r4   end address of array
 * r5   shift register
 */

.global main
.thumb_func
main:
        push    {r4-r7,lr}

        @ store array end address
        ldr     r0,=fib                 @ load array start address
        mov     r4,r0                   @ copy to end-addr registern
        add     r4,r4,#fibsz            @ add array length

        @ initialize fist two numbers
        mov     r1,#0
        mov     r2,#1
        stmia   r0!,{r1,r2}             @ store and inc. array ptr

        @ fill aux. shift register
        mov     r5,#4

        @ fill fib array
loop:
        sub     r0,r0,#8                @ move array ptr back (~ldmdb)
        ldmia   r0!,{r1,r2}             @ load registers (~ldmdb)
        add     r3,r2,r1                @ evaluate next Fib. number
        str     r3,[r0,#0]              @ store number (~str r,[b],#s)
        add     r0,r0,r5                @ and inc. array ptr (~str r,[b],#s)
        cmp     r0,r4                   @ check if ptr >= end addr.
        blt     loop                    @ repeat loop if not

done:
        ldr     r0,=fib                 @ just for conv. of debugging

        mov     r0,#0                   @ return 0
        pop     {r4-r7,pc}

.end
