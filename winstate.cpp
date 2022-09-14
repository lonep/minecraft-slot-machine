#include "winstate.h"

WinState::WinState()
{
    stateId = 3;
}

WinState::~WinState()
{

}


const int WinState::getStateId()
{
    return stateId;
}
