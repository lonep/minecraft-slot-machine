#ifndef WINSTATE_H
#define WINSTATE_H

#include "state.h"

class WinState : public State
{
public:
    WinState();
    virtual ~WinState() override;
    virtual const int getStateId() override;
};

#endif // WINSTATE_H
