/* 
 * File:   key.h
 * Author: samuel
 *
 * Created on March 25, 2020, 8:58 PM
 */

#ifndef KEY_H
#define	KEY_H

#ifdef	__cplusplus
extern "C" {
#endif
#include <stdint.h>

    const uint8_t aes128_key[16] = {
        0xa4,
        0xf8,
        0x54,
        0x78,
        0xb5,
        0x74,
        0xad,
        0xc8,
        0xa4,
        0xf8,
        0x54,
        0x78,
        0xb5,
        0x74,
        0xad,
        0xc8
    };
    
    const uint32_t key[4] = {
        0xa4f85478,
        0xb574adc8,
        0xa4f85478,
        0xb574adc8
    };
    
    const uint8_t CRYPTOVAR[10] = {
        0x00,
        0x99,
        0x88,
        0x77,
        0x66,
        0x55,
        0x44,
        0x33,
        0x22,
        0x11
    };


#ifdef	__cplusplus
}
#endif

#endif	/* KEY_H */

