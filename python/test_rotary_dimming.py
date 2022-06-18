#!/usr/bin/python
# Sample code to demonstrate Encoder class.  
# Prints the value every 5 seconds, and also whenever it changes.

import time
import RPi.GPIO as GPIO
import sys

from encoder import Encoder
from hardware import channels

import LED_control as LC

fld = LC.four_LED_driver(channels)

def valueChanged(value, direction):
    print("* New value: {}, Direction: {}".format(value, direction))
    
    if direction == "R":
        [this_led.brighten(2) for this_led in fld.LEDs]
    elif direction == "L":
        [this_led.dim(2) for this_led in fld.LEDs]
        # for l in range(0,4):
        #     fld.LEDs[l].dim_one()
    
#############################################################
# BUTTON stuff
BUTTON_PIN = 14
GPIO.setmode(GPIO.BCM)
GPIO.setup(BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
#############################################################


#e1 = Encoder(26, 19, valueChanged)
rotary = Encoder(15, 18, valueChanged)


if __name__ == "__main__":
    args = sys.argv
    if len(args)<2:
        fld.all_same_RGB('888888')
    elif len(args)==2:
        fld.all_same_RGB(args[1])
    

    cc=0
    try:
        while True:
            time.sleep(1)
            # if GPIO.input(BUTTON_PIN) == GPIO.LOW:
            #     print("Button was pushed!")
            # cc+=1
            # if cc==5:
            #     print("Value is {}".format(rotary.getValue()))
            #     cc=0
            
    except Exception:
        raise





GPIO.cleanup()
