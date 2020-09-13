#ifndef InterfaceSerial_H_
#define InterfaceSerial_H_

#include <Arduino.h>
#include "config.h"
#include "macro.h"
#include "AbstractStream.h"



class InterfaceSerial : public AbstractStream {

  public:
  void begin();
  void loop();

  protected:
  char _read();

};


#endif
