.gba
.open "mf.gba", "MinimapJammerSprite.gba", 0x8000000

;Author: Spedimus
;A sprite that makes the map not display the room tiles and 
;prevents pausing, Super Metroid boss room style, "minimap interference", whatever 
;you want to call it.
;Uses sprite 35
;Feel free to comment out the electricity sound.

.definelabel DisablePauseFlag,	0x300002B
.definelabel MapX, 				0x30000B2
.definelabel MapY, 				0x30000B3
.definelabel PlaySound,			0x800270C
.definelabel SpriteRAM, 		0x30006BC
.definelabel ElectricSound,		0x8A		;Electric damage sound
.definelabel CurrentFrame,		0x300013B

.org 0x802F528
	push 	r14
	ldr 	r2, =SpriteRAM + 24h
	mov		r1, 4h
	strb	r1, [r2]				;Sprite is not drawn
	ldr		r2, =MapX				;MapX address
	lsr		r1, 2h
	strb	r1, [r2]
	add		r2, 1h					;MapY Address
	strb	r1, [r2]
	ldr		r2, =DisablePauseFlag	;Disables pausing
	mov		r1, 1h
	strb	r1, [r2]
	ldr		r2, =CurrentFrame
	ldrb	r1, [r2]
	cmp		r1, 3Ch					;Check if 60th frame
	beq		@@Sound
	b		@@Return
	
@@Sound:
	mov		r0, ElectricSound		;Plays an electric sound when "Jamming", feel free to comment out if annoying
	bl		PlaySound
	
@@Return:
	pop		r14
	bx		r14
	
.pool

.close