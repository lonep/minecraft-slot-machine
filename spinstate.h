#ifndef SPINSTATE_H
#define SPINSTATE_H

#include "state.h"

class SpinState : public State
{
public:
    SpinState();
    virtual ~SpinState() override;
    virtual const int getStateId() override;
};

#endif // SPINSTATE_H
