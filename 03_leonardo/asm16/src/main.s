.thumb
.text
        bal     main

.global main
.thumb_func
main:
        push    {r4-r7,lr}

        @ actual code here
        
        mov     r0,#0
        pop     {r4-r7,pc}

.end
