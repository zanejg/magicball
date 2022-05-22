import datetime as dt
from accel import accelerometer
from pymemcache.client import base
import json

time_stamps = []
acc = accelerometer()
client = base.Client(('localhost', 11211))

start_time = dt.datetime.now()

runtime = dt.timedelta(seconds=2)
the_time = dt.datetime.now()
cc=0
while((the_time - start_time) < runtime):
    the_data = acc.get_accel()
    the_time = dt.datetime.now()
    time_stamps.append(the_time)
    the_data['time'] = the_time.strftime("%M-%S-%f")
    client.set(f"{cc}",json.dumps(the_data) )
    cc+=1
    
print(f"there were {len(time_stamps)} samples taken") 


