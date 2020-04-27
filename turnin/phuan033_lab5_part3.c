/*	Author: lab
 *  Partner(s) Name: 
 *	Lab Section:
 *	Assignment: Lab #  Exercise #
 *	Exercise Description: [optional - include for your own benefit]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */

//DEMO: https://drive.google.com/open?id=1demqa8

#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

enum States{START, INIT, WAIT, SWITCH, WAIT2, SWITCH2, BACK} state;
unsigned char button;
unsigned char cnt = 0x00;
unsigned char end = 0x00;

void Tick()
{
	button = (~PINA & 0x01);

	switch(state) {
		case START:
			state = INIT;
			cnt = 0x00;
			break;

		case INIT:

			if(button)
			{		
				if(cnt == 0)
				{
					cnt++;
					PORTB = 0x21;
	                                state = WAIT;
				}
				else if(cnt == 1)
				{
					cnt++;
					PORTB = 0x12;
	                                state = WAIT;
				}
				else if(cnt == 2)
				{
					cnt++;
					PORTB = 0x0C;
	                                state = SWITCH;
				}
				else
				{
					break;
				}

			}
		break;

		case BACK:

			if(button)
			{
				if(cnt == 0x00)
				{
					cnt++;
					PORTB = 0xC;
					state = WAIT2;
				}
				else if(cnt == 0x01)
				{
					cnt++;
					PORTB = 0x12;
					state = WAIT2;
				}
				else if(cnt == 0x02)
				{
					cnt++;
					PORTB = 0x21;
					state = SWITCH2;
				}
				else
				{
					break;
				}
			}

			break;


		case SWITCH:

			if(!button)
			{
				cnt = 0x00;
				state = BACK;
			
			}
			else
			{
				state = SWITCH;
			}

			break;

		case SWITCH2:
				
			if(!button) 
			{
				cnt = 0x00;
				state = START;
			}
			else
			{
				state = SWITCH2;
			}

		case WAIT:
			if(!button)
			{
				state = INIT;
			}
			else
			{
				state = WAIT;
			}

			break;

		case WAIT2:
			if(!button)
			{
				state = BACK;
			}
			else
			{ 
				state = WAIT2;
			}

			break;

		default:
			state = START;
			break;
	}

	switch(state)
	{
		case SWITCH2:
			cnt = 0x00;
			break;
	}

}

int main(void) {
	DDRA = 0x00; PORTA = 0xFF;
	DDRB = 0xFF; PORTB = 0x00;

	state = START;
	PORTB = 0x00;

	while(1) {
		Tick();
	}

		return 0;
}
