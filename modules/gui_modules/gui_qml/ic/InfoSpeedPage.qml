//InfoSpeedPage.qml

import QtQuick 1.1
import "qtc/PageStatus.js" as PageStatus
import "./qtc"

BasePage {
    id: speedPage
    headerText : "Speed"
    bottomPadding : 0
    isFlickable : false
    //anchors.fill : parent

    property string currentSpeedString : modules.getS("stats", "getCurrentSpeedString")
    property string otherSpeedsString : getOtherSpeeds()

    content {
        Label {
            id : currentSpeed
            anchors.verticalCenter : parent.verticalCenter
            //anchors.top : spacer1.bottom
            //anchors.topMargin : 96 * C.style.main.multiplier
            anchors.horizontalCenter : parent.horizontalCenter
            text: currentSpeedString
            font.pixelSize : 96 * C.style.main.multiplier
        }
        Label {
            id : otherSpeed
            anchors.top : currentSpeed.bottom
            //anchors.top : spacer1.bottom
            anchors.topMargin : 96 * C.style.main.multiplier
            anchors.horizontalCenter : parent.horizontalCenter
            text: otherSpeedsString
            font.pixelSize : 32 * C.style.main.multiplier
        }
    }

    function getOtherSpeeds () {
        var average = modules.getS("stats", "getAverageSpeedString")
        var max = modules.getS("stats", "getMaxSpeedString")
        return "maximum: " + max + "   average: " + average
    }

    Connections {
        target: status == PageStatus.Inactive ? null : gps
        onLastGoodFixChanged: {
            //console.log('SPEED UPDATE')
            currentSpeedString = modules.getS("stats", "getCurrentSpeedString")
            otherSpeedsString = getOtherSpeeds()
        }
    }
}