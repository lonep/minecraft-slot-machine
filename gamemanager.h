#ifndef GAMEMANAGER_H
#define GAMEMANAGER_H
#include <QObject>
#include "player.h"

class GameManager : public QObject
{
    Q_OBJECT
public:
    GameManager();
    virtual ~GameManager();

    Player* getPlayer();

    virtual const int getCurrentSpinWin();
    virtual const bool getIsSpin();
    virtual void  setIsSpin(bool isSpin);

    virtual bool checkRequiredBalance();
    void payForGame();

protected:
    int gamePrice       = 20;
    int threeInRowPrize = 30;
    int twoInRowPrize   = 20;

    Player *player;
    int currentSpinWin = 0;

    bool isSpin = false;

public slots:
    virtual void handleGameResult(int slotItemId1, int slotItemId2, int slotItemId3);
};

#endif // GAMEMANAGER_H
