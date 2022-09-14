#include "statemachine.h"
#include <QDebug>

StateMachine::StateMachine()
{
    setWaitState();
}

StateMachine::~StateMachine()
{
    delete state;
    delete winState;
    delete waitState;
    delete spinState;
}

void StateMachine::setState(State &state)
{
    this->state = &state;
}

void StateMachine::setSpinState()
{
    setState(*spinState);
}

void StateMachine::setWinState()
{
    setState(*winState);
}

void StateMachine::setWaitState()
{
    setState(*waitState);
}

State* StateMachine::getStateObject()
{
    return state;
}
