import datetime as dt
import time

from gyro_event_finder import event_finder

class accel_event_finder(event_finder):
    def __init__(self,threshhold):
        """
        Look for accelerometer events.
        Apart from the gravity measurements these tend to be spiky.
        G seems to be about 15k-18k units
        """
        # the threshhold to trigger events on
        self.threshhold = threshhold

        self.events = [{'time':dt.datetime.strptime("1 January, 2000", "%d %B, %Y")}]

    def get_events(self,this_val,this_time ):
        """
        Receive a measurement from the accelerometer
        """

        # just ignore it if it is below the threshhold
        if abs(this_val) < abs(self.threshhold):
            return
        
        # if we are here then we have a value over the threshhold
        # and we want to register an event. 
        # we will assume a spike
        if this_val > 0:
            event = "HI_SPIKE"
        else:
            event = "LO_SPIKE"
        
        the_event = {"event":event,
                             "time":this_time,
                             "value":this_val}
        print(f"event:|{the_event['event']}|value:{this_val}| time:|{the_event['time']}|")

        self.events.append(the_event)

        self.trim_events()





        
        

    
