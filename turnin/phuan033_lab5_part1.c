/*	Author: lab
 *  Partner(s) Name: 
 *	Lab Section:
 *	Assignment: Lab #  Exercise #
 *	Exercise Description: [optional - include for your own benefit]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

int main(void) {
    /* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF;
	DDRC = 0xFF; PORTC = 0x00;
	unsigned char fuelLevel = 0x00;
	unsigned char lights = 0x00;
    /* Insert your solution below */
    while (1) {
	
	fuelLevel = (~PINA & 0x0F);

	if(fuelLevel == 0x00)
	{
		lights = 0x40;
	}
	else if((fuelLevel == 0x01) || (fuelLevel == 0x02))
	{
		lights = 0x60;
	}
	else if((fuelLevel == 0x03) || (fuelLevel == 0x04))
	{
		lights = 0x70;
	}
	else if((fuelLevel == 0x05) || (fuelLevel == 0x06))
	{
		lights = 0x38;
	}
	else if((fuelLevel == 0x07) || (fuelLevel == 0x08) || (fuelLevel == 0x09))
	{
		lights = 0x3C;
	}
	else if((fuelLevel == 0x0A) || (fuelLevel == 0x0B) || (fuelLevel == 0x0C))
	{
		lights = 0x3E;
	}
	else if((fuelLevel == 0x0D) || (fuelLevel == 0x0E) || (fuelLevel == 0x0F))
	{
		lights = 0x3F;
	}


	PORTC = lights;

    }
    return 0;
}
