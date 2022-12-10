#!/usr/bin/python
# Sample code to demonstrate Encoder class.  Prints the value every 5 seconds, and also whenever it changes.

import time
import RPi.GPIO as GPIO

BUTTON_PIN = 14

GPIO.setmode(GPIO.BCM)
GPIO.setup(BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

BLUE_BUTTON_PIN = 27
WHITE_BUTTON_PIN = 22
GPIO.setup(BLUE_BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(WHITE_BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

cc=0
try:
    while True:
        time.sleep(0.1)
        if GPIO.input(BUTTON_PIN) == GPIO.LOW:
            print("Rotary Button was pushed!")

        if GPIO.input(BLUE_BUTTON_PIN) == GPIO.HIGH:
            print("Blue Button was pushed!")
        if GPIO.input(WHITE_BUTTON_PIN) == GPIO.HIGH:
            print("White Button was pushed!")

        
except Exception:
    pass





GPIO.cleanup()
