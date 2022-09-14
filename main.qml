import QtQuick 2.4
import QtQuick.Controls
//import QtQuick.Window 2.2
import QtMultimedia

ApplicationWindow {
    id: window
    visible: true
    minimumHeight: 600
    maximumHeight: 600
    minimumWidth: 800
    maximumWidth: 800
    width: 800
    height: 600

    property int slotWidth: 200
    property int slotHeight: 1200
    property int slotElementSize: 170

    signal startSpin()
    signal spinStopped()
    signal sendWinData(int id1, int id2, int id3)
    signal startButtonPressed()

    FontLoader { id: minecraftFont; source: "qrc:/new/prefix1/res/MinecraftRegular-Bmg3.otf" }

    MediaPlayer {
        id: mainTheme
        source: "qrc:/new/prefix1/res/mainTheme.mp3"
        audioOutput: AudioOutput {}
    }

    MediaPlayer {
        id: spinSound
        source: "qrc:/new/prefix1/res/slotSpinSound.mp3"
        audioOutput: AudioOutput {}
       loops: 100
    }

    Component.onCompleted: {
     mainTheme.play()
    }



    Timer {
          id: spinTimer
            running: false; repeat: false
            onTriggered:{
                            console.log("animation timer:", animationTimer1.running)
                animationTimer1.stop()
                animationTimer2.stop()
                animationTimer3.stop()
                spinSound.stop()
                lever.source = "qrc:/new/prefix1/res/lever.png"
                console.log("SPIN STOPPED")
                lever.enabled = true
                leverButton.leverFlag = false
                spinStopped()
                sendWinData(firstSlotPathView.currentIndex, secondSlotPathView.currentIndex, thirdSlotPathView.currentIndex)
            }
    }

    Timer {
          id: animationTimer1
            interval: 370; repeat: true
            onTriggered: firstSlotPathView.incrementCurrentIndex()
    }

    Timer {
          id: animationTimer2
            interval: 380; repeat: true
            onTriggered: secondSlotPathView.incrementCurrentIndex()
    }

    Timer {
          id: animationTimer3
            interval: 390 ; repeat: true
            onTriggered: thirdSlotPathView.incrementCurrentIndex()

    }

    Timer {
        id: playerStopTimer
        interval: 340; repeat: false
        onTriggered: spinTimer.triggered()
    }

    Button {
        id: leverButton
        x: 720
        y: 270
        height: 140
        width: 70
        background: transparent
        z: 5

        property bool leverFlag: false //False - рычаг подня, true - опущен
        onClicked:{
            startButtonPressed();
            winLabel.text = "0"
            console.log("STARTSPIN");
            lever.source = "qrc:/new/prefix1/res/lever_flip.png"

            if (leverFlag === true)
            {
                stopByPlayer()
            }
            else
            {
                leverFlag = true
            }

        }
        Image {
            id: lever
            x: leverButton.x
            y: leverButton.y

            anchors.fill: parent
            source: "qrc:/new/prefix1/res/lever.png"
            }
     }





    Label {
        id: balanceLabel
        text: "100"
        x: 332
        y: 540
        z: 4
    }

    Label {
       x: 322
       y: 520
       z: 4
       text: "Balance"
       font: minecraftFont.font
    }

    Label {
       id: winLabel
       text: "0"
       x: 478
       y: 540
       z:4
    }

    Label {
        x: 475
        y: 520
        z: 4
        font: minecraftFont.font
        text: "Win"
    }


    Label {
        x: 717
        y: 260
        z: 4
        font: minecraftFont.font
        text: "Start/Stop"
    }


Item {
    id:firstSlot
    height: slotHeight
    width: slotWidth
    x: 95
    y: 0
    z: 2
    PathView {
        id: firstSlotPathView
        anchors.fill: parent
        pathItemCount: 3
        preferredHighlightBegin: 0.2
        preferredHighlightEnd: 0.2
        model: [1,2,3]
        delegate: viewDelegate
        currentIndex: 1
        interactive: false

        path: Path {
            startX: width/2
            startY: 0

            PathLine {x:firstSlotPathView.width / 2 ; y: firstSlotPathView.height * 0.2}
            PathPercent { value: 0 }
            PathAttribute { name: "z"; value: 0 }


            PathLine {x:firstSlotPathView.width / 2 ; y: firstSlotPathView.height * 0.4}
            PathPercent { value: 0.33 }
            PathAttribute { name: "z"; value: 10 }


            PathLine { relativeX: 0; relativeY: 0 }
            PathAttribute { name: "z"; value: 10 }


            PathLine {x: firstSlotPathView.width / 2 ; y:  firstSlotPathView.height*0.6}
            PathPercent { value: 0.66 }
            PathAttribute { name: "z"; value: 10 }


            PathLine { relativeX: 0; relativeY: 0 }
            PathAttribute { name: "z"; value: 10 }


            PathLine {x:firstSlotPathView.width / 2; y: firstSlotPathView.height * 0.8 }
            PathPercent { value: 1 }
            PathAttribute { name: "z"; value: 0 }
        }
    }
    Component {
        id: viewDelegate
            Image {
                source: (index%3 === 0) ? "qrc:/new/prefix1/res/gold.png" : (index%2 === 0) ? "qrc:/new/prefix1/res/dimond.png" : "qrc:/new/prefix1/res/iron.png"
                height: slotElementSize
                width: slotElementSize
            }
        }
}

    Item {
        id: secondSlot
        height: slotHeight
        width: slotWidth
        z: 2
        anchors.left: firstSlot.right
        anchors.leftMargin: 8
    PathView {
        id: secondSlotPathView
        anchors.fill: parent
        pathItemCount: 3
        preferredHighlightBegin: 0.2
        preferredHighlightEnd: 0.2
        model: [1,2,3]
        delegate: viewDelegate2
        currentIndex: 2
        interactive: false
        path: Path {
            startX: secondSlotPathView.width/4
            startY: 0

            PathLine {x:secondSlotPathView.width / 2 ; y: secondSlotPathView.height * 0.2}
            PathPercent { value: 0 }
            PathAttribute { name: "z"; value: 0 }


            PathLine {x:secondSlotPathView.width / 2 ; y: secondSlotPathView.height * 0.4}
            PathPercent { value: 0.33 }
            PathAttribute { name: "z"; value: 10 }


            PathLine { relativeX: 2; relativeY: 0 }
            PathAttribute { name: "z"; value: 10 }


            PathLine {x: secondSlotPathView.width / 2 ; y:  secondSlotPathView.height*0.6}
            PathPercent { value: 0.66 }
            PathAttribute { name: "z"; value: 10 }


            PathLine { relativeX: 0; relativeY: 0 }
            PathAttribute { name: "z"; value: 10 }


            PathLine {x:secondSlotPathView.width / 2; y: secondSlotPathView.height * 0.8 }
            PathPercent { value: 1 }
            PathAttribute { name: "z"; value: 0 }
        }
    }


    Component {
        id: viewDelegate2
            Image {
                source: (index%3 === 0) ? "qrc:/new/prefix1/res/gold.png" : (index%2 === 0) ? "qrc:/new/prefix1/res/dimond.png" : "qrc:/new/prefix1/res/iron.png"
                height: slotElementSize
                width: slotElementSize
            }
        }

    }

    Item {
        id: thirdSlot
        height: slotHeight
        width: slotWidth
        anchors.left: secondSlot.right
        anchors.leftMargin: 8

        z: 2
    PathView {
        id: thirdSlotPathView
        anchors.fill: parent
        pathItemCount: 3
        preferredHighlightBegin: 0.2
        preferredHighlightEnd: 0.2
        interactive: false
        model: [1,2,3]
        delegate: viewDelegate3
        currentIndex: 3


        path: Path {
            startX: thirdSlotPathView.width/2
            startY: 0

            PathLine {x:thirdSlotPathView.width / 2 ; y: thirdSlotPathView.height * 0.2}
            PathPercent { value: 0 }
            PathAttribute { name: "z"; value: 0 }


            PathLine {x:thirdSlotPathView.width / 2 ; y: thirdSlotPathView.height * 0.4}
            PathPercent { value: 0.33 }
            PathAttribute { name: "z"; value: 10 }


            PathLine { relativeX: 0; relativeY: 0 }
            PathAttribute { name: "z"; value: 10 }


            PathLine {x: thirdSlotPathView.width / 2 ; y:  thirdSlotPathView.height*0.6}
            PathPercent { value: 0.66 }
            PathAttribute { name: "z"; value: 10 }


            PathLine { relativeX: 0; relativeY: 0 }
            PathAttribute { name: "z"; value: 10 }


            PathLine {x:thirdSlotPathView.width / 2; y: thirdSlotPathView.height * 0.8 }
            PathPercent { value: 1 }
            PathAttribute { name: "z"; value: 0 }
        }
    }


    Component {
        id: viewDelegate3
            Image {
                source: (index%3 === 0) ? "qrc:/new/prefix1/res/gold.png" : (index%2 === 0) ? "qrc:/new/prefix1/res/dimond.png" : "qrc:/new/prefix1/res/iron.png"
                height: slotElementSize
                width: slotElementSize
            }
        }
}

    Image {
        source: "qrc:/new/prefix1/res/mainSlotTexture.png"
        height: parent.height
        width: parent.width
        z: 3
    }

    Image {
        source: "qrc:/new/prefix1/res/coalBack.png"
        z: 1
        anchors.horizontalCenter: parent.horizontalCenter
        width: 1200
        x: 100
    }


    function start(msg: int) : string {
            console.log("Got message:", msg)
            spinTimer.interval = msg
            spinTimer.start()
            animationTimer1.start()
            animationTimer2.start()
            animationTimer3.start()
                        console.log("spin timer:", spinTimer.interval)
            spinSound.play()

            return "Some return value"
        }
    function stopByPlayer() {
            lever.source = "qrc:/new/prefix1/res/lever.png"
            lever.enabled = false
            playerStopTimer.start()

            }

    function winLabelChange(result: int) : string {
                winLabel.text = result
            }

    function balanceLabelChange(result: int) : string {
                balanceLabel.text = result
            }
    function lowBalanceAlert(msg: string) : string {
                    balanceLabel.text = msg
                }
}

