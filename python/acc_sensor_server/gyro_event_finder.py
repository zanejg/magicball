import datetime as dt
import time


class event_finder():
    def trim_events(self):
        """
        We need to ensure that as the events rack up they
        will not get too huge
        """
        # we will just hard code the max size
        max_size = 200
        over_len = len(self.events) - max_size
        if over_len > 0:
            # lop off the events at the beginning
            self.events = self.events[over_len:]
        # and the same for the subevents
        sub_max_size = 300
        subover_len = len(self.events) - sub_max_size
        if subover_len > 0:
            # lop off the events at the beginning
            self.events = self.events[subover_len:]
        


class gyro_event_finder(event_finder):
    def __init__(self,threshhold, time_threshhold_secs=0.2 ):
        """
        threshold: is the value threshhold that signals we have the 
        start of a twist.
        time_threshhold_secs: is how long the twist has to last 
        before it is logged.
        """

        # stash the time threshhold
        self.time_threshhold_secs = time_threshhold_secs
        # the list of all the past events
        self.subevents = []
        # the current state for following subevents for pulses
        self.state = "flat"
        # what the previous value was
        self.last_val = 0
        # the threshhold to trigger pulses on
        self.threshhold = threshhold
        # what direction our signal is running in rising/lowering
        self.dirmov = ""
        # keep track of pulses to look for cycles
        self.pulse_state = ""
        # major events esp cycles
        self.events = [{'time':dt.datetime.strptime("1 January, 2000", "%d %B, %Y")}]
    
        
        
    def get_events(self,pulse_event):
        """
        We have just achieved a pulse event so now we look 
        to see if we have a long enough pulse
        """
        # make sure there is a long enough stream to have a cycle
        if len(self.subevents) < 2:
            return
        
        # first we need to see how long the pulse took to form
        # the start of the pulse should be at -3 "rising(/lowering)_edge"
        start = self.subevents[-2]
        pulse_time = pulse_event['time'] - start['time']

        print(f"pulse_time={pulse_time}")
        print(f"event={pulse_event['event']}")

        if pulse_time.total_seconds() > self.time_threshhold_secs:
            if pulse_event['event'] == "fwd_twist_end":
                event = "fwd_twist"
            elif pulse_event['event'] == "rev_twist_end":
                event = "rev_twist"

            self.events.append({"event":event,
                                 "time":pulse_event['time']})
        

        self.trim_events()
            
        

    def get_subevents(self,this_val,this_time):
        
        # get the direction of movement
        if this_val > self.last_val:
            self.dirmov = "rising"
            
        if this_val < self.last_val:
            self.dirmov  = "lowering"

        # look for whther we have crossed the threshold in the fwd direction
        if (self.dirmov == "rising" and 
            this_val > self.threshhold and 
            self.state == "flat"):
            self.subevents.append({"event":"rising_edge",
                        "time":this_time})
            self.state = "rising_edge"
            self.subevents.append({"event":"fwd_twist_start",
                        "time":this_time})
        # look for whether we have crossed the negative threshold
        elif (self.dirmov == "lowering" and 
              this_val < (self.threshhold * -1) and
              self.state == "flat"):
            self.subevents.append({"event":"lowering_edge",
                        "time":this_time})
            self.state = "lowering_edge"
            self.subevents.append({"event":"rev_twist_start",
                        "time":this_time})


        # look for end of twist crossing half the threshold going down
        elif (self.dirmov=="lowering" and self.state == "rising_edge" and
                this_val < self.threshhold/2):
            fwd_end_event = {"event":"fwd_twist_end",
                              "time":this_time}
            self.subevents.append(fwd_end_event)
            self.get_events(fwd_end_event)
            self.state = "flat"

        elif (self.dirmov=="rising" and self.state == "lowering_edge" and
                this_val > (-1 * self.threshhold/2)):
            rev_end_event = {"event":"rev_twist_end",
                              "time":this_time}
            self.subevents.append(rev_end_event)
            self.get_events(rev_end_event)
            self.state = "flat"
            

        self.last_val = this_val
        
