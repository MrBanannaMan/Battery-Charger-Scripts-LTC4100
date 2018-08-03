!#/bin/bash

#This script reads the Pre-Programmed Charger Status Function, 'ChargerStatus()' at hex 13. See the readme in the repository
#for the 16-bit word significance for the return value of ChargerStatus() or Table 1 of datasheet;
#http://www.analog.com/media/en/technical-documentation/data-sheets/4100fc.pdf

#Address Maps
LTC4100_READ=0x09
SMBUS_SYSTEM_HOST=0x10
LTC4100_DEVICE_ADDRESS=0x12     /Device Slave Address or 0001 0010 BIN with zero-padded Right-side LSB
SMART_BATTERY_SELECTOR=0x14
SMART_BATTERY=0x16

#Read Only Registers
LTC4100_CHARGER_SPEC_INFO=0x11
LTC4100_CHARGER_STATUS=0x13

#Write Only Registers
LTC4100_CHARGER_MODE=0x12
LTC4100_CHARGING_CURRENT=0x14
LTC4100_CHARGING_VOLTAGE=0x15
LTC4100_ALARM_WARNING=0x16

#Read/Write LTC4100 Register
LTC4100_LTCO=0x3C

#Initialize communication with Slave and calling the ChargerStatus() function:
VALUE=$( i2cget -y 0 $LTC4100_DEVICE_ADDRESS $LTC4100_CHARGER_STATUS w )

#Note: The i2c bus used by LTC4100 is '0' as we use LT28.2 jetpack and thus use the /dev/i2c0 bus
#Syntax: I2cget [-f] [-y] <i2cbus> <DEVICE ADDRESS> <FUNCTION/REGISTER ADDRESS> [MODE]
#https://onion.io/2bt-digging-into-i2cget-and-i2cset/

echo "ChargerStatus() Return HEX: "$VALUE
VALUEBIN=$(echo "obase=2; ibase=10; $(($VALUE))" | bc)
echo "ChargerStatus() Return BIN: "$VALUEBIN


