import QtQuick 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.20 as Kirigami
import org.kde.ksvg as KSvg
import org.kde.plasma.workspace.components 2.0 as WorkspaceComponents
import "."

Item {
    id: root
    anchors.centerIn: parent
    property var source
    KSvg.SvgItem {
        id: svgItem
        opacity: 1
        width: parent.width
        height: width
        property int sourceIndex: 0
        anchors.centerIn: parent
        smooth: true
        svg: KSvg.Svg {
            id: svg
            colorSet: Kirigami.Theme.colorSet
            imagePath: Qt.resolvedUrl("../../icons/" + source)
        }
    }

    // Kirigami.IconItem {
    //     anchors.centerIn: parent
    //     width: parent.width
    //     height: width
    //     visible: engineIcon != ""
    //     source: engineIcon
    //     smooth: true
    // }
}
