.gba
.open "mf.gba", "ScreenShakeSprite.gba", 0x8000000

;Author: Spedimus
;Shakes the screen and plays an explosion sound.
;Uses sprite 35.

.definelabel SpriteRAM, 		0x30006BC	
.definelabel ScreenShakeX, 		0x300004E
.definelabel CurrentFrame, 		0x300013B
.definelabel PlaySound, 		0x800270C
.definelabel StartHorizShake, 	0x80625C0
.definelabel SoundEffect, 		0xD3	;Change to whatever you want
.definelabel ScrnShakeDuration,	0x20	;Change to whatever you want

.org 0x802F528							;Uses sprite 35 AI.
	push	r14
	ldr 	r2, =SpriteRAM				;Load SpriteRAM offset into r2
	mov		r1, r2						;Move r2 into r1
	add		r1, 24h						;add 24 to r1
	mov		r0, 4h						;Move 4h into r0
	strb	r0, [r1]					;Store byte r0 into r1 address, Sprite is not drawn
	ldr		r2, =CurrentFrame
	ldrb	r2, [r2]
	cmp		r2, 3Ch						;If r2 is greater than or equal to frame 3C, branch to raise, otherwise branch to return
	beq		@@Raise						;Shake plays every 60 frames
	b		@@Return

@@Raise:
	mov		r0, SoundEffect				;Change to whatever sound you want
	bl		PlaySound					
	mov		r0, ScrnShakeDuration
	mov		r1, 9Fh						;Not sure what r1 does
	bl		StartHorizShake
	b		@@Return							
	
@@Return:
	pop		r14
	bx 		r14
	
.pool

.close