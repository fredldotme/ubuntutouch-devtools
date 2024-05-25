/*
 * Copyright (C) 2024  Alfred Neumayer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * devtools is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Controls 2.2 as QQC
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import DevTools 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'devtools.fredldotme'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    function check() {
        gdbRow.ok = DevTools.check("gdb")
        straceRow.ok = DevTools.check("strace")
        valgrindRow.ok = DevTools.check("valgrind")
        logcatRow.ok = DevTools.check("logcat")
    }

    Component.onCompleted: check()

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Dev Tools')
            StyleHints {
                foregroundColor: "white"
                backgroundColor: LomiriColors.graphite
                dividerColor: LomiriColors.slate
            }
        }

        QQC.ScrollView {
            id: scrollView
            anchors {
                top: parent.top
                topMargin: header.height
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            contentWidth: parent.width
            contentHeight: mainLayout.height
            background: Rectangle { color: LomiriColors.graphite }

            ColumnLayout {
                id: mainLayout
                width: parent.width
                height: scrollView.height > nittyGritty.height ? Math.max(scrollView.height, implicitHeight) : nittyGritty.height
                spacing: units.gu(1)

                Item {
                    Layout.fillHeight: scrollView.height > nittyGritty.height
                }

                ColumnLayout {
                    id: nittyGritty
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: implicitHeight
                    spacing: units.gu(1)

                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width
                        text: i18n.tr("Easily set up or remove development tools for use in your Terminal")
                        font.pixelSize: units.gu(4)
                        wrapMode: Label.WordWrap
                        horizontalAlignment: Label.AlignHCenter
                        color: "white"
                    }

                    Row {
                        id: gdbRow
                        property bool ok: false
                        spacing: units.gu(2)
                        Layout.preferredHeight: implicitHeight
                        Layout.alignment: Qt.AlignHCenter

                        Label {
                            text: "gdb:"
                            font.pixelSize: units.gu(2)
                            color: "white"
                        }
                        Icon {
                            name: gdbRow.ok ? "tick" : "close"
                            color: gdbRow.ok ? LomiriColors.lightGreen : LomiriColors.lightRed
                            height: gdbRow.height
                            width: height
                        }
                    }

                    Row {
                        id: straceRow
                        property bool ok: false
                        spacing: units.gu(2)
                        Layout.preferredHeight: implicitHeight
                        Layout.alignment: Qt.AlignHCenter

                        Label {
                            text: "strace:"
                            font.pixelSize: units.gu(2)
                            color: "white"
                        }
                        Icon {
                            name: straceRow.ok ? "tick" : "close"
                            color: straceRow.ok ? LomiriColors.lightGreen : LomiriColors.lightRed
                            height: straceRow.height
                            width: height
                        }
                    }

                    Row {
                        id: valgrindRow
                        property bool ok: false
                        spacing: units.gu(2)
                        Layout.preferredHeight: implicitHeight
                        Layout.alignment: Qt.AlignHCenter

                        Label {
                            text: "valgrind:"
                            font.pixelSize: units.gu(2)
                            color: "white"
                        }
                        Icon {
                            name: valgrindRow.ok ? "tick" : "close"
                            color: valgrindRow.ok ? LomiriColors.lightGreen : LomiriColors.lightRed
                            height: valgrindRow.height
                            width: height
                        }
                    }

                    Row {
                        id: logcatRow
                        property bool ok: false
                        spacing: units.gu(2)
                        Layout.preferredHeight: implicitHeight
                        Layout.alignment: Qt.AlignHCenter

                        Label {
                            text: "logcat:"
                            font.pixelSize: units.gu(2)
                            color: "white"
                        }
                        Icon {
                            name: logcatRow.ok ? "tick" : "close"
                            color: logcatRow.ok ? LomiriColors.lightGreen : LomiriColors.lightRed
                            height: logcatRow.height
                            width: height
                        }
                    }

                    Row {
                        id: buttonsRow
                        Layout.alignment: Qt.AlignHCenter
                        spacing: units.gu(2)

                        Button {
                            text: i18n.tr('Set up')
                            onClicked: {
                                DevTools.setup()
                                root.check()
                            }
                        }

                        Button {
                            text: i18n.tr('Remove')
                            onClicked: {
                                DevTools.remove()
                                root.check()
                            }
                        }
                    }
                }

                Item {
                    Layout.fillHeight: scrollView.height > nittyGritty.height
                }
            }
        }
    }
}
