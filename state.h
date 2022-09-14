#ifndef STATE_H
#define STATE_H


class State
{
public:
    State();
    virtual ~State();

    virtual const int getStateId() = 0;
protected:
    int stateId;
};

#endif // STATE_H
