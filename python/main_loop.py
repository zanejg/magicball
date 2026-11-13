#!/usr/bin/python
import time
import sys
import datetime as dt
import json
from pymemcache.client import base
import RPi.GPIO as GPIO

import hardware as hw
from LED_control import four_LED_driver
from rotary import RotaryAndSwitch

from display_modes import main_display_loop
from sensor_modes import main_sensor_loop


memcacheclient = base.Client(('localhost', 11211))
# init with control to ball
memcacheclient.set("lamp_control","ball")

leds = four_LED_driver(hw.channels)

rotasw = RotaryAndSwitch(hw.ROTARY_LPIN,
                         hw.ROTARY_RPIN,
                         hw.ROTARY_SWPIN,
                         leds.LEDs)



WHITE = "FFFFFF"
OFF   = "000000"
RED   = "FF0000"
GREEN = "00FF00"
BLUE  = "0000FF" 

lighted_state= False







#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
main_loop_seq = [RED, GREEN, BLUE]



def base_mode():
    """
    The main parent mode where we are only looking for button presses
    to change the mode
    """
    print("Entered main loop")
    ## need to signal entry to main loop
    for col in main_loop_seq:
        leds.all_same_RGB(col)
        time.sleep(0.2)
        leds.all_same_RGB(OFF)
        time.sleep(0.05)



    while(True):
        if GPIO.input(hw.WHITE_BUTTON_PIN) == GPIO.HIGH:
            memcacheclient.set("lamp_control","ball")
            print("White Button was pushed!")
            hw.button_pressed(hw.WHITE_BUTTON_PIN)
            # to @@@do something@@@ flashes all white beforehand
            leds.all_same_RGB("FFFFFF")
            time.sleep(0.3)
            leds.all_same_RGB("000000")
            # GO TO DISPLAY MODE
            main_display_loop()
            
            
        if GPIO.input(hw.BLUE_BUTTON_PIN) == GPIO.HIGH:
            memcacheclient.set("lamp_control","ball")
            print("Blue Button was pushed!")
            hw.button_pressed(hw.BLUE_BUTTON_PIN)
            # to ENTER ball twist mode loop and flashes all blue beforehand
            leds.all_same_RGB("0000FF")
            time.sleep(0.3)
            leds.all_same_RGB("000000")
            main_sensor_loop(leds,rotasw)
            


    



#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

base_mode()
