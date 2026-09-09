import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma5support as P5Support
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    property string gpuStatus: "Checking..."
    property int nvidiaProcCount: 0
    property string lastChecked: ""

    // Runs shell commands and reads their stdout
    P5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []

        onNewData: (sourceName, data) => {
            var out = data["stdout"] ? data["stdout"].toString().trim() : ""

            if (out.length === 0) {
                root.nvidiaProcCount = 0
                root.gpuStatus = "Idle — nothing offloaded to NVIDIA GPU"
            } else {
                var lines = out.split("\n").filter(l => l.length > 0)
                root.nvidiaProcCount = lines.length
                root.gpuStatus = lines.length + " process(es) using the NVIDIA GPU"
            }

            root.lastChecked = new Date().toLocaleTimeString(Qt.locale(), "hh:mm:ss")
            disconnectSource(sourceName)
        }

        function runCmd(cmd) {
            connectSource(cmd)
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: executable.runCmd(
            "nvidia-smi --query-compute-apps=pid,process_name --format=csv,noheader"
        )
    }

    // Panel / compact view: icon + process count badge
    compactRepresentation: RowLayout {
        spacing: Kirigami.Units.smallSpacing

        Kirigami.Icon {
            source: "nvidia"
            Layout.preferredWidth: Kirigami.Units.iconSizes.small
            Layout.preferredHeight: Kirigami.Units.iconSizes.small
        }

        PlasmaComponents.Label {
            text: root.nvidiaProcCount > 0 ? root.nvidiaProcCount : ""
            visible: root.nvidiaProcCount > 0
        }
    }

    // Expanded popup view
    fullRepresentation: ColumnLayout {
        Layout.minimumWidth: Kirigami.Units.gridUnit * 14
        Layout.minimumHeight: Kirigami.Units.gridUnit * 6
        spacing: Kirigami.Units.smallSpacing

        PlasmaComponents.Label {
            text: "NVIDIA PRIME Status"
            font.bold: true
            font.pointSize: theme.defaultFont.pointSize + 1
        }

        PlasmaComponents.Label {
            text: root.gpuStatus
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }

        PlasmaComponents.Label {
            text: "Last checked: " + root.lastChecked
            opacity: 0.6
            font.pointSize: theme.smallestFont.pointSize
        }

        PlasmaComponents.Button {
            text: "Refresh now"
            icon.name: "view-refresh"
            onClicked: executable.runCmd(
                "nvidia-smi --query-compute-apps=pid,process_name --format=csv,noheader"
            )
        }
    }
}
