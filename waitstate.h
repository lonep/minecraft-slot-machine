#ifndef WAITSTATE_H
#define WAITSTATE_H

#include "state.h"

class WaitState : public State
{
public:
    WaitState();
    virtual ~WaitState() override;
    virtual const int getStateId() override;
};

#endif // WAITSTATE_H
