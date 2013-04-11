.text

.global main
main:
        push    {ip,lr}

        @ actual code here

        mov     r0,#0
        pop     {ip,pc}

.end
