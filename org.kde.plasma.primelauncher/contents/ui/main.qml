import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasma5support as P5Support
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    
    property var savedApplications: []
    
    Component.onCompleted: {
        loadSavedApplications()
    }
    
    function loadSavedApplications() {
        var stored = Plasmoid.configuration.savedApplications
        
        if (stored && stored.length > 0) {
            try {
                root.savedApplications = JSON.parse(stored)
            } catch (e) {
                root.savedApplications = []
            }
        } else {
            root.savedApplications = []
        }
    }
    
    function saveApplications() {
        Plasmoid.configuration.savedApplications =
        JSON.stringify(root.savedApplications)
    }
    
    function saveApplication(app) {
        app = app.trim()
        
        if (app.length === 0)
            return
            
            // Don't save duplicates
            if (root.savedApplications.indexOf(app) !== -1)
                return
                
                var updated = root.savedApplications.slice()
                updated.push(app)
                
                root.savedApplications = updated
                saveApplications()
    }
    
    function removeApplication(index) {
        var updated = root.savedApplications.slice()
        updated.splice(index, 1)
        
        root.savedApplications = updated
        saveApplications()
    }
    
    function selectApplication(app) {
        appInput.text = app
    }
    
    P5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        
        function launchNvidia(app) {
            var command =
            "sh -c 'exec env " +
            "__NV_PRIME_RENDER_OFFLOAD=1 " +
            "__GLX_VENDOR_LIBRARY_NAME=nvidia " +
            app.replace(/'/g, "'\\''") +
            "'"
            
            connectSource(command)
        }
    }
    
    // Panel / compact view
    compactRepresentation: RowLayout {
        spacing: Kirigami.Units.smallSpacing
        
        Kirigami.Icon {
            source: "nvidia"
            
            Layout.preferredWidth:
            Kirigami.Units.iconSizes.small
            
            Layout.preferredHeight:
            Kirigami.Units.iconSizes.small
        }
    }
    
    // Expanded popup
    fullRepresentation: ColumnLayout {
        Layout.minimumWidth: Kirigami.Units.gridUnit * 20
        Layout.minimumHeight: Kirigami.Units.gridUnit * 12
        
        spacing: Kirigami.Units.smallSpacing
        
        PlasmaComponents.Label {
            text: "NVIDIA PRIME Offload Launcher"
            font.bold: true
            font.pointSize: theme.defaultFont.pointSize + 1
            Layout.fillWidth: true
        }
        
        PlasmaComponents.Label {
            text: "Launch an application using the NVIDIA GPU"
            opacity: 0.7
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        
        PlasmaComponents.Label {
            text: "Application command"
            font.bold: true
            Layout.topMargin: Kirigami.Units.smallSpacing
        }
        
        PlasmaComponents.TextField {
            id: appInput
            
            placeholderText: "e.g. /usr/bin/furmark"
            Layout.fillWidth: true
            
            onAccepted: {
                if (text.trim().length > 0)
                    launchButton.clicked()
            }
        }
        
        RowLayout {
            Layout.fillWidth: true
            
            PlasmaComponents.Button {
                id: launchButton
                
                text: "Launch with NVIDIA"
                icon.name: "nvidia"
                
                enabled: appInput.text.trim().length > 0
                Layout.fillWidth: true
                
                onClicked: {
                    executable.launchNvidia(appInput.text.trim())
                }
            }
            
            PlasmaComponents.Button {
                text: "Save"
                icon.name: "document-save"
                
                enabled: appInput.text.trim().length > 0
                Layout.fillWidth: true
                
                onClicked: {
                    root.saveApplication(appInput.text)
                }
            }
        }
        
        PlasmaComponents.Label {
            text: "Saved applications"
            font.bold: true
            Layout.topMargin: Kirigami.Units.smallSpacing
            Layout.fillWidth: true
            visible: root.savedApplications.length > 0
        }
        
        PlasmaComponents.Label {
            text: "No saved applications"
            opacity: 0.6
            visible: root.savedApplications.length === 0
            Layout.fillWidth: true
        }
        
        ColumnLayout {
            Layout.fillWidth: true
            spacing: Kirigami.Units.smallSpacing
            
            Repeater {
                model: root.savedApplications
                
                delegate: RowLayout {
                    Layout.fillWidth: true
                    
                    // Saved command — selectable and copyable
                    PlasmaComponents.TextField {
                        text: modelData
                        readOnly: true
                        selectByMouse: true
                        
                        Layout.fillWidth: true
                    }
                    
                    PlasmaComponents.Button {
                        text: "Launch"
                        icon.name: "application-x-executable"
                        
                        onClicked: {
                            executable.launchNvidia(modelData)
                        }
                    }
                    
                    PlasmaComponents.Button {
                        text: "Remove"
                        icon.name: "edit-delete"
                        
                        onClicked: {
                            root.removeApplication(index)
                        }
                    }
                }
            }
        }
    }
}
