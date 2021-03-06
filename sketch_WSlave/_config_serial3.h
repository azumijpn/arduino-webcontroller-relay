#ifndef _config_H_
#define _config_H_

#include "constant.h"



// board metadata
// =========================
// a number between 2 and 253
#define WS_RELAY_NB_MAX     32
#define WS_STORAGE          WS_STORAGE_EEPROM
#define WS_LOG_LEVEL        WS_LOG_LEVEL_OFF
#define WS_LOWPOWER         ( WS_LOWPOWER_ALL - WS_LOWPOWER_DOWNCLOCK )
// =========================


// ITF conf
// =========================
#define WS_INTERFACE        WS_INTERFACE_SERIAL
#define WS_VERBOSE          WS_VERBOSE_NONE
#define WS_ACL_ALLOW        WS_ACL_ALLOW_ALL
// =========================


// Serial conf
// =========================
// multiply by the clock divisor (ex:9600 baud at 2MHz instead of 16Mhz is 1200 baud)
#define WS_SERIAL_ID        3
#define WS_SERIAL_SPEED     115200
// =========================



#endif // config_H_
