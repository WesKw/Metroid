.gba
.open "mf.gba", "OperationPadAnywhere.gba", 0x8000000

;Makes the Operation Pad usable with Event++ hex tweak by P.J.Boy.
;Can also be done as a hex tweak.

.org 0x8060EC0		;SA-X Event Check
	mov r0, 66h
	NOP

.org 0x8060ED8		;SA-X Down event check
	mov r0, 67h		;
	NOP
	
.close