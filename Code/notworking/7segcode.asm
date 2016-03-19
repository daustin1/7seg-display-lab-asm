; semi-working

.nolist
.include "m328pdef.inc"
.list


; User-Defined Macros
.macro LDX ; loading XH and XL
	LDS @0, @2
	LDS @1, (@2+1)
.endmacro

.macro RESETALL
	;	resets all GPRs 
	LDI R16, $00
	LDI R17, $00
	LDI R18, $00
	LDI R19, $00
	LDI R20, $00
	LDI R21, $00
	LDI R22, $00
	LDI R23, $00
	LDI R24, $00
.endmacro

.macro IOSETUP
	;	initial IO setup
	LDI R16, @0
	LDI R17, @1
	OUT DDRB, R16
	OUT PORTB, R16
	OUT PORTB, R17
.endmacro


 ; data space variable selection
.dseg
.org SRAM_START
NUM2DISPLAY: .byte 2


.ORG 0x200
SEG_TABLE: ; table for 7-seg-decode
	.DB 00111111, 00000110,	01010011,01001111,01100110,	01101101,01111101, 00000111,01111111,01100111,01110111,01111110,00111001,01011110,	01111001,01110001
.cseg

;initial setup
.ORG 0x000
RESETALL
IOSETUP $02, $03


LDX XL,XH, NUM2DISPLAY ;Grab from NUM_2_DISPLAY and load into high and low of X
LDI R21, X+ ; load value #1 in
MOV R22,R21 ;Copy R21 to R22
SWAP R21 ; swap digits

ANDI R21, $0F ; R21 = LOWER DIGIT
ANDI R22, $0F ; R22 = UPPER DIGIT
LDI XH,HIGH(SEG_TABLE<<1)	;	xh = high byte
LDI XL,LOW(SEG_TABLE<<1)	;	xl = low byte
ADD XL, R21 ; add value #1 to zl

LPM R20,X	; get next byte into r20			
OUT DDRD, R20	; output to data reg
OUT PORTD, R20	; output to data reg

INC ZL	;	point zl to next byte in lookup table	
DEC R19		;	decrease counter

