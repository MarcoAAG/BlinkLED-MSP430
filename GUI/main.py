# This Python file uses the following encoding: utf-8
import sys
import os

#serial stuff
import serial

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot


class backEnd(QObject):
    def __init__(self, _port, _baudrate, _parity, _stopbits, _bytesize, _timeout):
#         super(backEnd, self).__init__()
        super(backEnd, self).__init__()

        self.serial_connection = serial.Serial(
            port = _port,\
            baudrate = _baudrate,\
            parity = _parity,\
            stopbits = _stopbits,\
            bytesize = _bytesize,\
            timeout = _timeout
        )

    def send(self, _data2send):
        self.serial_connection.write(_data2send)

    @Slot(str)
    def readBtn(self, _data):
#         print(_data)
        self.send(_data.encode())

def main():
#     new_connection = serial_connection("/dev/ttyUSB0",9600, serial.PARITY_NONE, serial.STOPBITS_ONE, serial.EIGHTBITS, 0)

    app = QGuiApplication(sys.argv)
    backend = backEnd("/dev/ttyUSB0",9600, serial.PARITY_NONE, serial.STOPBITS_ONE, serial.EIGHTBITS,0)
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("backEnd", backend)
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    win = engine.rootObjects()[0]
#     win.show()

    return app.exec_()
#     sys.exit(app.exec_())


if __name__ == "__main__":

    sys.exit(main())
