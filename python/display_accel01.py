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
    #pdb.set_trace()
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
    
    acc_sc = {
    'x': acceleration_xout / 16384.0,
    'y': acceleration_yout / 16384.0,
    'z': acceleration_zout / 16384.0,
    }
    rot_rd = {
        'x': get_x_rotation(acc_sc['x'], acc_sc['y'], acc_sc['z']),
        'y': get_y_rotation(acc_sc['x'], acc_sc['y'], acc_sc['z']),
        'z': get_z_rotation(acc_sc['x'], acc_sc['y'], acc_sc['z']),
    }
    
    print(f"ACC x({acc_sc['x']:.4f}) y({acc_sc['y']:.4f}) z({acc_sc['z']:.4f}) ROT x({rot_rd['x']:.4f}) y({rot_rd['y']:.4f}) z({rot_rd['z']:.4f})")
    
    time.sleep(0.5)