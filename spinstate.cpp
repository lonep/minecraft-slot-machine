#include "spinstate.h"

SpinState::SpinState()
{
    stateId = 2;
}

SpinState::~SpinState()
{

}

const int SpinState::getStateId()
{
    return stateId;
}
