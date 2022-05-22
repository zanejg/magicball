import datetime as dt
from accel import accelerometer
from pymemcache.client import base
import json

acc = accelerometer()
client = base.Client(('localhost', 11211))

start_time = dt.datetime.now()

runtime = dt.timedelta(seconds=2)
the_time = dt.datetime.now()
cc=0
MAX_LEN = 12000
while(True):
    the_data = acc.get_accel() # get the accel data
    gyro_data = acc.get_gyro() # the gyro data
    the_time = dt.datetime.now() # get the time
    the_data['time'] = the_time.strftime("%M-%S-%f") # attach the time to the data
    client.set(f"{cc}",json.dumps(the_data) ) # write the data to memcached
    client.set(f"g{cc}",json.dumps(the_data) ) # write the gyro data to memcached
    client.set("current", f"{cc}") # write the current counter to memcached
    # try to keep the memory usage down
    if cc > MAX_LEN:
        client.delete(f"{cc - MAX_LEN}")
        client.delete(f"g{cc - MAX_LEN}")
    cc+=1





