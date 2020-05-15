/*********************************************************************
 *
 *              Module for encrypting/decrypting data using 
 *              the second revision of the SKIPJACK Algorigthm.
 *
 *********************************************************************
 * FileName:        SKIPJACK.c
 * Dependencies:    none
 * Processor:       pic18
 * Assembler:       MPASMWIN 02.70.02 or higher
 * Linker:          MPLINK 2.33.00 or higher
 * Company:         Microchip Technology, Inc.
 *
* Software License Agreement
*
* The software supplied herewith by Microchip Technology Incorporated
* (the "Company") for its PICmicro(r) Microcontroller is intended and
* supplied to you, the Company's customer, for use solely and
* exclusively on Microchip PICmicro Microcontroller products. The
* software is owned by the Company and/or its supplier, and is
* protected under applicable copyright laws. All rights are reserved.
* Any use in violation of the foregoing restrictions may subject the
* user to criminal sanctions under applicable laws, as well as to
* civil liability for the breach of the terms and conditions of this
* license.
*
* Microchip Technology Inc. ("Microchip") licenses this software to 
* you solely for use with Microchip products.  The software is owned 
* by Microchip and is protected under applicable copyright laws.  
* All rights reserved.
*
* You may not export or re-export Software, technical data, direct 
* products thereof or any other items which would violate any applicable
* export control laws and regulations including, but not limited to, 
* those of the United States or United Kingdom.  You agree that it is
* your responsibility to obtain copies of and to familiarize yourself
* fully with these laws and regulations to avoid violation.
*
* SOFTWARE IS PROVIDED "AS IS."  MICROCHIP EXPRESSLY DISCLAIM ANY 
* WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT 
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
* PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL MICROCHIP
* BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES,
* LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF PROCUREMENT
* OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS BY THIRD PARTIES
* (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), ANY CLAIMS FOR 
* INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS. 
*
 *
 *
 *
 * Author               Date        Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * David Flowers        05/27/04    Initial Revision
 ********************************************************************/

/****************************** Headers *****************************/
#include <stdint.h>
#include "key.h"
/****************************** Constants ***************************/
const unsigned char FTable[] =
									{
										0xa3,0xd7,0x09,0x83,0xf8,0x48,0xf6,0xf4,0xb3,0x21,0x15,0x78,0x99,0xb1,0xaf,0xf9,
										0xe7,0x2d,0x4d,0x8a,0xce,0x4c,0xca,0x2e,0x52,0x95,0xd9,0x1e,0x4e,0x38,0x44,0x28,
										0x0a,0xdf,0x02,0xa0,0x17,0xf1,0x60,0x68,0x12,0xb7,0x7a,0xc3,0xe9,0xfa,0x3d,0x53,
										0x96,0x84,0x6b,0xba,0xf2,0x63,0x9a,0x19,0x7c,0xae,0xe5,0xf5,0xf7,0x16,0x6a,0xa2,
										0x39,0xb6,0x7b,0x0f,0xc1,0x93,0x81,0x1b,0xee,0xb4,0x1a,0xea,0xd0,0x91,0x2f,0xb8,
										0x55,0xb9,0xda,0x85,0x3f,0x41,0xbf,0xe0,0x5a,0x58,0x80,0x5f,0x66,0x0b,0xd8,0x90,
										0x35,0xd5,0xc0,0xa7,0x33,0x06,0x65,0x69,0x45,0x00,0x94,0x56,0x6d,0x98,0x9b,0x76,
										0x97,0xfc,0xb2,0xc2,0xb0,0xfe,0xdb,0x20,0xe1,0xeb,0xd6,0xe4,0xdd,0x47,0x4a,0x1d,
										0x42,0xed,0x9e,0x6e,0x49,0x3c,0xcd,0x43,0x27,0xd2,0x07,0xd4,0xde,0xc7,0x67,0x18,
										0x89,0xcb,0x30,0x1f,0x8d,0xc6,0x8f,0xaa,0xc8,0x74,0xdc,0xc9,0x5d,0x5c,0x31,0xa4,
										0x70,0x88,0x61,0x2c,0x9f,0x0d,0x2b,0x87,0x50,0x82,0x54,0x64,0x26,0x7d,0x03,0x40,
										0x34,0x4b,0x1c,0x73,0xd1,0xc4,0xfd,0x3b,0xcc,0xfb,0x7f,0xab,0xe6,0x3e,0x5b,0xa5,
										0xad,0x04,0x23,0x9c,0x14,0x51,0x22,0xf0,0x29,0x79,0x71,0x7e,0xff,0x8c,0x0e,0xe2,
										0x0c,0xef,0xbc,0x72,0x75,0x6f,0x37,0xa1,0xec,0xd3,0x8e,0x62,0x8b,0x86,0x10,0xe8,
										0x08,0x77,0x11,0xbe,0x92,0x4f,0x24,0xc5,0x32,0x36,0x9d,0xcf,0xf3,0xa6,0xbb,0xac,
										0x5e,0x6c,0xa9,0x13,0x57,0x25,0xb5,0xe3,0xbd,0xa8,0x3a,0x01,0x05,0x59,0x2a,0x46
									};

/****************************** Variables ***************************/
uint8_t stepNumber = 0;
uint8_t counter;
uint8_t temp;

/****************************** Macros ******************************/

/****************************** Function Prototypes *****************/
unsigned int _GPermut(unsigned int var);
unsigned int _GPermutInv(unsigned int var);

/****************************** Functions ***************************/

/*********************************************************************
 * Function:        void SKIPJACKEncode(unsigned int* data, unsigned int dataLength)
 *
 * PreCondition:    None
 *
 * Input:           data - array of data to be encoded (must be even length)
 *					dataLength - length of data array (must be a multiple of 4)
 *
 * Output:          None
 *
 * Side Effects:    _data values change
 *
 * Stack Requirements: 2 deep
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/

void SKIPJACKEncode(unsigned int* data, unsigned char dataLength)
{
	unsigned char i=0;
	unsigned char j;
	unsigned int oldw1;
	unsigned int GPermutResults;
	
	while(i<dataLength)
	{
		counter = 1;
		stepNumber = 0;

		/* RULE A */
		for(j=0;j<8;j++)
		{
			/* save old w1 */
			oldw1 = *data;
			GPermutResults = _GPermut(oldw1);
			/* w1 = G(w1) ^ w4 ^ counter */
			*data = GPermutResults ^ *(data+3) ^ counter;
			/* w4 = w3 */
			*(data+3)=*(data+2);
			/* w3 = w2 */
			*(data+2)=*(data+1);
			/* w2 = G(old w1) */
			*(data+1)=GPermutResults;
			/* counter++ */
			counter++;
		}
		
		/* RULE B */
		for(j=0;j<8;j++)
		{
			oldw1 = *data;
			/* w1 = w4 */
			*data=*(data+3);
			/* w4 = w3 */
			*(data+3)=*(data+2);
			/* w3 = old w1 ^ old w2 ^ counter */
			*(data+2)=oldw1 ^ *(data+1) ^ counter;
			/* w2 = G(old w1) */
			*(data+1)=_GPermut(oldw1);
			/* counter++ */
			counter++;
		}
		
		/* RULE A */
		for(j=0;j<8;j++)
		{
			/* save old w1 */
			oldw1 = *data;
			GPermutResults = _GPermut(oldw1);
			/* w1 = G(w1) ^ w4 ^ counter */
			*data = GPermutResults ^ *(data+3) ^ counter;
			/* w4 = w3 */
			*(data+3)=*(data+2);
			/* w3 = w2 */
			*(data+2)=*(data+1);
			/* w2 = G(old w1) */
			*(data+1)=GPermutResults;
			/* counter++ */
			counter++;
		}

		/* RULE B */
		for(j=0;j<8;j++)
		{
			oldw1 = *data;
			/* w1 = w4 */
			*data=*(data+3);
			/* w4 = w3 */
			*(data+3)=*(data+2);
			/* w3 = old w1 ^ old w2 ^ counter */
			*(data+2)=oldw1 ^ *(data+1) ^ counter;
			/* w2 = G(old w1) */
			*(data+1)=_GPermut(oldw1);
			
			counter++;
		}
		i+=4;
		data+=4;
	}	
}

/*********************************************************************
 * Function:        unsigned int GPermut(unsigned int var)
 *
 * PreCondition:    None
 *
 * Input:           var - variable to be G Permuted
 *
 * Output:          permuted value of the input var
 *
 * Side Effects:    None
 *
 * Stack Requirements: 1 deep 
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
unsigned int _GPermut(unsigned int var)
{
	unsigned char g1,g2,g3,g4,g5,g6;

	/* g1 = upper byte of var */
	Nop();
	g1 = (unsigned char)(var>>8);
	/* g2 = lower byte of var */
	g2 = (unsigned char)(var);

	temp = stepNumber<<2;

	g3 = FTable[g2 ^ CRYPTOVAR[(temp++)%10]] ^ g1;
	g4 = FTable[g3 ^ CRYPTOVAR[(temp++)%10]] ^ g2;
	g5 = FTable[g4 ^ CRYPTOVAR[(temp++)%10]] ^ g3;
	g6 = FTable[g5 ^ CRYPTOVAR[(temp  )%10]] ^ g4;

	stepNumber++;
	/* g5 is upper byte of output */
	/* g6 is lower byte of output */

	return ((((unsigned int)g5)<<8)+g6);
}


/*********************************************************************
 * Function:        void SKIPJACKDecode(unsigned long* data, unsigned int dataLength, unsigned char iterations)
 *
 * PreCondition:    None
 *
 * Input:           data - array of data to be decoded (must be even length)
 *					dataLength - length of data array (must be even)
 *					interations - number of Feistel cycles to iterate on the data 
 *					(min suggested is 16, 64 is standard for high security projects
 * 					highest levels cracked so far are around 10 cycles)
 *
 * Output:          None
 *
 * Side Effects:    _data values change
 *
 * Stack Requirements: 2 deep
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/

void SKIPJACKDecode(unsigned int* data, unsigned char dataLength)
{
	unsigned char i=0;
	unsigned char j;
	unsigned int oldw2;
	unsigned int GPermutResults;
	
	while(i<dataLength)
	{
		counter = 32;
		stepNumber = 31;

		/* RULE B^-1 */
		for(j=0;j<8;j++)
		{
			oldw2 = *(data+1);
			GPermutResults = _GPermutInv(oldw2);
			/* w2 = G^-1(w2) ^ w3 ^ counter */
			*(data+1)= GPermutResults ^ *(data+2) ^ counter;
			/* w3 = w4 */
			*(data+2)=*(data+3);
			/* w4 = w1 */
			*(data+3)=*data;
			/* w1 = G^-1(old w2) */
			*data=GPermutResults;
			/* counter-- */
			counter--;
		}

		/* RULE A^-1 */
		for(j=0;j<8;j++)
		{
			/* save old w2 */
			oldw2 = *(data+1);
			/* w2 = w3 */
			*(data+1)=*(data+2);
			/* w3 = w4 */
			*(data+2)=*(data+3);
			/* w4 = w1 ^ w2 ^ counter */
			*(data+3)=*data ^ oldw2 ^ counter;
			/* w1 = [G^-1(w2)] */
			*data = _GPermutInv(oldw2);
			/* counter-- */
			counter--;
		}
		
		/* RULE B^-1 */
		for(j=0;j<8;j++)
		{
			oldw2 = *(data+1);
			GPermutResults = _GPermutInv(oldw2);
			/* w2 = G^-1(w2) ^ w3 ^ counter */
			*(data+1)= GPermutResults ^ *(data+2) ^ counter;
			/* w3 = w4 */
			*(data+2)=*(data+3);
			/* w4 = w1 */
			*(data+3)=*data;
			/* w1 = G^-1(old w2) */
			*data=GPermutResults;
			/* counter-- */
			counter--;
		}
		
		/* RULE A^-1 */
		for(j=0;j<8;j++)
		{
			/* save old w2 */
			oldw2 = *(data+1);
			/* w2 = w3 */
			*(data+1)=*(data+2);
			/* w3 = w4 */
			*(data+2)=*(data+3);
			/* w4 = w1 ^ w2 ^ counter */
			*(data+3)=*data ^ oldw2 ^ counter;
			/* w1 = [G^-1(w2)] */
			*data = _GPermutInv(oldw2);
			/* counter-- */
			counter--;
		}
		i+=4;
		data+=4;
	}	
}

/*********************************************************************
 * Function:        unsigned int GPermutInv(unsigned int var)
 *
 * PreCondition:    None
 *
 * Input:           var - variable to be G inversely permuted
 *
 * Output:          inversely permuted value of the input var
 *
 * Side Effects:    None
 *
 * Stack Requirements: 1 deep (function call itself)
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
unsigned int _GPermutInv(unsigned int var)
{
	unsigned char g1,g2,g3,g4,g5,g6;

	/* g5 = upper byte of var */
	g5 = (unsigned char)(var>>8);
	/* g6 = lower byte of var */
	g6 = (unsigned char)(var);

	temp = (stepNumber<<2)+3;

	g4 = FTable[g5 ^ CRYPTOVAR[(temp--)%10]] ^ g6;
	g3 = FTable[g4 ^ CRYPTOVAR[(temp--)%10]] ^ g5;
	g2 = FTable[g3 ^ CRYPTOVAR[(temp--)%10]] ^ g4;
	g1 = FTable[g2 ^ CRYPTOVAR[(temp  )%10]] ^ g3;

	stepNumber--;

	/* g1 is upper byte of output */
	/* g2 is lower byte of output */
	return ((((unsigned int)g1)<<8)+g2);
}
