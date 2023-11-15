import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami 2.20 as Kirigami
import "components" as Components

PlasmoidItem {
    preferredRepresentation: fullRepresentation
    Layout.preferredWidth: root.width + 8

    // Rectangle {
    //     anchors.fill: parent
    //     color: "#000000"
    //     opacity: 0.2
    //     radius: height / 2
    // }

    Loader {
        id: windowInfoLoader
        sourceComponent: plasmaTasksModel

        Component{
            id: plasmaTasksModel
            PlasmaTasksModel{
                filterByScreen: true //plasmoid.configuration.filterByScreen
            }
        }
    }

    readonly property bool inEditMode: latteInEditMode || plasmoid.userConfiguring

    readonly property bool mustHide: {
        if (inEditMode) {
            return false;
        }

        if (!existsWindowActive) {
            return true;
        }

        if (!existsWindowShown) {
            return true;
        }

        if (!isLastActiveWindowMaximized) {
            return true;
        }

        return false;
    }

    Plasmoid.status: {
        if (mustHide) { //&& !isEmptySpaceEnabled
        //     //if ((plasmoid.formFactor === PlasmaCore.Types.Horizontal && animatedMinimumWidth === 0)
        //     //        || (plasmoid.formFactor === PlasmaCore.Types.Vertical && animatedMinimumHeight === 0)) {
                return PlasmaCore.Types.HiddenStatus;
        //     //}
        }
        // return PlasmaCore.Types.HiddenStatus
        return PlasmaCore.Types.ActiveStatus;
    }

    readonly property bool existsWindowActive: (windowInfoLoader.item && windowInfoLoader.item.existsWindowActive) //  || containmentIdentifierTimer.running
        
    readonly property bool isLastActiveWindowMaximized: (windowInfoLoader.item && windowInfoLoader.item.existsWindowMax) //  || containmentIdentifierTimer.running

    readonly property bool existsWindowShown: (windowInfoLoader.item && windowInfoLoader.item.existsWindowShown) //  || containmentIdentifierTimer.running
    
    GridLayout {
        id: root
        // anchors.verticalCenter: parent.verticalCenter
        anchors.centerIn: parent

        property int scrollWheelDelta: 0

        readonly property bool inEditMode: plasmoid.userConfiguring

        rows: 1
        columns: 3

        columnSpacing: 4
        rowSpacing: 0

        // Rectangle {
        //     anchors.fill: parent
        //     color: "red"
        //     opacity: 0.1
        // }

        Rectangle {
            id: closeContainer
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 22 //{
            Layout.minimumHeight: 22
            // anchors.centerIn: parent
            radius: width / 2

            Components.PlasmoidIcon {
                id: closeIcon
                width: 16 //PlasmaCore.Units.roundToIconSize(container.height)
                height: height
                source: "window-close.svg"
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: {
                    parent.color = Kirigami.Theme.negativeTextColor
                }
                onExited: {
                    parent.color = "transparent"
                }
                onClicked: windowInfoLoader.item.toggleClose()
            }
        }

        Rectangle {
            id: minimizeContainer
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 22 //{
            Layout.minimumHeight: 22
            // anchors.centerIn: parent
            radius: width / 2

            Components.PlasmoidIcon {
                id: minimizeIcon
                width: 16 //PlasmaCore.Units.roundToIconSize(container.height)
                height: height
                source: "window-minimize.svg"
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: {
                    parent.color = Kirigami.Theme.neutralTextColor
                }
                onExited: {
                    parent.color = "transparent"
                }
                onClicked: windowInfoLoader.item.toggleMinimized()
            }
        }

        Rectangle {
            id: restoreContainer
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 22 //{
            Layout.minimumHeight: 22
            // anchors.centerIn: parent
            radius: width / 2

            Components.PlasmoidIcon {
                id: restoreIcon
                width: 16 //PlasmaCore.Units.roundToIconSize(container.height)
                height: height
                source: "window-restore.svg"
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: {
                    parent.color = Kirigami.Theme.positiveTextColor
                }
                onExited: {
                    parent.color = "transparent"
                }
                onClicked: windowInfoLoader.item.toggleMaximized()
            }
        }
    }

}

