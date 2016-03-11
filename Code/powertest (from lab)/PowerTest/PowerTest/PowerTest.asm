/*
 * PowerTest.asm
 *
 *  Created: 3/8/2016 5:37:10 PM
 *   Author: brubell
 */ 


 
 .include "M328PDEF.INC"

 LDI R16, $02
 LDI R17, $03
 OUT DDRB, R16
 OUT PORTB, R16
 OUT PORTB, R17

 ;
 LDI R16, 0b01111111
 OUT DDRD, R16
 OUT PORTD, R16

 end: rjmp end
