#include <QGuiApplication>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QObject>
#include <QDebug>

#include "statemachine.h"
#include "spintimer.h"

#include "gamemanager.h"
#include "player.h"

enum States
{
    wait = 1,
    spin = 2,
    win  = 3

};

template <typename T>
void invokeFunction (T argument, QObject &object, QByteArray functionName)
{
    QMetaObject::invokeMethod(&object, functionName, //Connect c++ to qml
            Q_ARG(T, argument));
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    StateMachine *stateMachine = new StateMachine();
    spinTimer    *timer        = new spinTimer();

    GameManager  *gameManager  = new GameManager();


    const QUrl url(u"qrc:/slots/main.qml"_qs);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QQmlComponent component(&engine, QUrl(u"qrc:/slots/main.qml"_qs));
    engine.load(url);
    QObject *object = engine.rootObjects().first();

    QObject::connect(object, SIGNAL(startButtonPressed()), stateMachine, SLOT(setSpinState())); //Connect button to c++
    QObject::connect(object, SIGNAL(spinStopped()), stateMachine, SLOT(setWinState())); //Connect button to c++
    QObject::connect(object, SIGNAL(sendWinData(int, int, int)), gameManager, SLOT(handleGameResult(int, int, int))); //Connect button to c++

    while(1)
    {
         app.processEvents();

        if (stateMachine->getStateObject()->getStateId() == States::spin && !gameManager->getIsSpin())
        {
            if (gameManager->checkRequiredBalance())
            {
            QMetaObject::invokeMethod(object, "start", //Connect c++ to qml
                    Q_ARG(int, timer->getSpinTime()));

            gameManager->setIsSpin(true);
            gameManager->payForGame();


            QMetaObject::invokeMethod(object, "balanceLabelChange", //Connect c++ to qml
                       Q_ARG(int, gameManager->getPlayer()->getBalance()));
            app.processEvents();
            }
            else
            {
                stateMachine->setWinState();
            }
        }

        if (stateMachine->getStateObject()->getStateId() == States::win)
        {
            QMetaObject::invokeMethod   (object, "winLabelChange", //Connect c++ to qml
                    Q_ARG(int, gameManager->getCurrentSpinWin()));

            gameManager->setIsSpin(false);
            stateMachine->setWaitState();

            app.processEvents();
        }


        if (stateMachine->getStateObject()->getStateId() == States::wait)
        {
            QMetaObject::invokeMethod(object, "balanceLabelChange", //Connect c++ to qml
                    Q_ARG(int, gameManager->getPlayer()->getBalance()));
            app.processEvents();
        }
    }

    return app.exec();

}
