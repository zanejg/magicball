# The modes that will only display pretty lighting sequences
# without any movement detection

import sys
import time
import random
import math
import numpy as np
import RPi.GPIO as GPIO

import LED_control as LC
from hardware import channels


GPIO.setmode(GPIO.BCM)
# but we will have to detect button presses to escape out
BLUE_BUTTON_PIN = 27
WHITE_BUTTON_PIN = 22
GPIO.setup(BLUE_BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(WHITE_BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)


def check_for_pressed_buttons():
    if GPIO.input(WHITE_BUTTON_PIN) == GPIO.HIGH:
        while GPIO.input(WHITE_BUTTON_PIN) == GPIO.HIGH:
            time.sleep(0.1)
        return "WHITE"
    elif GPIO.input(BLUE_BUTTON_PIN) == GPIO.HIGH:
        while GPIO.input(BLUE_BUTTON_PIN) == GPIO.HIGH:
            time.sleep(0.1)
        return "BLUE"
    else:
        return None


######################################################################################
####  display sequence production         ###############
#############################################################################
def get_inv_parabola_seq(numsteps):
    """
    Providing a kind of throb
    """
    max=1024.0
    maxrt = math.sqrt(max) * 0.95
    #numsteps = 500
    stepsize = (2 * maxrt) / numsteps
    xseq = [x for x in np.arange(-maxrt,maxrt,stepsize)]
    yseq = [int(((x * x) * -1) + max)  for x in xseq]

    return yseq


def get_sparkle_seq(ht,numsteps):
    """
    Sparkling is a bit more complicated
    We will go for a very steep attack and decay but with a short
    time at the top of the given height.
    ht: is the maximum of the fraction of 100% pulse as number between 0 and 1.
    """
    max=1024.0
    
    # we will divide the sequence into 3 attack, max and decay
    third = int(numsteps/3);
    max_val = max * ht;
    incline_step = max_val/third;
    # rise to max
    yseq = [int(y) for y in np.arange(0,max_val,incline_step)]
    #stay on max
    yseq+=[int(max_val) for y in range(0,third)]
    # decay down to zero
    yseq+=[int(y) for y in np.arange(max_val,0,-1 * incline_step)]

    return yseq


colours = [
    "FFFFFF",
    "FF0000",
    "00FF00",
    "0000FF",
    "FFFF00",
    "FF00FF",
    "00FFFF",
    "FF00B3",
    "7700FF",
    "006FFF",
    "00CDFF",
    "80FF00",
    "FFAB00",
    "FF5500",
]

# only want the RGB to level conversion
LED_driver = LC.LED_driver(channels)

def get_slow_seq_between_RGBs(first,second, num_steps):
    """
    Will return array num_steps long of RGB level dicts
    """
    global LED_driver

    first_levels = LED_driver.rgb_to_levels(first)
    second_levels = LED_driver.rgb_to_levels(second)
    fade_arrays = {}
    for col in ['RED','GREEN', 'BLUE']:
        step = ((first_levels[col]['level'] - second_levels[col]['level'])
                    /num_steps) * -1
        #import pdb;pdb.set_trace()
        # if there is no change then we just produce an array of the same level
        # also avoiding div by zero
        if step != 0:
            fade_arrays[col] = [lev for lev in np.arange(first_levels[col]['level'],
                                                    second_levels[col]['level'],
                                                    step)]
        else:
            fade_arrays[col] = [first_levels[col]['level'] 
                                for lev in range(0,num_steps)]
    ret = []
    for i in range(0,num_steps):
        ret.append({
              'RED':fade_arrays['RED'][i],
            'GREEN':fade_arrays['GREEN'][i],
             'BLUE':fade_arrays['BLUE'][i],
        })

    return ret

####################################################################################
####              DISPLAY LOOPS         ###########################
##########################################################################
fld = LC.four_LED_driver(channels)
button_pressed = None
display_mode = 0

def main_display_loop():
    global button_pressed
    global display_mode

    ## array of funcs
    modes = [
        pulse,
        sparkle,
        slow,
        rand,
    ]

    while(True):
        # run the current display mode
        modes[display_mode]()
        if button_pressed == "WHITE":
            return
        if button_pressed == "BLUE":
            button_pressed = None
            if display_mode < (len(modes)-1):
                display_mode+=1 
            else:
                display_mode = 0
        
        




def pulse():
    global button_pressed
    
    numsteps = 100

    throbseq = get_inv_parabola_seq(numsteps)

    while(True):
        col = colours[random.randrange(0,(len(colours) -1)) ]
        seqdata = LC.get_colour_dimming_sequence(col,1024)
        seq = seqdata['sequences']

        for throbposi in throbseq:
            fld.all_same_float({
                "RED":seq['RED'][throbposi],
                "GREEN":seq['GREEN'][throbposi],
                "BLUE":seq['BLUE'][throbposi],
            })
            button_pressed = check_for_pressed_buttons()
            if button_pressed is not None:
                return
            
        


def sparkle():
    global button_pressed
    numsteps = 12

    while(True):
        # create a dict of sequences keyed by LED num
        all_dim_seqs = {}
        all_sparkle_seqs = {}
        for i in range(0,4):
            all_sparkle_seqs[i] = get_sparkle_seq(random.uniform(0.20,1.0),numsteps)
            col = colours[random.randrange(0,(len(colours) -1)) ]
            seqdata = LC.get_colour_dimming_sequence(col,1024)
            seq = seqdata['sequences']
            all_dim_seqs[i] = seq



        # iterate thru sequence creating the data for setting 
        # each LED independently
        for throbposi in range(0,numsteps):
            these_levels = []
            for this_led in range(0,4):
                this_led_seq = all_dim_seqs[this_led]
                this_sparkle_seq = all_sparkle_seqs[this_led]
                these_levels.append({
                    "RED":this_led_seq['RED'][this_sparkle_seq[throbposi]],
                    "GREEN":this_led_seq['GREEN'][this_sparkle_seq[throbposi]],
                    "BLUE":this_led_seq['BLUE'][this_sparkle_seq[throbposi]],
                })

            #import pdb;pdb.set_trace()
            fld.set_each(these_levels)
            
            button_pressed = check_for_pressed_buttons()
            if button_pressed is not None:
                return


def slow():
    global button_pressed
    # how many steps betwen colours
    num_steps = 100
    # choose a random colour and light the ball with it
    first_colour = colours[random.randrange(0,len(colours)-1)]
    fld.all_same_RGB(first_colour)
    # choose a random second colour
    second_colour = colours[random.randrange(0,len(colours)-1)]
    while(True):    
        # get the sequence that will fade to that colour
        seq = get_slow_seq_between_RGBs(first_colour,second_colour,num_steps)
        #import pdb;pdb.set_trace()
        # now step thru seq setting the colours as we go
        for this_col in seq:
            fld.all_same_float(this_col)
            button_pressed = check_for_pressed_buttons()
            if button_pressed is not None:
                return

        # we are now at the end of the transition so we set 1st to 2nd
        first_colour = second_colour
        # and choose a new second
        second_colour = colours[random.randrange(0,len(colours)-1)]


def rand():
    global button_pressed

    while(True):
        the_leds = []
        for led in range(0,4):
            ledcol = {}
            for col in ["RED","GREEN","BLUE"]:
                ledcol[col] = random.randrange(0,255)/255.0
            the_leds.append(ledcol)
        fld.set_each(the_leds)
        
        button_pressed = check_for_pressed_buttons()
        if button_pressed is not None:
            return

        time.sleep(0.2)