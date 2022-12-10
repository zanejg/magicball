#!/usr/bin/python
import time
import sys
import datetime as dt
import json
from pymemcache.client import base
import RPi.GPIO as GPIO

import hardware
from LED_control import four_LED_driver
from rotary import RotaryAndSwitch

from display_modes import main_display_loop

client = base.Client(('localhost', 11211))
leds = four_LED_driver(hardware.channels)

rotasw = RotaryAndSwitch(hardware.ROTARY_LPIN,
                         hardware.ROTARY_RPIN,
                         hardware.ROTARY_SWPIN,
                         leds.LEDs)

BLUE_BUTTON_PIN = 27
WHITE_BUTTON_PIN = 22
GPIO.setup(BLUE_BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(WHITE_BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)


WHITE = "FFFFFF"
OFF = "000000"
RED = "FF0000"
GREEN = "00FF00"
BLUE = "0000FF" 

lighted_state= False


def mainvalueChanged(self,value, direction,LEDs):
    if direction == "R":
        [this_led.brighten(4) for this_led in LEDs]
    elif direction == "L":
        [this_led.dim(4) for this_led in LEDs]


def rota_switch_pressed():
    global lighted_state
    print("pressed")
    while rotasw.get_switch() == "pressed":
        time.sleep(0.1)
    lighted_state = not(lighted_state)
    print("released")

def button_pressed(button_pin):
    while GPIO.input(button_pin) == GPIO.HIGH:
        time.sleep(0.1)
    




#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
main_loop_seq = [RED, GREEN, BLUE]

def base_mode():
    """
    The main parent mode where we are only looking for button presses
    to change the mode
    """
    ## need to signal entry to main loop
    for col in main_loop_seq:
        leds.all_same_RGB(col)
        time.sleep(0.2)
        leds.all_same_RGB(OFF)
        time.sleep(0.05)



    while(True):
        if GPIO.input(WHITE_BUTTON_PIN) == GPIO.HIGH:
            print("White Button was pushed!")
            button_pressed(WHITE_BUTTON_PIN)
            # to @@@do something@@@ flashes all white beforehand
            leds.all_same_RGB("FFFFFF")
            time.sleep(0.3)
            leds.all_same_RGB("000000")
            # GO TO DISPLAY MODE
            main_display_loop()
            
        if GPIO.input(BLUE_BUTTON_PIN) == GPIO.HIGH:
            print("Blue Button was pushed!")
            button_pressed(BLUE_BUTTON_PIN)
            # to ENTER ball twist mode loop and flashes all blue beforehand
            leds.all_same_RGB("0000FF")
            time.sleep(0.3)
            leds.all_same_RGB("000000")
            ball_twist_mode()


# when we enter the ball twist mode we want to signal this with a 
# swirling pattern around the top 3 LEDs
ball_twist_seq = [
    [RED,  OFF   ,OFF ,  OFF],
    [OFF,  GREEN ,OFF ,  OFF],
    [OFF,  OFF   ,BLUE , OFF],
    [RED,  OFF   ,OFF ,  OFF],
    [OFF,  GREEN ,OFF ,  OFF],
    [OFF,  OFF   ,BLUE , OFF],
]


def ball_twist_mode():
    """
        Event loop mode where we will be looking for switch presses
        and ball twists and rotary changes to change the colour etc
    """
    global lighted_state

    dm2col = {"x":"RED",
            "y":"GREEN",
            "z":"BLUE"}  

    last_lighted_state = True
    last_event_time = dt.datetime.now()
    rotasw.valueChanged = mainvalueChanged
    #lighted_state= False



    # start with a lighting pattern
    for pattern in ball_twist_seq:
        leds.set_each_RGB(pattern)
        time.sleep(0.2)
        leds.all_same_RGB(OFF)
        time.sleep(0.05)


    while(True):
        """
        Event loop 
        """
        if rotasw.get_switch() == "pressed":
            rota_switch_pressed()

        if GPIO.input(WHITE_BUTTON_PIN) == GPIO.HIGH:
            print("White Button was pushed!")
            button_pressed(WHITE_BUTTON_PIN)
            # to escape this loop and flashes all white beforehand
            leds.all_same_RGB("FFFFFF")
            time.sleep(0.3)
            leds.all_same_RGB("000000")
            return
        
        if last_lighted_state != lighted_state:
            if lighted_state:
                leds.all_same_RGB("FFFFFF")
            else:
                leds.all_off()
            last_lighted_state = lighted_state
            
        # pull out the last 10 events from memcached
        #import pdb;pdb.set_trace()
        current_event = client.get("current_event")
        if current_event:
            print(f"event detected:|{current_event}|")
            current_event_num = int(current_event)
            # we need to handle things at the start when there are less than 
            # ten events
            ten_start = 0 if current_event_num < 10 \
                            else current_event_num-10
            last_ten = []
            
            for cc in range(ten_start,current_event_num+1):
                last_ten.append(client.get(f"ev{cc}"))
            print(f"@@@@@@@@@@@LAST TEN @@@@\n{last_ten}\n@@@@@@")
            #import pdb;pdb.set_trace()
            for evstr in last_ten:
                ev = json.loads(evstr)
                this_time = dt.datetime.fromisoformat(ev['time'])
                if this_time > last_event_time:
                    # then we haven't processed the event yet
                    dm = ev['dimension']
                    if ev['event']=="fwd_twist":
                        dirn = "brighten"  
                        leds.step_one_colour(dm2col[dm],dirn)
                    elif ev['event']=="rev_twist":
                        dirn = "dim"
                        leds.step_one_colour(dm2col[dm],dirn)
                
            
            last_event = json.loads(last_ten[-1])
            last_event_time = dt.datetime.fromisoformat(last_event['time'])
            
            
        time.sleep(0.1)
        



#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

base_mode()
