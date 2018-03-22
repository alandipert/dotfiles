#!/usr/bin/python3

import dbus
import dbus.service
import signal

session = dbus.SessionBus()
name = dbus.service.BusName("org.gnome.Panel", session)
signal.pause()
