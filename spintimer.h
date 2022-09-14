#ifndef SPINTIMER_H
#define SPINTIMER_H
#include <QObject>

class spinTimer: public QObject
{
    Q_OBJECT
public:
    spinTimer();

    int getSpinTime();
public slots:
    void getSpinSignal();

};

#endif // SPINTIMER_H
