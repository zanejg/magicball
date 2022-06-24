#!/usr/bin/python
import time
import sys
import datetime as dt
import json
from pymemcache.client import base

import hardware
from LED_control import four_LED_driver
from rotary import RotaryAndSwitch

client = base.Client(('localhost', 11211))
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
    
dm2col = {"x":"RED",
          "y":"GREEN",
          "z":"BLUE"}  

last_lighted_state = True

last_event_time = dt.datetime.now()

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
            leds.all_same_RGB("FFFFFF")
        else:
            leds.all_off()
        last_lighted_state = lighted_state
        
    # pull out the last 10 events from memcached
    #import pdb;pdb.set_trace()
    current_event = client.get("current_event")
    if current_event:
        current_event_num = int(current_event)
        ten_start = 1 if current_event_num < 10 else current_event_num-9
        last_ten = []
        for cc in range(ten_start,current_event_num+1):
            last_ten.append(client.get(f"ev{cc}"))
        #import pdb;pdb.set_trace()
        for evstr in last_ten:
            ev = json.loads(evstr)
            this_time = dt.datetime.fromisoformat(ev['time'])
            if this_time > last_event_time:
                # then we haven't processed the event yet
                dm = ev['dimension']
                if ev['event']=="fwd_cycle":
                    dirn = "brighten"  
                    leds.step_one_colour(dm2col[dm],dirn)
                elif ev['event']=="fwd_cycle":
                    dirn = "dim"
                    leds.step_one_colour(dm2col[dm],dirn)
            
        
        last_event = json.loads(last_ten[-1])
        last_event_time = dt.datetime.fromisoformat(last_event['time'])
        
        
    time.sleep(0.1)
    


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


