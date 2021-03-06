#ifndef AbstractInterfaceWebApp_H_
#define AbstractInterfaceWebApp_H_

#include <Arduino.h>
#include <Client.h>
#include "config.h"
#include "macro.h"
#include "AbstractStream.h"
#include "PowerManager.h"
#include "WebApp.h"



class AbstractInterfaceWebApp : public AbstractStream {

  public:
  virtual void begin(void) {};
  virtual void loop(void)  {};

  protected:
  void _listen(Client* client);

};


#endif
