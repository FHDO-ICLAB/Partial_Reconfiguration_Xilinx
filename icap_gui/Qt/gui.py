from PySide6.QtCore import (QCoreApplication, QDate, QDateTime, QLocale,
    QMetaObject, QObject, QPoint, QRect,
    QSize, QTime, QUrl, Qt)
from PySide6.QtGui import (QAction, QBrush, QColor, QConicalGradient,
    QCursor, QFont, QFontDatabase, QGradient,
    QIcon, QImage, QKeySequence, QLinearGradient,
    QPainter, QPalette, QPixmap, QRadialGradient,
    QTransform)
from PySide6.QtWidgets import (QApplication, QComboBox, QLineEdit, QMainWindow,
    QMenu, QMenuBar, QPushButton, QSizePolicy,
    QStatusBar, QWidget)

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        if not MainWindow.objectName():
            MainWindow.setObjectName(u"MainWindow")
        MainWindow.resize(293, 200)
        self.openFile = QAction(MainWindow)
        self.openFile.setObjectName(u"openFile")
        self.centralwidget = QWidget(MainWindow)
        self.centralwidget.setObjectName(u"centralwidget")
        self.comboBoxCOM = QComboBox(self.centralwidget)
        self.comboBoxCOM.setObjectName(u"comboBoxCOM")
        self.comboBoxCOM.setGeometry(QRect(50, 20, 69, 22))
        self.pushButtonWrite = QPushButton(self.centralwidget)
        self.pushButtonWrite.setObjectName(u"pushButtonWrite")
        self.pushButtonWrite.setGeometry(QRect(130, 20, 75, 24))
        self.pushButtonRead = QPushButton(self.centralwidget)
        self.pushButtonRead.setObjectName(u"pushButtonRead")
        self.pushButtonRead.setGeometry(QRect(130, 70, 75, 24))
        self.lineEditRegister = QLineEdit(self.centralwidget)
        self.lineEditRegister.setObjectName(u"lineEditRegister")
        self.lineEditRegister.setGeometry(QRect(10, 70, 113, 22))
        self.lineEditRegister.setMaxLength(5)
        self.lineEditRegister.setClearButtonEnabled(True)
        MainWindow.setCentralWidget(self.centralwidget)
        self.menuBar = QMenuBar(MainWindow)
        self.menuBar.setObjectName(u"menuBar")
        self.menuBar.setGeometry(QRect(0, 0, 293, 22))
        self.menuFile = QMenu(self.menuBar)
        self.menuFile.setObjectName(u"menuFile")
        MainWindow.setMenuBar(self.menuBar)
        self.statusBar = QStatusBar(MainWindow)
        self.statusBar.setObjectName(u"statusBar")
        MainWindow.setStatusBar(self.statusBar)

        self.menuBar.addAction(self.menuFile.menuAction())
        self.menuFile.addAction(self.openFile)

        self.retranslateUi(MainWindow)

        QMetaObject.connectSlotsByName(MainWindow)
    # setupUi

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QCoreApplication.translate("MainWindow", u"MainWindow", None))
        self.openFile.setText(QCoreApplication.translate("MainWindow", u"Open", None))
        self.pushButtonWrite.setText(QCoreApplication.translate("MainWindow", u"Write", None))
        self.pushButtonRead.setText(QCoreApplication.translate("MainWindow", u"Read", None))
        self.lineEditRegister.setText(QCoreApplication.translate("MainWindow", u"00111", None))
        self.menuFile.setTitle(QCoreApplication.translate("MainWindow", u"File", None))
    # retranslateUi

