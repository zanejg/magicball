import math
import sys
import time

from smbus import SMBus

from PCA9685 import PWM



# channels = [
# {
#     "RED" : 0,
#     "GREEN" : 1,
#     "BLUE" : 2,
# },
# {
#     "RED" : 5,
#     "GREEN" : 4,
#     "BLUE" : 3,
# },
# {
#     "RED" : 8,
#     "GREEN" : 7,
#     "BLUE" : 6,
# },
# {
#     "RED" : 11,
#     "GREEN" : 10,
#     "BLUE" : 9,
# },
# ]




class LED_driver(object):
    fPWM = 1000
    i2c_address = 0x40 # (standard) adapt to your module
    #channel = 0 # adapt to your wiring

    def __init__(self,channels):
        """
        Takes a dict of pin numbers keyed by colour
        """
        
        self.bus = SMBus(1) # Raspberry Pi revision 2
        self.pwm = PWM(self.bus, self.i2c_address)
        self.pwm.setFreq(self.fPWM)
        self.channels = channels
        self.dim_seq = None
        self.dim_posi = None
    
    def set_led(self,colour,duty):
        self.pwm.setDuty(self.channels[colour], duty)


    def hex_to_level(self,hex):
        if(len(hex) != 2):
            raise ValueError("Hex value is not 2 digits")
        the_int = int(hex,16)
        return float(the_int/255.0) 
    
    def rgb_to_levels(self,rgb):
        
        levels = {
        "RED" :  self.hex_to_level(rgb[0:2]),
        "GREEN": self.hex_to_level(rgb[2:4]),
        "BLUE" : self.hex_to_level(rgb[4:6]),
        }
        return levels

    def light_with_RGB(self,the_RGB):
        the_levels = self.rgb_to_levels(the_RGB)
        # import pdb;pdb.set_trace()
        for col,val in the_levels.items():
            self.set_led(col,val)
        seq_data = get_colour_dimming_sequence(the_RGB)
        self.dim_seq = seq_data['sequences']
        self.dim_posi = seq_data['position']
    
    def get_posi_duties(self):
        return {
            "RED": self.dim_seq['RED'][self.dim_posi],
            "GREEN":self.dim_seq['GREEN'][self.dim_posi] ,
            "BLUE":self.dim_seq['BLUE'][self.dim_posi]
            
        }
    
    def dim(self,step_size =1):
        #print(f"posi={self.dim_posi}")
        if self.dim_posi is None:
            return
        self.dim_posi-=step_size
        if self.dim_posi < 0:
            self.dim_posi =0
        
        #self.light_with_floats(self.dim_seq[self.dim_posi],reset_seq=False)
        self.light_with_floats(self.get_posi_duties(),reset_seq=False)
        
    def brighten(self,step_size =1):
        #print(f"posi={self.dim_posi}")
        
        if self.dim_posi is None:
            return 
        
        #import pdb;pdb.set_trace()
        self.dim_posi+=step_size
        seqlen = len(self.dim_seq['RED'])
        if not (self.dim_posi < seqlen):
            self.dim_posi = seqlen -1
            
        self.light_with_floats(self.get_posi_duties() ,reset_seq=False)
        
    
    def light_with_floats(self,duties,reset_seq=True):
        """
        takes a dict of floats keyed by colour
        """
        for col,duty in duties.items():
                self.set_led(col,duty)
        if(reset_seq):
            self.dim_seq = None
            self.dim_posi = None
        
    
    
    

class four_LED_driver(object):
    def __init__(self,LEDs):
        """
        Takes list of 4 LED driver dicts
        """
        
        self.LEDs = [LED_driver(LED) for LED in LEDs]
        
    def all_same_RGB(self,the_RGB):
        for this_LED in self.LEDs:
            this_LED.light_with_RGB(the_RGB)
    
    def all_same_float(self,the_duties):
        for this_LED in self.LEDs:
            for col,duty in the_duties.items():
                this_LED.set_led(col,duty)
        
    def all_off(self):
        self.all_same_RGB("000000")
        
    def set_each(self,the_leds):
        """
        Takes a list of dicts each keyed by colour
        """
        for lednum,this_led in enumerate(the_leds):
            self.LEDs[lednum].light_with_floats(this_led)
            # for col,duty in this_led.items():
            #     self.LEDs[lednum].set_led(col,duty)
            
    def set_each_RGB(self,the_leds):
        """
        Takes a list of RGBs
        Will also create the dimming sequences for each and
        set them up
        """
        for lednum,this_RGB in enumerate(the_leds):
            self.LEDs[lednum].light_with_RGB(this_RGB)
            



def create_full_dimming_sequence():
    """
    Create a sequence of 2048 coefficients to use for dimming a light in logarithmic seq.
    For creating apparent linear dimming for human eye.
    Returns a sequence of coeficients between zero and one that progresses downward 
    logarithmically where the steps become smaller as it approaches 0
    To get a curve that seems appropriate we have used nat logs between 1 and 100
    """
    
    # first get a sequnece of 2048 floats bet 1 and 128
    x = []
    for i in range(1,129):
        xf = float(i)
        x.append(xf)
        for j in range(1,17):
            jf = j/16.0
            x.append(xf+jf)
    # then get their nat logs
    y=[math.log(i) for i in x]
    #y = [2**i for i in x]
    
    # need the max val
    mx = y[-1]
    # then divide all the vals by the max val for a sequence bet 0-1
    coeffs = [1-c/mx for c in y]
    # now reverse it for convenience
    coeffs.reverse()
    
    return coeffs#.reverse()


def rgb_to_ints(rgb):        
        levels = {
        "RED" :  int(rgb[0:2],16),
        "GREEN": int(rgb[2:4],16),
        "BLUE" : int(rgb[4:6],16),
        }
        return levels    




def get_colour_dimming_sequence(rgbstr):
    """
    Will return a list of 64 steps of dimming or brightening 
    a specific RGB colour along with the position in the sequence that
    the given RGB value is in that sequence.
    """
    full_dimming_seq = create_full_dimming_sequence()
    
    # first we need the values as integers
    levels = rgb_to_ints(rgbstr)
    # then we need to find the one with the max val
    # or at least one that has the max val
    max_col = "RED"
    if levels['GREEN'] > levels['RED']:
        max_col = "GREEN"
    if levels['BLUE'] > levels[max_col]:
        max_col = "BLUE"
    max_level = float(levels[max_col])
    lesser_cols = [col for col,v in levels.items() if col != max_col]
    lesser_levels = {lesser_cols[0]:levels[lesser_cols[0]],
                     lesser_cols[1]:levels[lesser_cols[1]]}
    
    
    # now find what proportion of the full power the max level is
    full = 255.0
    # the coefficient that will get the max level to full
    full_max_coeff = ((full - max_level) + max_level) / max_level if max_level else 0
    # we will need this to find where we are
    max_fraction = max_level/full
    low = full_dimming_seq[0]
    posi = 0
    
    dim_seq_len = len(full_dimming_seq)
    # we want a relatively big step for our rotary switch control
    # so we will split the seq up into 64
    stepnum = 64
    step_size = int(dim_seq_len/(stepnum-1)) # we will only calc 1st 63
    stepped_dimming_seq = [full_dimming_seq[i] for i in range(0,dim_seq_len,step_size)]
    # then ensure 1.0 is on the end
    stepped_dimming_seq.append(1.0)
    # now find our position in it
    for posi,i in enumerate(stepped_dimming_seq):
        if max_fraction <= i:
            break
    position = posi
    # we need the ratios of the colours to stay the same over the range
    # so we will store the ration of the lesser ones to the max value
    lesser_ratios = {col:(val/max_level if max_level else 0) for col,val in lesser_levels.items()}
    
    # now we can build the sequence as 3 lists of values keyed by colour
    # the max colour will be the same as the stepped_dimming_seq
    # because it will go from zero to 1
    # the others will be multiplied by their ratios
    lesser_col0 = [lesser_ratios[lesser_cols[0]] * sd for sd in stepped_dimming_seq]
    lesser_col1 = [lesser_ratios[lesser_cols[1]] * sd for sd in stepped_dimming_seq]
    
    
    # return a dict with 3 dimming sequences identified by colour
    # and a position for the given RGB colour in the dimming sequence
    return {
        "position":position,
        "sequences": {
            max_col:stepped_dimming_seq,
            lesser_cols[0]:lesser_col0,
            lesser_cols[1]:lesser_col1,
        },
    }


    
    
    
    
    
    
    
    
    
    
    
    








