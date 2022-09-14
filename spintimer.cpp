#include "spintimer.h"

#include <QDateTime>
#include <QCoreApplication>
#include <QRandomGenerator>
#include <QDebug>

spinTimer::spinTimer()
{

}

int spinTimer::getSpinTime()
{

     int value = QRandomGenerator::global()->bounded(4000,7000);
     qDebug() << value << " timer";
     return value;

}

void spinTimer::getSpinSignal()
{
    getSpinTime();
}
