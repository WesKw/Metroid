.gba

.open "mf.gba", "GreyX.gba", 0x8000000

;0x8041540

;Author: Spedimus
;Grey X. Look and feel harmless but are actually pretty draining.
;Specifically, they cut your missile and PB ammo in half.
;Modifies Ice-X sprite.

.org 0x8040FCE
	sub		r0, 1Eh
	bl		80F9A28h
	
.org 0x80F9A28				;Unused sound, feel free to repoint.
	push 	r14
	strb 	r0, [r2]
	ldrb 	r0, [r2, 4h]	
	lsr 	r0, 1h
	strb	r0, [r2, 4h]	;Lower missiles
	ldrb 	r0, [r2, 8h]
	lsr		r0, 1h
	strb 	r0, [r2, 8h]		;Lower PBs
	pop 	r14
	bx		r14

.close