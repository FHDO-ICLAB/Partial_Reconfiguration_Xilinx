import binascii

import serial
import serial.tools.list_ports


class SerialServer(serial.Serial):

    def __init__(self, port=None, baudrate=115200, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE,
                 stopbits=serial.STOPBITS_ONE):
        super().__init__(port=port, baudrate=baudrate, bytesize=bytesize, parity=parity,
                         stopbits=stopbits)
        self.__bytes_written = 0

    def avail_ports(self):
        ports = serial.tools.list_ports.comports()
        ports_return = []
        for port in ports:
            ports_return.append(port.device)
        return ports_return

    def openServer(self):
        if not self.isOpen():
            self.open()

    def closeServer(self):
        if self.open():
            # Destructor, close port when serial port instance is freed
            self.__del__()

    def tx_data(self, data):
        self.openServer()
        self.__bytes_written = self.write(data)

    def bytes_written(self):
        return self.__bytes_written

