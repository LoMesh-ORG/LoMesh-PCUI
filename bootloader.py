import serial
import time
from intelhex import IntelHex
import threading
import sys

port = "COM7"
baudrate = 115200

checksum = 0

command_get_version = 0
command_write_flash = 2
command_erase_row   = 3
command_checksum    = 8
command_reset       = 9

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
    commandbuffer.append((start_addr >> 32) & 0xFF)

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
    commandbuffer.append((start_addr >> 32) & 0xFF)

    #print(commandbuffer)
    for i in data:
        commandbuffer.append(i)
    with serial.Serial(port, baudrate, timeout = 1) as ser:
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
    commandbuffer.append((start_addr >> 32) & 0xFF)

    #print(commandbuffer)
    data = []
    
    with serial.Serial(port, baudrate, timeout = 20) as ser:
            ser.write(commandbuffer)
            ser.reset_input_buffer()
            data = ser.read(12)
            #print(data)
    return ((data[11] << 8) + data[10])

def bootload_hex(filepath):
    ih = IntelHex(filepath)

    t = threading.Thread(target = calculate_checksum, args=(ih,))
    t.start()

    base = ih.segments()[0][0]
    end = ih.segments()[0][1]

    print("Start ", base)
    print("End ", end)

    while (base < end):
        flash_addr = base
        print("Sector: " + str(base))
        packet = bytearray()
        for i in range (1,129):
            packet.append(ih[base])
            base += 1
        
        flash_block(flash_addr,packet)
        #print(flash_block(flash_addr,packet))

    checksum_dev = checksum_device(ih.segments()[0][0],ih.segments()[0][1])
    t.join()

    if(checksum == checksum_dev):
        print("Check Sum matches")
    else:
        print("Check Sum Fails")
    print(checksum,checksum_dev)


def calculate_checksum(ih):
    global checksum
    base = ih.segments()[0][0]
    end = ih.segments()[0][1]

    checksum_temp = 0
    while (base < end):
        checksum_temp += ih[base]        
        base += 1
        
    checksum_temp = checksum_temp & 0xFFFF
    checksum = checksum_temp
    return
    
        
def main():
    # val = read_bootloader_version()
    # n = 0
    # for i in val:
        # print(n,":",hex(i))
        # n+=1
##    val = erase_rows(0x800,496)
##    n = 0
##    for i in val:
##        print(n,":",hex(i))
##        n+=1
    print("file found " + sys.argv[1])
    port = sys.argv[2]
    baudrate = sys.argv[3]
    bootload_hex(sys.argv[1])
    print(reset_device())

if __name__ == "__main__":
    main()
