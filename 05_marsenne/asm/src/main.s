.text
        bal     main

.global main
main:
        stmfd   sp!,{r4-r11,lr}

        @ actual code here

        mov     r0,#0
        ldmfd   sp!,{r4-r11,pc}
.end
