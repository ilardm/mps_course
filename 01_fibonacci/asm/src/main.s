.section .data
        .equ    fibn,10                 @ length of Fib. sequence
        .equ    fibsz,40                @ size of Fib. array (fibn*4 bytes)

.section .bss
        .lcomm  fib,40                  @ array for Fib. seq. (fibn*4 bytes)

.section .text
        bal     main

/** First 10 Fibonacci numbers generation
 *
 * r0   points to n-th number memory address
 * r1   n - 1 number
 * r2   n - 2 number
 * r3   n-th number
 * r4   end address of array
 */

        .global main
main:
        push    {r4-r11,lr}

        @ calculate end address of fin array
        ldr     r0,=fib                 @ load Fib. array start address
        mov     r4,r0
        add     r4,r4,#fibsz            @ evaluate end address

        @ initialize first two numbers
        mov     r1,#0
        mov     r2,#1
        stmia   r0!,{r1,r2}             @ store and inc. array ptr.

        @ fill fib array
loop:
        ldmdb   r0,{r2,r1}              @ load last 2 numbers in reverse order
        add     r3,r2,r1                @ evaluate next number
        str     r3,[r0],#4              @ store and inc. array ptr.
        cmp     r0,r4                   @ check if ptr. >= end address
        blt     loop                    @ repeat loop if not

done:
        ldr     r0,=fib

        mov     r0,#0                   @ return 0 ;
        pop     {r4-r11,pc}

.end
