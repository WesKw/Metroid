.gba

.open "mf.gba", "NVariaX.gba", 0x8000000

.definelabel VariaXNum, 0x3004E3D
.definelabel CurrSpriteRAM, 0x30006BC
.definelabel SpriteData, 0x3000140
;.definelabel TestingAHHH, 0x3000258
.definelabel totalBosses, 2h			;Default is 2. Use more at your own risk. Using more than 2 causes an odd sound bug.
.definelabel AllUpgr,0x30	

.org 0x8057568
	bl 		80F9A60h
	
.org 0x80574D0
	bl 	 	80F9A28h					;Hijack to unused fusion sound
	pop 	r0, r4, r5		
	bx		r5
	
.org 0x805796A
	bl 		80F9A3Ch
	pop 	r0
	bx 		r0
	
.org 0x80F9A28							;Unused fusion sound
	push 	r5, r6, r14
	mov 	r5, 0h
	ldr		r6, =VariaXNum		
	ldrb 	r5, [r6]
	add		r5, r5, 1h					;Add 1 to boss total in RAM
	strb	r5, [r6]					
	mov 	r5, r14						;Store return in r5
	pop 	r0, r6						;Pop unused registers
	mov		r15, r5						;End of death code
	
.org 0x80F9A3C
	push	r5, r6, r14
	bl 		800F8F0h
	ldr		r5, =VariaXNum
	ldrb	r5, [r5]
	cmp 	r5, totalBosses
	beq 	@@Return
	
@@DespawnCore:
	ldr		r5, =CurrSpriteRAM
	mov 	r6, 0h
	strb 	r6, [r5]					;Despawn Primary Sprite Core-X
	ldr 	r5, =VariaXNum
	ldrb	r6, [r5]
	cmp		r6, totalBosses
	bne 	@@Return

@@Return:
	pop		r5, r6, r14
	bx 		r14

.org 0x80F9A60
	push 	r5, r6, r14					;Set number to 0 on spawn
	mov 	r6, 0h
	ldr 	r5, =VariaXNum
	strb 	r6, [r5]
	mov 	r7, 10h
	add		r0, r7, 0h
	pop 	r5, r6, r14
	bx 		r14

.close