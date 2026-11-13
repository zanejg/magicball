import RPi.GPIO as GPIO
import time
from pymemcache.client import base
memcacheclient = base.Client(('localhost', 11211))

channels = [
{
    "RED" : 0,
    "GREEN" : 1,
    "BLUE" : 2,
},
{
    "RED" : 5,
    "GREEN" : 4,
    "BLUE" : 3,
},
{
    "RED" : 8,
    "GREEN" : 7,
    "BLUE" : 6,
},
{
    "RED" : 11,
    "GREEN" : 10,
    "BLUE" : 9,
},
]

ROTARY_LPIN = 15
ROTARY_RPIN = 18
ROTARY_SWPIN = 14


GPIO.setmode(GPIO.BCM)
# but we will have to detect button presses to escape out
BLUE_BUTTON_PIN = 27
WHITE_BUTTON_PIN = 22
GPIO.setup(BLUE_BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(WHITE_BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)


def check_for_pressed_buttons():
    """
    Check for whether the red or blue button has been pressed and return 
    the colour if it has
    """
    if GPIO.input(WHITE_BUTTON_PIN) == GPIO.HIGH:
        memcacheclient.set("lamp_control", "ball")
        while GPIO.input(WHITE_BUTTON_PIN) == GPIO.HIGH:
            time.sleep(0.1)
        return "WHITE"
    elif GPIO.input(BLUE_BUTTON_PIN) == GPIO.HIGH:
        memcacheclient.set("lamp_control", "ball")
        while GPIO.input(BLUE_BUTTON_PIN) == GPIO.HIGH:
            time.sleep(0.1)
        return "BLUE"
    else:
        return None


def rota_switch_pressed():
    global lighted_state
    print("pressed")
    memcacheclient.set("lamp_control", "ball")
    while rotasw.get_switch() == "pressed":
        time.sleep(0.1)
    lighted_state = not(lighted_state)
    print("released")

def button_pressed(button_pin):
    memcacheclient.set("lamp_control", "ball")
    while GPIO.input(button_pin) == GPIO.HIGH:
        time.sleep(0.1)
    