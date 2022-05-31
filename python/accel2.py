#!/usr/bin/python
import smbus
import math
import time
import pdb
 
# Register
power_mgmt_1 = 0x6b
power_mgmt_2 = 0x6c
 
def read_byte(reg):
    return bus.read_byte_data(address, reg)
 
def read_word(reg):
    h = bus.read_byte_data(address, reg)
    l = bus.read_byte_data(address, reg+1)
    value = (h << 8) + l
    return value
 
def read_word_2c(reg):
    val = read_word(reg)
    pdb.set_trace()
    if (val >= 0x8000):
        return -((65535 - val) + 1)
    else:
        return val
 
def dist(a,b):
    return math.sqrt((a*a)+(b*b))
 
def get_y_rotation(x,y,z):
    radians = math.atan2(x, dist(y,z))
    return -math.degrees(radians)
 
def get_x_rotation(x,y,z):
    radians = math.atan2(y, dist(x,z))
    return math.degrees(radians)

def get_z_rotation(x,y,z):
    radians = math.atan2(z, dist(x,y))
    return math.degrees(radians)
 
bus = smbus.SMBus(1) # bus = smbus.SMBus(0) fuer Revision 1
address = 0x68       # via i2cdetect
 
# Activate to be able to address the module
bus.write_byte_data(address, power_mgmt_1, 0)


while(True):

    acceleration_xout = read_word_2c(0x3b)
    acceleration_yout = read_word_2c(0x3d)
    acceleration_zout = read_word_2c(0x3f)
    
    acceleration_xout_scaled = acceleration_xout / 16384.0
    acceleration_yout_scaled = acceleration_yout / 16384.0
    acceleration_zout_scaled = acceleration_zout / 16384.0
    
    
    data_str = "AccX:{accx} AccY:{accy} AccZ:{accz} || ScAccX:{saccx:.4f} ScAccY:{saccy:.4f} ScAccZ:{saccz:.4f} || X-Rot:{xrot:.4f} Y-Rot:{yrot:.4f}".format(
        accx=acceleration_xout,
        accy=acceleration_yout,
        accz=acceleration_zout,
        saccx=acceleration_xout_scaled,
        saccy=acceleration_yout_scaled,
        saccz=acceleration_zout_scaled,
        xrot=get_x_rotation(acceleration_xout_scaled, acceleration_yout_scaled, acceleration_zout_scaled),
        yrot=get_y_rotation(acceleration_xout_scaled, acceleration_yout_scaled, acceleration_zout_scaled),
        zrot=get_z_rotation(acceleration_xout_scaled, acceleration_yout_scaled, acceleration_zout_scaled)
    )
    
    print(data_str)
    time.sleep(0.5)
    
    print ("acceleration_xout: ", ("%6d" % acceleration_xout), " scaled: ", acceleration_xout_scaled)
    print ("acceleration_yout: ", ("%6d" % acceleration_yout), " scaled: ", acceleration_yout_scaled)
    print ("acceleration_zout: ", ("%6d" % acceleration_zout), " scaled: ", acceleration_zout_scaled)
    
    print ("X Rotation: " , get_x_rotation(acceleration_xout_scaled, acceleration_yout_scaled, acceleration_zout_scaled))
    print ("Y Rotation: " , get_y_rotation(acceleration_xout_scaled, acceleration_yout_scaled, acceleration_zout_scaled))
    print ("Z Rotation: " , get_z_rotation(acceleration_xout_scaled, acceleration_yout_scaled, acceleration_zout_scaled))
