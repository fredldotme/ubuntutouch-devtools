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

#include <QDebug>
#include <QDir>
#include <QString>

#include <unistd.h>

#include "devtools.h"

const auto localBinPath = QStringLiteral("/home/phablet/.local/bin");
const auto symlinkTemplate = localBinPath + QStringLiteral("/%1");
const QStringList tools = {
    QStringLiteral("gdb"),
    QStringLiteral("strace"),
    QStringLiteral("valgrind"),
    QStringLiteral("logcat")
};

DevTools::DevTools() {

}

bool DevTools::setup() {
    const auto wrapperTemplate = QStringLiteral("/opt/click.ubuntu.com/devtools.fredldotme/current/lib/aarch64-linux-gnu/bin/%1.wrapper");

    QDir binDir(localBinPath);
    if (!binDir.exists())
        binDir.mkpath(localBinPath);

    if (!binDir.exists()) {
        qWarning() << "Failed to create target dir" << localBinPath;
        return false;
    }

#define CREATE_SYMLINK(tool) \
    (symlink(wrapperTemplate.arg(tool).toStdString().c_str(), symlinkTemplate.arg(tool).toStdString().c_str()))

    bool success = false;

    for (const auto& tool : tools) {
        qDebug() << "Linking" << wrapperTemplate.arg(tool) << "as" << symlinkTemplate.arg(tool);
        success |= (CREATE_SYMLINK(tool) == 0);
        if (!success)
            break;
    }
#undef CREATE_SYMLINK

    qDebug() << "Created all tools?" << success;

    return success;
}

void DevTools::remove()
{
    for (const auto& tool : tools) {
        const auto path = symlinkTemplate.arg(tool);
        QFile file(path);
        qDebug() << "Removing file" << path << file.remove();
    }
}

bool DevTools::check(const QString& tool) {
    return QFile::exists(symlinkTemplate.arg(tool));
}
