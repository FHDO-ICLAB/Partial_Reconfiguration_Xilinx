import sys
import os
from PySide6 import QtCore, QtGui, QtWidgets
from PySide6.QtUiTools import QUiLoader
from Qt.gui import Ui_MainWindow
from SerialServer import SerialServer


class MainApp(Ui_MainWindow, SerialServer):

    def __init__(self, main):
        main = main
        # calling setupUi method of Ui_MainWindow
        super().setupUi(main)
        # calling own setupUI method
        self._setupUi()
        # call __init__ method of SerialServer
        super().__init__()

    def _setupUi(self):
        # add functionality to stuff

        self.comboBoxCOM.addItems(self.avail_ports())
        self.comboBoxCOM.activated.connect(self._selComPort)

        self.lineEditRegister.setValidator(QtGui.QIntValidator())

        self.openFile.triggered.connect(self._openFile)

        self.pushButtonWrite.clicked.connect(self._write)

        self.pushButtonRead.clicked.connect(self._read)

    def _selComPort(self):
        # get selected port from dropdown
        self.port = self.comboBoxCOM.currentText()
        self.openServer()
        print(self.port)

    def _openFile(self):
        # opens file dialog, only accepts .bin .bit
        self.file_dir = QtWidgets.QFileDialog.getOpenFileName(caption="Choose File",
                                                              filter="Bitstream Files (*.bin *.bit)")

    def bitSwap(self, packet):
        # reverse the bits in each byte in bytearray, formats every byte to 8 bit binary string and reverses it
        # by using slicing. Slicing returns a string that must be converted to a binary integer
        return bytearray(int('{:08b}'.format(byte)[::-1], 2) for byte in packet)

    def _write(self):
        # open file, read binary
        with open(self.file_dir[0], "rb") as file:
            while file:
                # read maximum of 255 bytes at once
                packet = file.read(255)
                reversed_byte_array = self.bitSwap(packet)

                # check if file ended
                if packet:
                    byte_list = bytearray(bytes.fromhex("7E") + bytes.fromhex("00") +
                                          len(reversed_byte_array).to_bytes(1, 'big') +
                                          reversed_byte_array + bytes.fromhex("7E"))
                    self.tx_data(byte_list)
                else:
                    break

    def _read(self):
        byte_array = bytearray()
        # concatenate given address to full address string, slicing off 0x
        address = hex(int(str('00101000000000') + str(self.lineEditRegister.text()) + str('0000000000001'), 2))[2:]
        print(self.lineEditRegister.text())

        print(address)
        bitstream = ["WR FFFFFFFF",
                     "WR AA995566",
                     "WR 20000000",
                     "WR " + address,
                     "WR 20000000",
                     #"RD 20000000",
                     "RD 01",
                    # "RD FFFFFFFF",
                     #"RD 20000000", # dummy for checking
                     "WR 30008001",
                     "WR 0000000D",
                     "WR 20000000",
                     "WR 20000000"
                     ]

        for item in bitstream:
            rw, hex_value = item.split(maxsplit=1)
            if rw.casefold() == "wr":
                reversed_byte_array = self.bitSwap(bytearray.fromhex(hex_value))
                byte_list = bytearray(bytes.fromhex("7E") + bytes.fromhex("00") +
                                      len(reversed_byte_array).to_bytes(1, 'big') +
                                      reversed_byte_array + bytes.fromhex("7E"))
                self.tx_data(byte_list)
            elif rw.casefold() == "rd":
                reversed_byte_array = bytearray.fromhex(hex_value)
                byte_list = bytearray(bytes.fromhex("7E") + bytes.fromhex("01") +
                                      len(reversed_byte_array).to_bytes(1, 'big') +
                                      reversed_byte_array + bytes.fromhex("7E"))
                self.tx_data(byte_list)
            else:
                continue


if __name__ == "__main__":
    import sys

    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = MainApp(MainWindow)
    MainWindow.show()
    sys.exit(app.exec())
