#include "waitstate.h"

WaitState::WaitState()
{
    stateId = 1;
}

WaitState::~WaitState()
{

}


const int WaitState::getStateId()
{
    return stateId;
}
