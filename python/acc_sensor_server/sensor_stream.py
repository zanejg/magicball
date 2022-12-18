import datetime as dt
import time
import json
from pymemcache.client import base

from accel import accelerometer
from gyro_event_finder import gyro_event_finder
from accel_event_finder import accel_event_finder

acc = accelerometer()
client = base.Client(('localhost', 11211))

start_time = dt.datetime.now()

runtime = dt.timedelta(seconds=2)
the_time = dt.datetime.now()
cc=0
evcc = 0
evacc = 0
MAX_LEN = 12000

EVENT_MAX_LEN = 120





###########################################################################

#########################################################################







#threshhold = 0.5
gyro_threshhold = 25000
accel_threshhold = 25000
time_threshhold = 0.3
# self.state = "flat"
# self.state_set ={"flat","rising","rising_edge","lowering","lowering_edge"}
# event_set = {"rising_edge","lowering_edge","peaked","troughed","hi_pulse","lo_pulse"}
# last_val = 0


gyro_event_handlers = {dimension:gyro_event_finder(gyro_threshhold, time_threshhold) for dimension in ['x','y','z']}
accel_event_handlers = {dimension:accel_event_finder(accel_threshhold) for dimension in ['x','y','z']}

last_event_time = dt.datetime.now()

    
while(True):
    the_data = acc.get_accel() # get the accel data
    gyro_data = acc.get_gyro() # the gyro data
    the_time = dt.datetime.now() # get the time
    #the_data['time'] = the_time.strftime("%M-%S-%f") 
    # attach the time to the data
    the_data['time'] = the_time.isoformat(timespec='microseconds')
    gyro_data['time'] = the_time.isoformat(timespec='microseconds')
    client.set(f"{cc}",json.dumps(the_data) ) # write the accel data to memcached
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
    
    
    # now look for any gyro events that might have happened on all axes
    [gyro_event_handlers[dimension].get_subevents(gyro_data[dimension],
                                      gyro_data['time']) 
        for dimension in ['x','y','z']]
    # now look for any accel events that might have happened on all axes
    [accel_event_handlers[dimension].get_events(the_data[dimension],
                                      the_data['time']) 
        for dimension in ['x','y','z']]
    
    
    this_last_event_time = last_event_time
    last_acc_event_time = last_event_time

    this_last_acc_event_time = last_event_time
    
    for dimension in ['x','y','z']:
        new_gyro_events = []
        new_accel_events = []
        #if len(gyro_event_handlers[dimension].events) > len(events[dimension]):
        # only want the events since the last time
        # try:
        if gyro_event_handlers[dimension].events[-1]['time'] > last_event_time:
            # diff_len = len(gyro_event_handlers[dimension].events) - len(events[dimension])
            # new_gyro_events = gyro_event_handlers[dimension].events[-(diff_len):]
            new_gyro_events = [ev for ev in gyro_event_handlers[dimension].events
                        if ev['time'] > last_event_time]
            for ne in new_gyro_events:
                #print(f"{dimension} ||--|| {ne['event']} |-|gyro= {gyro_data[dimension]}")
                this_last_event_time = ne['time']
        
                #ne['time']=ne['time'].isoformat(timespec='microseconds')
                # write the event data to memcached
                client.set(f"ev{evcc}",json.dumps({'event':ne['event'],
                                                   'dimension':dimension,
                                                   'time':ne['time'].isoformat(timespec='microseconds')} )
                )
                            
                # write the current event counter to memcached
                client.set("current_event", f"{evcc}") 
                # try to keep the memory usage down
                if evcc > EVENT_MAX_LEN:
                    client.delete(f"ev{evcc - EVENT_MAX_LEN}")
                evcc+=1

        if accel_event_handlers[dimension].events[-1]['time'] > last_acc_event_time:
            new_accel_events = [ev for ev in accel_event_handlers[dimension].events
                        if ev['time'] > last_acc_event_time]
            
            for ne in new_accel_events:
                this_last_acc_event_time = ne['time']
                client.set(f"aev{evacc}",json.dumps({'event':ne['event'],
                                                   'dimension':dimension,
                                                   'value':ne['value'],
                                                   'time':ne['time'].isoformat(timespec='microseconds')} )
                )
                # write the current event counter to memcached
                client.set("current_acc_event", f"aev{evacc}")
                # try to keep the memory usage down
                if evacc > EVENT_MAX_LEN:
                    client.delete(f"aev{evacc - EVENT_MAX_LEN}")
                evacc+=1


        # except TypeError:
        #     import pdb;pdb.set_trace()        
            
        last_event_time = this_last_event_time
        last_acc_event_time = this_last_acc_event_time
    
    
        
        
        
                    
    time.sleep(0.001)
    
    
    
    




    
        
    



