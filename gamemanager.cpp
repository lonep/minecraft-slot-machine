#include "gamemanager.h"

GameManager::GameManager()
{
    player = new Player();
}

GameManager::~GameManager()
{
    delete player;
}

void GameManager::handleGameResult(int slotItemId1, int slotItemId2, int slotItemId3)
{
    if (slotItemId1 == slotItemId2 && slotItemId2 == slotItemId3)
    {
            player->setBalance(player->getBalance() + threeInRowPrize);
            currentSpinWin = 30;

    } else if (slotItemId1 == slotItemId2 || slotItemId2 == slotItemId3)
        {
            currentSpinWin = 20;
            player->setBalance(player->getBalance() + twoInRowPrize);
        }
            else
    {
            currentSpinWin = 0;
    }
}

bool GameManager::checkRequiredBalance()
{
    return player->getBalance() >= gamePrice;
}

const int GameManager::getCurrentSpinWin()
{
    return currentSpinWin;
}

const bool GameManager::getIsSpin()
{
 return isSpin;
}

void GameManager::setIsSpin(bool isSpin)
{
    this->isSpin = isSpin;
}

Player* GameManager::getPlayer()
{
    return player;
}

void GameManager::payForGame()
{
    player->setBalance(player->getBalance() - gamePrice);
}
