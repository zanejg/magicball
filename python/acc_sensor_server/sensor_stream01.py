import datetime as dt
import time
import json
from pymemcache.client import base

from accel import accelerometer
from event_finder import event_finder


acc = accelerometer()
client = base.Client(('localhost', 11211))

start_time = dt.datetime.now()

runtime = dt.timedelta(seconds=2)
the_time = dt.datetime.now()
cc=0
evcc = 0
MAX_LEN = 12000

EVENT_MAX_LEN = 120





###########################################################################

#########################################################################







#threshhold = 0.5
threshhold = 15000
# self.state = "flat"
# self.state_set ={"flat","rising","rising_edge","lowering","lowering_edge"}
# event_set = {"rising_edge","lowering_edge","peaked","troughed","hi_pulse","lo_pulse"}
# last_val = 0


event_handlers = {dm:event_finder(threshhold) for dm in ['x','y','z']}

events = {dm:[] for dm in ['x','y','z']}

last_event_time = dt.datetime.now()

    
while(True):
    the_data = acc.get_accel() # get the accel data
    gyro_data = acc.get_gyro() # the gyro data
    the_time = dt.datetime.now() # get the time
    #the_data['time'] = the_time.strftime("%M-%S-%f") 
    # attach the time to the data
    the_data['time'] = the_time.isoformat(timespec='microseconds')
    gyro_data['time'] = the_time.isoformat(timespec='microseconds')
    client.set(f"{cc}",json.dumps(the_data) ) # write the data to memcached
    client.set(f"g{cc}",json.dumps(gyro_data) ) # write the gyro data to memcached
    client.set("current", f"{cc}") # write the current counter to memcached
    # try to keep the memory usage down
    if cc > MAX_LEN:
        client.delete(f"{cc - MAX_LEN}")
        client.delete(f"g{cc - MAX_LEN}")
    cc+=1
    # set the time back to something json doesn't need
    # for easy processing
    the_data['time'] = the_time
    gyro_data['time'] = the_time
    
    # if cc> 10:
    #     import pdb;pdb.set_trace()
    
    
    # now look for any events that might have happened on all axes
    [event_handlers[dm].get_subevents(gyro_data[dm],
                                      gyro_data['time']) 
     for dm in ['x','y','z']]
    
    
    
    this_last_event_time = last_event_time
    for dm in ['x','y','z']:
        new_events = []
        #if len(event_handlers[dm].events) > len(events[dm]):
        # only want the events since the last time
        # try:
        if event_handlers[dm].events[-1]['time'] > last_event_time:
            # diff_len = len(event_handlers[dm].events) - len(events[dm])
            # new_events = event_handlers[dm].events[-(diff_len):]
            new_events = [ev for ev in event_handlers[dm].events
                        if ev['time'] > last_event_time]
            for ne in new_events:
                print(f"{dm} ||--|| {ne['event']} |-|gyro= {gyro_data[dm]}")
                this_last_event_time = ne['time']
        
                #ne['time']=ne['time'].isoformat(timespec='microseconds')
                # write the event data to memcached
                client.set(f"ev{evcc}",json.dumps({'event':ne['event'],
                                                   'dimension':dm,
                                                   'time':ne['time'].isoformat(timespec='microseconds')} )
                )
                            
                # write the current event counter to memcached
                client.set("current_event", f"{evcc}") 
                # try to keep the memory usage down
                if evcc > EVENT_MAX_LEN:
                    client.delete(f"{evcc - EVENT_MAX_LEN}")
                evcc+=1
        # except TypeError:
        #     import pdb;pdb.set_trace()        
            
        last_event_time = this_last_event_time
        events[dm] = event_handlers[dm].events
    
    
        
        
        
                    
    time.sleep(0.001)
    
    
    
    




    
        
    



