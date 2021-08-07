import serial
import time
from intelhex import IntelHex
import threading
import sys
import os
import argparse
import xtea
from Crypto.Cipher import AES
import Crypto.Cipher.AES

port = ""

baudrate = 115200

key = b'\xa4\xf8\x54\x78\xb5\x74\xad\xc8\xa4\xf8\x54\x78\xb5\x74\xad\xc8'
key_skip = b'\x00,\x99,\x88,\x77,\x66,\x55,\x44,\x33,\x22,\x11'


checksum = 0

command_get_version = 0
command_write_flash = 2
command_erase_row   = 3
command_checksum    = 8
command_reset       = 9
command_set_iv      = 10
command_erase_app   = 11

def read_bootloader_version():
    global command_get_version
    commandbuffer = bytearray()
    commandbuffer.append(0x55)
    commandbuffer.append(command_get_version)
    for i in range(0,8):
        commandbuffer.append(0x00)
    #print(commandbuffer)
    with serial.Serial(port, baudrate, timeout = 1) as ser:
            ser.write(commandbuffer)
            ser.reset_input_buffer()
            return ser.read(30)
    return []

def set_encryption_iv(iv):
    global command_set_iv
    commandbuffer = bytearray()
    commandbuffer.append(0x55) #Auto Baud
    commandbuffer.append(command_set_iv) #command
    
    commandbuffer.append(0x10) #Data length
    commandbuffer.append(0x00)

    commandbuffer.append(0x00) #Magic sequence
    commandbuffer.append(0x00)


    commandbuffer.append(0x00) #Start address
    commandbuffer.append(0x00)
    commandbuffer.append(0x00)
    commandbuffer.append(0x00)
    
    commandbuffer.append(iv[0])
    commandbuffer.append(iv[1])
    commandbuffer.append(iv[2])
    commandbuffer.append(iv[3])
    commandbuffer.append(iv[4])
    commandbuffer.append(iv[5])
    commandbuffer.append(iv[6])
    commandbuffer.append(iv[7])
    commandbuffer.append(iv[8])
    commandbuffer.append(iv[9])
    commandbuffer.append(iv[10])
    commandbuffer.append(iv[11])
    commandbuffer.append(iv[12])
    commandbuffer.append(iv[13])
    commandbuffer.append(iv[14])
    commandbuffer.append(iv[15])
    
    #print (commandbuffer)
    with serial.Serial(port, baudrate, timeout = 5) as ser:
            ser.write(commandbuffer)
            ser.reset_input_buffer()
            return ser.read(9)
    return [-1]
    
def check_all_f(data):
    for i in data:
        if i != 0xFF:
            return -1
    return 0
    
def erase_app_partition():
    global command_erase_row
    commandbuffer = bytearray()
    commandbuffer.append(0x55) #Auto Baud
    commandbuffer.append(command_erase_app) #command
    
    commandbuffer.append(0) #Data length
    commandbuffer.append(0)

    commandbuffer.append(0x55) #Magic sequence
    commandbuffer.append(0xAA)

    commandbuffer.append(0 & 0xFF) #Start address
    commandbuffer.append((0 >> 8) & 0xFF)
    commandbuffer.append((0 >> 16) & 0xFF)
    commandbuffer.append((0 >> 24) & 0xFF)
    #print (commandbuffer)
    with serial.Serial(port, baudrate, timeout = 5) as ser:
            ser.write(commandbuffer)
            ser.reset_input_buffer()
            return ser.read(9)
    return [-1]

def erase_block(start_addr):
    global command_erase_row
    commandbuffer = bytearray()
    commandbuffer.append(0x55) #Auto Baud
    commandbuffer.append(command_erase_row) #command
    
    commandbuffer.append(0) #Data length
    commandbuffer.append(0)

    commandbuffer.append(0x55) #Magic sequence
    commandbuffer.append(0xAA)

    commandbuffer.append(start_addr & 0xFF) #Start address
    commandbuffer.append((start_addr >> 8) & 0xFF)
    commandbuffer.append((start_addr >> 16) & 0xFF)
    commandbuffer.append((start_addr >> 24) & 0xFF)
    #print (commandbuffer)
    with serial.Serial(port, baudrate, timeout = 5) as ser:
            ser.write(commandbuffer)
            ser.reset_input_buffer()
            return ser.read(9)
    return [-1]

def erase_rows(start_addr,number):
    global command_erase_row
    commandbuffer = bytearray()
    commandbuffer.append(0x55) #Auto Baud
    commandbuffer.append(command_erase_row) #command
    
    commandbuffer.append(number & 0xFF) #Data length
    commandbuffer.append((number >> 8) & 0xFF)

    commandbuffer.append(0x55) #Magic sequence
    commandbuffer.append(0xAA)

    commandbuffer.append(start_addr & 0xFF) #Start address
    commandbuffer.append((start_addr >> 8) & 0xFF)
    commandbuffer.append((start_addr >> 16) & 0xFF)
    commandbuffer.append((start_addr >> 24) & 0xFF)

    #print (commandbuffer)
    with serial.Serial(port, baudrate, timeout = 5) as ser:
            ser.write(commandbuffer)
            ser.reset_input_buffer()
            return ser.read(30)
    return [-1]

def flash_block(start_addr,data):
    global command_write_flash
    if(len(data) != 128):
        return [-1]
    
    commandbuffer = bytearray()
    commandbuffer.append(0x55) #Auto Baud
    commandbuffer.append(command_write_flash) #command
    
    commandbuffer.append(len(data) & 0xFF) #Data length
    commandbuffer.append((len(data) >> 8) & 0xFF)

    commandbuffer.append(0x55) #Magic sequence
    commandbuffer.append(0xAA)


    commandbuffer.append(start_addr & 0xFF) #Start address
    commandbuffer.append((start_addr >> 8) & 0xFF)
    commandbuffer.append((start_addr >> 16) & 0xFF)
    commandbuffer.append((start_addr >> 24) & 0xFF)

    #print(commandbuffer)
    for i in data:
        commandbuffer.append(i)
    
    #print(commandbuffer)
    with serial.Serial(port, baudrate, timeout = 5) as ser:
            ser.write(commandbuffer)
            ser.reset_input_buffer()
            return ser.read(11)
    #time.sleep(0.25)
    return [-1]

def reset_device():
    global command_reset
    commandbuffer = bytearray()
    commandbuffer.append(0x55)
    commandbuffer.append(command_reset)
    for i in range(0,8):
        commandbuffer.append(0x00)
    #print(commandbuffer)
    with serial.Serial(port, baudrate, timeout = 1) as ser:
            ser.write(commandbuffer)
            ser.reset_input_buffer()
            return ser.read(30)
    return []

def checksum_device(start_addr,end):
    global command_checksum
    commandbuffer = bytearray()
    commandbuffer.append(0x55) #Auto Baud
    commandbuffer.append(command_checksum) #command

    datlen = (end - start_addr)
    commandbuffer.append(datlen & 0xFF) #Data length
    commandbuffer.append((datlen >> 8) & 0xFF)
    
    commandbuffer.append(0)
    commandbuffer.append(0)

    commandbuffer.append(start_addr & 0xFF) #Start address
    commandbuffer.append((start_addr >> 8) & 0xFF)
    commandbuffer.append((start_addr >> 16) & 0xFF)
    commandbuffer.append((start_addr >> 24) & 0xFF)

    #print(commandbuffer[0:20])
    data = []
    
    with serial.Serial(port, baudrate, timeout = 20) as ser:
            ser.write(commandbuffer)
            ser.reset_input_buffer()
            data = ser.read(14)
            #print(data)
    return ((data[13] << 24) | (data[12] << 16) |(data[11] << 8) | data[10])

def bootload_hex(filepath):
    global key
    ih = IntelHex(filepath)

    t = threading.Thread(target = calculate_checksum, args=(ih,))
    t.start()

    base = ih.segments()[0][0]
    end = ih.segments()[0][1]

    print("Start ", hex(base))
    print("End ", hex(end))
    resp = erase_app_partition()
    #print(resp)
    total_sectors = ((0x40000 - 0x4000) / 128)
    sectorid = 0
    while (base < end):
        flash_addr = base
        #print("Sector: " + str(base))
        iv = os.urandom(16)
        #iv  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        #print(iv.hex())
        #set_encryption_iv(iv)
        #print("Sector: " + str(base))
        percent = int((sectorid*100)/(total_sectors))
        sectorid = sectorid + 1
        sys.stdout.write("\rProgress: %d%%   Sector:%X" % (percent, base))
        sys.stdout.flush()
        packet = bytearray()
        for i in range (1,129):
            packet.append(ih[base])
            base += 1
        #print(packet)
        rc = flash_block(flash_addr,packet)
        
    print("\n")
    base = ih.segments()[0][0]
    end = ih.segments()[0][1]
    checksum_dev = checksum_device(0x1D004000,(0x40000 - 0x4000))
    t.join()
    checksum = (ih[0x1D03FFFC] << 24) | (ih[0x1D03FFFD] << 16) | (ih[0x1D03FFFE] << 8) | ih[0x1D03FFFF]
    if(checksum == checksum_dev):
        print("Check Sum matches")
    else:
        print("Check Sum Fails")
    print(hex(checksum),hex(checksum_dev))


def calculate_checksum(ih):
    global checksum
    base = ih.segments()[0][0]
    end = ih.segments()[0][1]

    checksum_temp = 0
    while (base < end):
        checksum_temp += ih[base]        
        base += 1
        
    checksum_temp = checksum_temp & 0xFFFFFFFF
    checksum = checksum_temp
    return
    
parser = argparse.ArgumentParser()
parser.add_argument('-f', '--file', help="Path to hex file that is to be flashed", required=True)
parser.add_argument('-c', '--port', help="COM port", required=True)
args=parser.parse_args()
port = args.port
bootload_hex(args.file)
#reset_device()
# def main():
    # global baudrate
    # global port
    # # val = read_bootloader_version()
    # # n = 0
    # # for i in val:
        # # print(n,":",hex(i))
        # # n+=1
# ##    val = erase_rows(0x800,496)
# ##    n = 0
# ##    for i in val:
# ##        print(n,":",hex(i))
# ##        n+=1
    # print("file found " + sys.argv[1])
    # port = sys.argv[2]
    # print(port)
    # baudrate = sys.argv[3]
    # bootload_hex(sys.argv[1])
    # print(reset_device())

# if __name__ == "__main__":
    # main()
