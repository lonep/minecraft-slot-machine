#ifndef STATEMACHINE_H
#define STATEMACHINE_H

#include "state.h"
#include "waitstate.h"
#include "winstate.h"
#include "spinstate.h"

#include <QObject>

class StateMachine : public QObject
{
    Q_OBJECT
public:
    StateMachine();
  virtual  ~StateMachine();


   virtual State* getStateObject();


protected:
    State *state;

    State *winState   = new WinState();
    State *waitState  = new WaitState();
    State *spinState  = new SpinState();

   virtual void setState(State &state);

public slots:


    virtual void setSpinState();
    virtual void setWinState();
    virtual void setWaitState();



};

#endif // STATEMACHINE_H
