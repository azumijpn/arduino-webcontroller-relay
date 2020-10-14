#include "InterfaceSerial.h"




/***********************************************************
 *                       PROPERTIES                        *
 **********************************************************/




static const uint8_t _READ_NB_RETRY = 128;





/***********************************************************
 *                         PUBLIC                          *
 **********************************************************/




void InterfaceSerial::begin()
{
  WS_SERIAL.begin(WS_SERIAL_SPEED);

  this->setStream(&WS_SERIAL);

  this->_currentStream->setTimeout(WS_SERIAL_TIMEOUT);
}


void InterfaceSerial::loop()
{
  if (WS_SERIAL.available() > 0) {
    if (this->read()) {
      WS_SERIAL.print(WS_CHAR_TX_BEGIN);
      this->process();
      WS_SERIAL.print(WS_CHAR_TX_END);
    } else {
      WS_SERIAL.print(WS_CHAR_RX_UNKNOWN);
    }

    this->terminate();
  }
}



/***********************************************************
 *                        PROTECTED                        *
 **********************************************************/




char InterfaceSerial::_read()
{
    uint8_t nbRetry = _READ_NB_RETRY;
    int c;

    do {
        c = WS_SERIAL.read();
        if (c>=0) {
            break;
        }

        delay(1);
    } while (--nbRetry);

    return c;
}
