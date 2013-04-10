.text

.global main
main:
	push	{ip,lr}

	@real code here

	mov	r0,#0
	pop	{ip,pc}

.end
