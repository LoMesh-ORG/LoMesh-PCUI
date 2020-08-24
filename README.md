# xTendLoRa-PCUI
 PC UI to configure and control xTenLoRa devices
To use this UI
1. Install python 3.6 or better
2. Install syserial and stopit modules using pip
3. Run the python file xTendLoRaApp.py

To edit the UI
1. Install page from https://sourceforge.net/projects/page/
2. Open the toolUI.ui from the repository to edit the UI

To use the bootloader host utility
1. Install python 3.6 or better
2. Install syserial module using pip
3. Run the bootloader utility with the target unit in bootloader mode
python bootloader.py -f <path to hex file> -c <COM port>
4. Wait till the loading is done as it can take a minute or more.
