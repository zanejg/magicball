#!/usr/bin/python
import time
import sys
from pymemcache.client import base

import hardware
from LED_control import four_LED_driver
from rotary import RotaryAndSwitch


leds = four_LED_driver(hardware.channels)

rotasw = RotaryAndSwitch(hardware.ROTARY_LPIN,
                         hardware.ROTARY_RPIN,
                         hardware.ROTARY_SWPIN,
                         leds.LEDs)



def mainvalueChanged(self,value, direction,LEDs):
    if direction == "R":
        [this_led.brighten(4) for this_led in LEDs]
    elif direction == "L":
        [this_led.dim(4) for this_led in LEDs]

rotasw.valueChanged = mainvalueChanged





lighted_state= False

def switch_pressed():
    global lighted_state
    print("pressed")
    while rotasw.get_switch() == "pressed":
        time.sleep(0.1)
    lighted_state = not(lighted_state)
    print("released")
    
    

last_lighted_state = True

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
while(True):
    """
    Main event loop where we will be looking for switch presses
    and ball twists and rotary changes etc
    """
    if rotasw.get_switch() == "pressed":
        switch_pressed()
    
    
    if last_lighted_state != lighted_state:
        if lighted_state:
            leds.all_same_RGB("FF00FF")
        else:
            leds.all_off()
        last_lighted_state = lighted_state
        
    
    
    
    
    
    
    time.sleep(0.1)
    


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@