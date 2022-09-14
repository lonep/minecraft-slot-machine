#ifndef PLAYER_H
#define PLAYER_H


class Player
{
public:
    Player();
    const virtual int getBalance();
    virtual void setBalance(int balance);
    virtual ~Player();

protected:
    int balance = 100;
};

#endif // PLAYER_H
