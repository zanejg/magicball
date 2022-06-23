import datetime as dt
import time


class event_finder():
    def __init__(self,threshhold):
        # the list of all the past events
        self.subevents = []
        # the current state for following subevents for pulses
        self.state = "flat"
        # what the previous value was
        self.last_val = 0
        # the threshhold to trigger pulses on
        self.threshhold = threshhold
        # what direction our signal is running in rising/lowering
        self.dirmov = None
        # keep track of pulses to look for cycles
        self.pulse_state = None
        # major events esp cycles
        self.events = []
        
    def get_events(self,pulse_event):
        """
        We have just achieved a pulse event so now we look 
        to see if we have a cycle
        """
        # make sure there is a long enough stream to have a cycle
        if len(self.subevents) < 4:
            return
        
        # first we need to see how long the pulse took to form
        # the start of the pulse should be at -3 "rising(/lowering)_edge"
        start = self.subevents[-3]
        half_cycle_time = pulse_event['time'] - start['time']
        
        previous_candidate = self.subevents[-4]
        # to ensure that we haven't already counted it in previous cycle
        if len(self.events) > 0:
            prev_event = self.events[-1]
        else:
            prev_event={'time':None}
        if prev_event['time'] != previous_candidate['time']:
            #import pdb;pdb.set_trace()
            if ((pulse_event['event'] == "hi_pulse" and
                previous_candidate['event'] == "lo_pulse") or 
                (pulse_event['event'] == "lo_pulse" and
                previous_candidate['event'] == "hi_pulse")):
                    # then we have a possible cycle but did it happen 
                    # at a valid time before? half_cycle_time/4
                    if start['time'] - previous_candidate['time'] <= half_cycle_time/4:
                        this_event = "fwd_cycle" \
                            if pulse_event['event'] == "lo_pulse" \
                                else "rev_cycle"
                        self.events.append({"event":this_event,
                                            "time":pulse_event['time']})
            
        

    def get_subevents(self,this_val,this_time):
        
        if this_val > self.last_val:
            self.dirmov = "rising"
        if this_val < self.last_val:
            self.dirmov  = "lowering"

        if (self.dirmov == "rising" and 
            this_val > self.threshhold and 
            self.state == "flat"):
            self.subevents.append({"event":"rising_edge",
                        "time":this_time})
            self.state = "rising_edge"
        elif (self.dirmov == "lowering" and 
              this_val < (self.threshhold * -1) and
              self.state == "flat"):
            self.subevents.append({"event":"lowering_edge",
                        "time":this_time})
            self.state = "lowering_edge"

        elif self.dirmov=="lowering" and self.state == "rising_edge":
            self.subevents.append({"event":"peaked",
                        "time":this_time})
            self.state = "peaked"

        elif self.dirmov=="rising" and self.state == "lowering_edge":
            self.subevents.append({"event":"troughed",
                        "time":this_time})
            self.state = "troughed"

        elif (self.dirmov=="lowering" and 
              self.state == "peaked" and 
              this_val < self.threshhold/2):
            hipulse_event = {"event":"hi_pulse",
                        "time":this_time}
            self.subevents.append(hipulse_event)
            self.get_events(hipulse_event)
            self.state = "flat"

        elif (self.dirmov=="rising" and 
              self.state == "troughed" and 
              this_val > (self.threshhold/2 *-1)):
            lopulse_event = {"event":"lo_pulse",
                        "time":this_time}
            self.subevents.append(lopulse_event)
            self.get_events(lopulse_event)
            self.state = "flat"

        self.last_val = this_val
