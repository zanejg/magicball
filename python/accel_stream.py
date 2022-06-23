from pymemcache.client import base
import json


class AccelerometerStream(){
    def __init__(self):
        self.memclient = base.Client(("localhost", 11211))
        



    def get_stream_data(num,prefix = ""):
        """
        Given num number of entries return num entries from
        the memcached cache.
        Prefix is added for gyro data instead of plain accel data
        """
        current_str = self.memclient.get("current")
        current = (int(current_str))
        ret = []
        for i in range(current-num,current):
            ret.append(json.loads(self.memclient.get(f"{prefix}{i}")))
        return ret
        