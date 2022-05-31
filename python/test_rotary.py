#!/usr/bin/python
# Sample code to demonstrate Encoder class.  Prints the value every 5 seconds, and also whenever it changes.

import time
import RPi.GPIO as GPIO
from encoder import Encoder

def valueChanged(value, direction):
    print("* New value: {}, Direction: {}".format(value, direction))

BUTTON_PIN = 14

GPIO.setmode(GPIO.BCM)
GPIO.setup(BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

#e1 = Encoder(26, 19, valueChanged)
e1 = Encoder(15, 18, valueChanged)

cc=0
try:
    while True:
        time.sleep(1)
        if GPIO.input(BUTTON_PIN) == GPIO.LOW:
            print("Button was pushed!")
        cc+=1
        if cc==5:
            print("Value is {}".format(e1.getValue()))
            cc=0
        
except Exception:
    pass





GPIO.cleanup()
