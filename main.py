#!/usr/bin/python3
# -*- coding: utf-8 -*-

import sys
from PyQt5 import QtWidgets, uic
import serial.tools.list_ports
import serial
import re
import time

global win


def refreshCOMPorts():
    global win
    try:
        COMlist = [str(comport.device) for comport in serial.tools.list_ports.comports()]
        win.comboBox_port.clear()
        win.comboBox_port.addItems(COMlist)
    except Exception as e:
        print("Error in finding COM ports " + str(e))


def readCurrentVales():
    try:
        #Get current COM port selected
        port = str(win.comboBox_port.currentText())
        #Creat a serial object
        with serial.Serial(port, 19200, timeout = 1) as ser:
            #read network address
            ser.write(b'AT+NADDR?\r\n')
            result = re.search('%s(.*)%s' % ("=", "\r"), ser.readline().decode('utf-8'))[0]
            win.lineEdit_NADDR.setText(result[1:len(result)-1])
            time.sleep(0.1)
            
            #read TX power
            ser.write(b'AT+TXPOWER?\r\n')
            result = re.search('%s(.*)%s' % ("=", "\r"), ser.readline().decode('utf-8'))[0]            
            win.comboBox_TXPower.setCurrentIndex(int(result[1:len(result)-1]) - 2)
            time.sleep(0.1)

            #read radio mode
            ser.write(b'AT+MODE?\r\n')
            result = re.search('%s(.*)%s' % ("=", "\r"), ser.readline().decode('utf-8'))[0]
            win.label_mode.setText(result[1:len(result)-1])
            time.sleep(0.1)

            #read RF channel
            ser.write(b'AT+RFCH?\r\n')
            result = re.search('%s(.*)%s' % ("=", "\r"), ser.readline().decode('utf-8'))[0]            
            win.comboBox_RFChannel.setCurrentIndex(int(result[1:len(result)-1]) - 1)
            time.sleep(0.1)

            #read Hop Count
            ser.write(b'AT+HOPS?\r\n')
            result = re.search('%s(.*)%s' % ("=", "\r"), ser.readline().decode('utf-8'))[0]            
            win.lineEdit_HopCount.setText(result[1:len(result)-1])
            time.sleep(0.1)

            #Read current CAD counter
            ser.write(b'AT+CADCOUNTER?\r\n')
            result = re.search('%s(.*)%s' % ("=", "\r"), ser.readline().decode('utf-8'))[0]
            win.label_CADCounter.setText(result[1:len(result)-1])
            time.sleep(0.1)

            #Read RSSI CAD Level
            ser.write(b'AT+CADRSSI?\r\n')
            result = re.search('%s(.*)%s' % ("=", "\r"), ser.readline().decode('utf-8'))[0]
            win.lineEdit_RSSILevel.setText(result[1:len(result)-1])
            time.sleep(0.1)

            #Read MAC ID
            ser.write(b'AT+MAC?\r\n')
            result = re.search('%s(.*)%s' % ("=", "\r"), ser.readline().decode('utf-8'))[0]
            win.label_MAC.setText(result[1:len(result)-1])
            time.sleep(0.1)

            #Read the Network Short ID
            ser.write(b'AT+ADDR?\r\n')
            result = re.search('%s(.*)%s' % ("=", "\r"), ser.readline().decode('utf-8'))[0]
            win.label_NetworkID.setText(result[1:len(result)-1])
            time.sleep(0.1)

            #Read the Firmware and AT Command version
            ser.write(b'AT+I\r\n')
            result = ser.readline().decode('ASCII')
            result = ser.readline().decode('ASCII')
            win.label_ATVersion.setText(result.split(' ')[3].replace('\r','').replace('\n',''))
            result = ser.readline().decode('ASCII')
            win.label_FirmwareVersion.setText(result.split(' ')[2].replace('\r','').replace('\n',''))
            
    except Exception as e:
        print("Error in loading values from selected device" + str(e))


def saveSettings():
    global win
    try:
        #Get current COM port selected
        port = str(win.comboBox_port.currentText())
        #Creat a serial object
        with serial.Serial(port, 19200, timeout = 1) as ser:
            #Save the network ID
            try:
                value = win.lineEdit_NADDR.text()[0:2].upper()            
                int(value,16)
                #Code reached here so the value must be valid                 
                ser.write(b'AT+NADDR=' + value.encode('utf-8') + b'\r\n')
                time.sleep(0.1)
            except Exception as e:
                print("Error in Setting newwork Address " + str(e))
                QtWidgets.QMessageBox.about(win, "Error", "Error in saving Network ID")

            #Save TX power
            try:
                value = win.comboBox_TXPower.currentText().split(' ')[0]
                value = b'AT+TXPOWER=' + value.encode('utf-8') + b'\r\n')
                print(value)
                ser.write(value)
            except Exception as e:
                print("Error in setting TX power " + str(e))
                QtWidgets.QMessageBox.about(win, "Error", "Error in saving TX Power")
                
            QtWidgets.QMessageBox.about(win, "Save Complete", "All Values were successfully saved")
            
    except Exception as e:
        print("Error in setting new value " + str(e))
        QMessageBox.about(self, "Error", "Error in Saving Values. Please try again")
        


        
if __name__ == "__main__":
    global win
    #Set up all the call backs    
    app = QtWidgets.QApplication([])

    win = uic.loadUi("toolUI.ui") #specify the location of your .ui file
    win.pushButton_Refresh.clicked.connect(refreshCOMPorts)
    win.pushButton_Read.clicked.connect(readCurrentVales)
    win.pushButton_saveWireless.clicked.connect(saveSettings)
    win.tabWidget.setCurrentIndex(0)
    win.show()
    sys.exit(app.exec())
