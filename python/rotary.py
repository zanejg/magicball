import time
import RPi.GPIO as GPIO
import sys

from encoder import Encoder
from hardware import channels



class RotaryAndSwitch():
    def __init__(self,lpin,rpin,swpin,leds):
        
        GPIO.setmode(GPIO.BCM)
        self.rotary = Encoder(lpin, rpin, self.valueChanged)
        self.switch_pin = swpin
        self.leds = leds
        
        GPIO.setup(swpin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
        
    
    def get_switch(self):
        if GPIO.input(self.switch_pin) == GPIO.LOW:
            return("pressed")
        else:
            return("released")


    def valueChanged(self, value, direction):
        """
        This really needs to be implemented/overloaded
        """
        print("* New value: {}, Direction: {}".format(value, direction))
        
        if direction == "R":
            [this_led.brighten(2) for this_led in self.leds]
        elif direction == "L":
            [this_led.dim(2) for this_led in self.leds]
    
#############################################################
# BUTTON stuff



