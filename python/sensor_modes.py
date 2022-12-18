import time
import datetime as dt
import json
from pymemcache.client import base

import hardware as hw
from rotary import RotaryAndSwitch

WHITE = "FFFFFF"
OFF = "000000"
RED = "FF0000"
GREEN = "00FF00"
BLUE = "0000FF"

client = base.Client(('localhost', 11211))

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



rotasw = None
lighted_state = False

def main_sensor_loop(leds,rotasw_parm):
    global lighted_state
    global rotasw
    global button_pressed


    rotasw = rotasw_parm
    display_mode = 0
    # rotasw = RotaryAndSwitch(hw.ROTARY_LPIN,
    #                      hw.ROTARY_RPIN,
    #                      hw.ROTARY_SWPIN,
    #                      leds.LEDs)
    sensor_loops=[
        ball_twist_mode,
        ball_bump_mode,    
    ]
    while True:
        # run the current display mode
        sensor_loops[display_mode](leds)
        if button_pressed == "WHITE":
            return
        if button_pressed == "BLUE":
            button_pressed = None
            if display_mode < (len(sensor_loops)-1):
                display_mode+=1 
            else:
                display_mode = 0




def mainvalueChanged(self,value, direction,LEDs):
    if direction == "R":
        [this_led.brighten(4) for this_led in LEDs]
    elif direction == "L":
        [this_led.dim(4) for this_led in LEDs]



def ball_twist_mode(leds):
    """
        Event loop mode where we will be looking for switch presses
        and ball twists and rotary changes to change the colour etc
    """
    global lighted_state
    global button_pressed

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
            hw.rota_switch_pressed()

        # if hw.GPIO.input(hw.WHITE_BUTTON_PIN) == hw.GPIO.HIGH:
        #     print("White Button was pushed!")
        #     button_pressed(hw.WHITE_BUTTON_PIN)
        #     # to escape this loop and flashes all white beforehand
        #     leds.all_same_RGB("FFFFFF")
        #     time.sleep(0.3)
        #     leds.all_same_RGB("000000")
        #     return
        button_pressed = hw.check_for_pressed_buttons()
        if button_pressed is not None:
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
            #print(f"event detected:|{current_event}|")
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
                    print(f"New event detected:{ev['event']}|time:{ev['time']}|dim:{ev['dimension']}")
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
        


def ball_bump_mode(leds):
    """
    An event loop where the ball will light according to 
    how the ball is accelerated i.e. how it is bumped at moved quickly
    """
    global lighted_state
    global button_pressed

    # each dimension is the pure colour in the positive and a mix of 
    # the others in the negative
    dim2col = {"x":{"+":"FF0000", # RED
                    "-":"00FFFF"},
               "y":{"+":"00FF00", # GREEN
                    "-":"FF00FF"},
               "z":{"+":"0000FF", # BLUE
                    "-":"FFFF00"},}
    
    last_event_time = dt.datetime.now()
    # light sequence to show mode
    for _,colset in dim2col.items():
        leds.all_same_RGB(colset['+'])
        time.sleep(0.2)
        leds.all_same_RGB(colset['-'])
        time.sleep(0.02)
        
    leds.all_same_RGB(OFF)
    print("@@@ bump mode @@@@")
    last_current_event_num = 0
    while(True):
        # if hw.GPIO.input(hw.WHITE_BUTTON_PIN) == hw.GPIO.HIGH:
        #     print("White Button was pushed!")
        #     button_pressed(hw.WHITE_BUTTON_PIN)
        #     # to escape this loop and flashes all white beforehand
        #     leds.all_same_RGB("FFFFFF")
        #     time.sleep(0.3)
        #     leds.all_same_RGB("000000")
        #     return
        button_pressed = hw.check_for_pressed_buttons()
        if button_pressed is not None:
            return

        
        # pull out the last 10 events from memcached
        #import pdb;pdb.set_trace()
        current_event = client.get("current_acc_event")
        # ignoring the "aev" get the number of the current event
        current_event_num = int(current_event[3:])

        if current_event and last_current_event_num < current_event_num:
            print(f"accel event detected:|{current_event}|")
            
            # we need to handle things at the start when there are 
            # less than ten events
            ten_start = 0 if current_event_num < 10 \
                            else current_event_num-10
            last_ten = []
            
            # now go and collect them from memcached 
            # and put them into an array:last_ten
            for cc in range(ten_start,current_event_num+1):
                last_ten.append(client.get(f"aev{cc}"))
            
            # set a new event flag to false
            some_new_events = False
            # work thru the last ten events
            for evstr in last_ten:
                ev = json.loads(evstr)
                this_time = dt.datetime.fromisoformat(ev['time'])

                # look for whether any have happened since 
                # the last time we were here
                if this_time > last_event_time:
                    # if we're here then we haven't processed the event yet
                    # so we collect the events data
                    print(f"New event detected:{ev['event']}|value:{ev['value']}|time:{ev['time']}|dim:{ev['dimension']}")
                    dm = ev['dimension']
                    if ev['event'] == "HI_SPIKE":
                        accel_dir = "+"  
                    elif ev['event'] == "LO_SPIKE":
                            accel_dir = "-"
                    # then set all of the LEDs to the salient colour
                    leds.all_same_RGB(dim2col[dm][accel_dir])
                    # set the new event flag
                    some_new_events = True

            # only turn off the LEDs if we have come around again
            # with no events
            if not some_new_events:
                leds.all_same_RGB("000000")
            
            else:
                # set things up for the next round
                last_event = json.loads(last_ten[-1])
                last_event_time = dt.datetime.fromisoformat(last_event['time'])
                last_current_event_num = current_event_num




        

