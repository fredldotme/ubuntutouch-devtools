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

#ifndef DEVTOOLS_H
#define DEVTOOLS_H

#include <QObject>

class DevTools: public QObject {
    Q_OBJECT

public:
    DevTools();
    ~DevTools() = default;

    Q_INVOKABLE bool check(const QString& tool);
    Q_INVOKABLE bool setup();
    Q_INVOKABLE void remove();
};

#endif
