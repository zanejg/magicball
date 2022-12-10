#!/usr/bin/python

# To be run at boot.
# Will flash twice on each facet



import sys
import time

import LED_control as LC
import random

from hardware import channels

WHITE = "FFFFFF"
OFF = "000000"
RED = "FF0000"
GREEN = "00FF00"
BLUE = "0000FF" 

all_colours = [RED, GREEN, BLUE]

# the sequence is each LED flashing all 3 cols in turn
seq = [
    [RED,  OFF   ,OFF ,  OFF],
    [GREEN,OFF   ,OFF ,  OFF],
    [BLUE, OFF   ,OFF ,  OFF],
    [OFF,  RED   ,OFF ,  OFF],
    [OFF,  GREEN ,OFF ,  OFF],
    [OFF,  BLUE  ,OFF ,  OFF],
    [OFF,  OFF   ,RED ,  OFF],
    [OFF,  OFF   ,GREEN ,OFF],
    [OFF,  OFF   ,BLUE , OFF],
    [OFF,  OFF   ,OFF ,  RED],
    [OFF,  OFF   ,OFF ,  GREEN],
    [OFF,  OFF   ,OFF ,  BLUE],
]


fld = LC.four_LED_driver(channels)




if __name__ == "__main__":
    fld.all_same_RGB(WHITE)
    time.sleep(0.20)
    fld.all_same_RGB(OFF)
    time.sleep(0.40)
    fld.all_same_RGB(WHITE)
    time.sleep(0.20)
    fld.all_same_RGB(OFF)
    time.sleep(0.40)
    
    for colarr in seq:
        fld.set_each_RGB(colarr)
        time.sleep(0.3)
        fld.all_same_RGB(OFF)
        time.sleep(0.1)



    
        
    
    

                