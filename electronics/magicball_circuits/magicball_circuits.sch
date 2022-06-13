EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "15 nov 2012"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:+5V #PWR01
U 1 1 580C1B61
P 2550 950
F 0 "#PWR01" H 2550 800 50  0001 C CNN
F 1 "+5V" H 2550 1090 50  0000 C CNN
F 2 "" H 2550 950 50  0000 C CNN
F 3 "" H 2550 950 50  0000 C CNN
	1    2550 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 950  2550 1100
Wire Wire Line
	2550 1100 2350 1100
Wire Wire Line
	2550 1200 2350 1200
Connection ~ 2550 1100
$Comp
L power:GND #PWR02
U 1 1 580C1D11
P 2450 3150
F 0 "#PWR02" H 2450 2900 50  0001 C CNN
F 1 "GND" H 2450 3000 50  0000 C CNN
F 2 "" H 2450 3150 50  0000 C CNN
F 3 "" H 2450 3150 50  0000 C CNN
	1    2450 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 1300 2450 1700
Wire Wire Line
	2450 2700 2350 2700
Wire Wire Line
	2450 2500 2350 2500
Connection ~ 2450 2700
Wire Wire Line
	2450 2000 2350 2000
Connection ~ 2450 2500
Wire Wire Line
	2450 1700 2350 1700
Connection ~ 2450 2000
$Comp
L power:GND #PWR03
U 1 1 580C1E01
P 1750 3150
F 0 "#PWR03" H 1750 2900 50  0001 C CNN
F 1 "GND" H 1750 3000 50  0000 C CNN
F 2 "" H 1750 3150 50  0000 C CNN
F 3 "" H 1750 3150 50  0000 C CNN
	1    1750 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 3000 1850 3000
Wire Wire Line
	1750 1500 1750 2300
Wire Wire Line
	1750 2300 1850 2300
Connection ~ 1750 3000
Connection ~ 1650 1100
Wire Wire Line
	1650 1900 1850 1900
Wire Wire Line
	1650 1100 1850 1100
Wire Wire Line
	1650 950  1650 1100
$Comp
L power:+3.3V #PWR04
U 1 1 580C1BC1
P 1650 950
F 0 "#PWR04" H 1650 800 50  0001 C CNN
F 1 "+3.3V" H 1650 1090 50  0000 C CNN
F 2 "" H 1650 950 50  0000 C CNN
F 3 "" H 1650 950 50  0000 C CNN
	1    1650 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 1500 1850 1500
Connection ~ 1750 2300
Wire Wire Line
	700  1400 1850 1400
Wire Wire Line
	1850 1600 700  1600
Wire Wire Line
	700  1700 1850 1700
Wire Wire Line
	700  1800 1850 1800
Wire Wire Line
	1850 2000 700  2000
Wire Wire Line
	700  2100 1850 2100
Wire Wire Line
	700  2200 1850 2200
Wire Wire Line
	1850 2400 700  2400
Wire Wire Line
	700  2500 1850 2500
Wire Wire Line
	700  2600 1850 2600
Wire Wire Line
	1850 2700 700  2700
Wire Wire Line
	700  2800 1850 2800
Wire Wire Line
	700  2900 1850 2900
Wire Wire Line
	2350 2800 3400 2800
Wire Wire Line
	2350 2900 3400 2900
Wire Wire Line
	2350 2300 3400 2300
Wire Wire Line
	2350 2400 3400 2400
Wire Wire Line
	2350 2100 3400 2100
Wire Wire Line
	2350 2200 3400 2200
Wire Wire Line
	2350 1800 3400 1800
Wire Wire Line
	2350 1900 3400 1900
Wire Wire Line
	2350 2600 3400 2600
Text Label 700  1200 0    50   ~ 0
GPIO2(SDA1)
Text Label 700  1300 0    50   ~ 0
GPIO3(SCL1)
Text Label 700  1400 0    50   ~ 0
GPIO4(GCLK)
Text Label 700  1600 0    50   ~ 0
GPIO17(GEN0)
Text Label 700  1700 0    50   ~ 0
GPIO27(GEN2)
Text Label 700  1800 0    50   ~ 0
GPIO22(GEN3)
Text Label 700  2000 0    50   ~ 0
GPIO10(SPI0_MOSI)
Text Label 700  2100 0    50   ~ 0
GPIO9(SPI0_MISO)
Text Label 700  2200 0    50   ~ 0
GPIO11(SPI0_SCK)
Text Label 700  2400 0    50   ~ 0
ID_SD
Text Label 700  2500 0    50   ~ 0
GPIO5
Text Label 700  2600 0    50   ~ 0
GPIO6
Text Label 700  2700 0    50   ~ 0
GPIO13(PWM1)
Text Label 700  2800 0    50   ~ 0
GPIO19(SPI1_MISO)
Text Label 700  2900 0    50   ~ 0
GPIO26
Text Label 3400 2900 2    50   ~ 0
GPIO20(SPI1_MOSI)
Text Label 3400 2800 2    50   ~ 0
GPIO16
Text Label 3400 2600 2    50   ~ 0
GPIO12(PWM0)
Text Label 3400 2400 2    50   ~ 0
ID_SC
Text Label 3400 2300 2    50   ~ 0
GPIO7(SPI1_CE_N)
Text Label 3400 2200 2    50   ~ 0
GPIO8(SPI0_CE_N)
Text Label 3400 2100 2    50   ~ 0
GPIO25(GEN6)
Text Label 3400 1900 2    50   ~ 0
GPIO24(GEN5)
Text Label 3400 1800 2    50   ~ 0
GPIO23(GEN4)
Text Label 3400 1600 2    50   ~ 0
GPIO18(GEN1)(PWM0)
Text Label 3400 1500 2    50   ~ 0
GPIO15(RXD0)
Text Label 3400 1400 2    50   ~ 0
GPIO14(TXD0)
Wire Wire Line
	2450 1300 2350 1300
Connection ~ 2450 1700
Text Notes 800  7350 0    50   ~ 0
Resistors R2-R13 are yet to be defined and are specific for each \ncolour of LED on the COB.\n\nThe PWM chip is not actually the chip itself but a small PCB using it.\n\nR14-R25 are approx 10k pulldowns
$Comp
L Connector_Generic:Conn_02x20_Odd_Even P1
U 1 1 59AD464A
P 2050 2000
F 0 "P1" H 2100 3117 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 2100 3026 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x20_P2.54mm_Vertical" H -2800 1050 50  0001 C CNN
F 3 "" H -2800 1050 50  0001 C CNN
	1    2050 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 3000 3400 3000
Text Label 3400 3000 2    50   ~ 0
GPIO21(SPI1_SCK)
Wire Wire Line
	2550 1100 2550 1200
Wire Wire Line
	2450 2700 2450 3150
Wire Wire Line
	2450 2500 2450 2700
Wire Wire Line
	2450 2000 2450 2500
Wire Wire Line
	1750 3000 1750 3150
Wire Wire Line
	1650 1100 1650 1900
Wire Wire Line
	1750 2300 1750 3000
Wire Wire Line
	2450 1700 2450 2000
$Comp
L Device:Rotary_Encoder_Switch SW?
U 1 1 629AF60D
P 1550 4200
F 0 "SW?" H 1550 4567 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 1550 4476 50  0000 C CNN
F 2 "" H 1400 4360 50  0001 C CNN
F 3 "~" H 1550 4460 50  0001 C CNN
	1    1550 4200
	1    0    0    -1  
$EndComp
$Comp
L Device:LED_RGB D?
U 1 1 629B0916
P 10250 5650
F 0 "D?" V 10204 6010 50  0000 L CNN
F 1 "LED_RGB" V 10295 6010 50  0000 L CNN
F 2 "" H 10250 5600 50  0001 C CNN
F 3 "~" H 10250 5600 50  0001 C CNN
	1    10250 5650
	0    1    1    0   
$EndComp
$Comp
L Device:LED_RGB D?
U 1 1 629B29D8
P 10250 4050
F 0 "D?" V 10204 4410 50  0000 L CNN
F 1 "LED_RGB" V 10295 4410 50  0000 L CNN
F 2 "" H 10250 4000 50  0001 C CNN
F 3 "~" H 10250 4000 50  0001 C CNN
	1    10250 4050
	0    1    1    0   
$EndComp
$Comp
L Device:LED_RGB D?
U 1 1 629B3625
P 10300 2650
F 0 "D?" V 10254 3010 50  0000 L CNN
F 1 "LED_RGB" V 10345 3010 50  0000 L CNN
F 2 "" H 10300 2600 50  0001 C CNN
F 3 "~" H 10300 2600 50  0001 C CNN
	1    10300 2650
	0    1    1    0   
$EndComp
$Comp
L Device:LED_RGB D?
U 1 1 629B5088
P 10300 1450
F 0 "D?" V 10254 1120 50  0000 R CNN
F 1 "LED_RGB" V 10345 1120 50  0000 R CNN
F 2 "" H 10300 1400 50  0001 C CNN
F 3 "~" H 10300 1400 50  0001 C CNN
	1    10300 1450
	0    -1   1    0   
$EndComp
$Comp
L power:+5VP #PWR?
U 1 1 629B9FC4
P 7500 700
F 0 "#PWR?" H 7500 550 50  0001 C CNN
F 1 "+5VP" H 7515 873 50  0000 C CNN
F 2 "" H 7500 700 50  0001 C CNN
F 3 "" H 7500 700 50  0001 C CNN
	1    7500 700 
	1    0    0    -1  
$EndComp
$Comp
L zlibs:L9110S-Dual_H-Bridge_board PCB?
U 1 1 62A2ACDB
P 8250 3100
F 0 "PCB?" H 8250 3615 50  0000 C CNN
F 1 "L9110S-Dual_H-Bridge_board" H 8250 3524 50  0000 C CNN
F 2 "" H 8200 3500 50  0001 C CNN
F 3 "" H 8200 3500 50  0001 C CNN
	1    8250 3100
	1    0    0    -1  
$EndComp
$Comp
L zlibs:L9110S-Dual_H-Bridge_board PCB?
U 1 1 62A2B8FD
P 8250 4100
F 0 "PCB?" H 8250 4615 50  0000 C CNN
F 1 "L9110S-Dual_H-Bridge_board" H 8250 4524 50  0000 C CNN
F 2 "" H 8200 4500 50  0001 C CNN
F 3 "" H 8200 4500 50  0001 C CNN
	1    8250 4100
	1    0    0    -1  
$EndComp
$Comp
L zlibs:L9110S-Dual_H-Bridge_board PCB?
U 1 1 62A2C4F1
P 8300 5050
F 0 "PCB?" H 8300 5565 50  0000 C CNN
F 1 "L9110S-Dual_H-Bridge_board" H 8300 5474 50  0000 C CNN
F 2 "" H 8250 5450 50  0001 C CNN
F 3 "" H 8250 5450 50  0001 C CNN
	1    8300 5050
	1    0    0    -1  
$EndComp
$Comp
L zlibs:L9110S-Dual_H-Bridge_board PCB?
U 1 1 62A2DCF9
P 8250 1100
F 0 "PCB?" H 8250 1615 50  0000 C CNN
F 1 "L9110S-Dual_H-Bridge_board" H 8250 1524 50  0000 C CNN
F 2 "" H 8200 1500 50  0001 C CNN
F 3 "" H 8200 1500 50  0001 C CNN
	1    8250 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 1350 7750 1350
Wire Wire Line
	7600 1950 7750 1950
Wire Wire Line
	7400 2950 7750 2950
Wire Wire Line
	7300 3350 7750 3350
Wire Wire Line
	7150 3950 7750 3950
Wire Wire Line
	7050 4350 7750 4350
Wire Wire Line
	8750 850  10500 850 
Wire Wire Line
	10500 850  10500 1250
Wire Wire Line
	8750 1000 9700 1000
Wire Wire Line
	8750 1300 9850 1300
Wire Wire Line
	10300 1150 10300 1250
Wire Wire Line
	8750 1150 10300 1150
Wire Wire Line
	8750 1850 9000 1850
Wire Wire Line
	9000 1850 9000 1050
Wire Wire Line
	9000 1050 10100 1050
Wire Wire Line
	10100 1050 10100 1250
Wire Wire Line
	8750 2150 10500 2150
Wire Wire Line
	10500 2150 10500 2450
Wire Wire Line
	8750 2850 9450 2850
Wire Wire Line
	9450 2850 9450 2400
Wire Wire Line
	8750 2300 9200 2300
Wire Wire Line
	10300 2400 10300 2450
Wire Wire Line
	9450 2400 10300 2400
Wire Wire Line
	8750 3150 9550 3150
Wire Wire Line
	9550 3150 9550 2250
Wire Wire Line
	9550 2250 10100 2250
Wire Wire Line
	10100 2250 10100 2450
Wire Wire Line
	8750 3300 10100 3300
$Comp
L Device:R R8
U 1 1 62AF36B6
P 10050 4400
F 0 "R8" H 10120 4446 50  0000 L CNN
F 1 "R" H 10120 4355 50  0000 L CNN
F 2 "" V 9980 4400 50  0001 C CNN
F 3 "~" H 10050 4400 50  0001 C CNN
	1    10050 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 62AF3E67
P 10250 4400
F 0 "R9" H 10320 4446 50  0000 L CNN
F 1 "R" H 10320 4355 50  0000 L CNN
F 2 "" V 10180 4400 50  0001 C CNN
F 3 "~" H 10250 4400 50  0001 C CNN
	1    10250 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 62AF453D
P 10450 4400
F 0 "R10" H 10520 4446 50  0000 L CNN
F 1 "R" H 10520 4355 50  0000 L CNN
F 2 "" V 10380 4400 50  0001 C CNN
F 3 "~" H 10450 4400 50  0001 C CNN
	1    10450 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8750 3850 8900 3850
Wire Wire Line
	8900 3850 8900 3550
Wire Wire Line
	8900 3550 10450 3550
Wire Wire Line
	10450 3550 10450 3850
$Comp
L Device:R R2
U 1 1 62AFA88A
P 10100 1800
F 0 "R2" H 10170 1846 50  0000 L CNN
F 1 "R" H 10170 1755 50  0000 L CNN
F 2 "" V 10030 1800 50  0001 C CNN
F 3 "~" H 10100 1800 50  0001 C CNN
	1    10100 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 62AFB094
P 10300 1800
F 0 "R3" H 10370 1846 50  0000 L CNN
F 1 "R" H 10370 1755 50  0000 L CNN
F 2 "" V 10230 1800 50  0001 C CNN
F 3 "~" H 10300 1800 50  0001 C CNN
	1    10300 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 62AFB867
P 10500 1800
F 0 "R4" H 10570 1846 50  0000 L CNN
F 1 "R" H 10570 1755 50  0000 L CNN
F 2 "" V 10430 1800 50  0001 C CNN
F 3 "~" H 10500 1800 50  0001 C CNN
	1    10500 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	10500 2000 10500 1950
Wire Wire Line
	8750 2000 10500 2000
Wire Wire Line
	9850 2100 10300 2100
Wire Wire Line
	10300 2100 10300 1950
Wire Wire Line
	9850 1300 9850 2100
Wire Wire Line
	9700 2050 10100 2050
Wire Wire Line
	10100 2050 10100 1950
Wire Wire Line
	9700 1000 9700 2050
$Comp
L Device:R R5
U 1 1 62B09623
P 10100 3000
F 0 "R5" H 10170 3046 50  0000 L CNN
F 1 "R" H 10170 2955 50  0000 L CNN
F 2 "" V 10030 3000 50  0001 C CNN
F 3 "~" H 10100 3000 50  0001 C CNN
	1    10100 3000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 62B09E10
P 10300 3000
F 0 "R6" H 10370 3046 50  0000 L CNN
F 1 "R" H 10370 2955 50  0000 L CNN
F 2 "" V 10230 3000 50  0001 C CNN
F 3 "~" H 10300 3000 50  0001 C CNN
	1    10300 3000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 62B0A604
P 10500 3000
F 0 "R7" H 10570 3046 50  0000 L CNN
F 1 "R" H 10570 2955 50  0000 L CNN
F 2 "" V 10430 3000 50  0001 C CNN
F 3 "~" H 10500 3000 50  0001 C CNN
	1    10500 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 3500 10500 3500
Wire Wire Line
	10500 3500 10500 3150
Wire Wire Line
	9200 2300 9200 3500
Wire Wire Line
	8750 3000 9750 3000
Wire Wire Line
	9750 3000 9750 3200
Wire Wire Line
	9750 3200 10300 3200
Wire Wire Line
	10300 3200 10300 3150
Wire Wire Line
	10100 3300 10100 3150
Wire Wire Line
	8750 4000 9850 4000
Wire Wire Line
	9850 4000 9850 4700
Wire Wire Line
	9850 4700 10450 4700
Wire Wire Line
	10450 4700 10450 4550
Wire Wire Line
	8750 4150 9050 4150
Wire Wire Line
	9050 4150 9050 3650
Wire Wire Line
	9050 3650 10250 3650
Wire Wire Line
	10250 3650 10250 3850
Wire Wire Line
	8750 4300 9200 4300
Wire Wire Line
	9200 4300 9200 4650
Wire Wire Line
	9200 4650 10250 4650
Wire Wire Line
	10250 4650 10250 4550
Wire Wire Line
	8800 4800 9350 4800
Wire Wire Line
	9350 4800 9350 3800
Wire Wire Line
	9350 3800 10050 3800
Wire Wire Line
	10050 3800 10050 3850
Wire Wire Line
	8800 4950 10050 4950
Wire Wire Line
	10050 4950 10050 4550
Wire Wire Line
	8800 5100 10450 5100
Wire Wire Line
	10450 5100 10450 5450
Wire Wire Line
	8800 5250 9900 5250
Wire Wire Line
	8800 5750 9500 5750
Wire Wire Line
	9500 5750 9500 5300
Wire Wire Line
	9500 5300 10250 5300
Wire Wire Line
	10250 5300 10250 5450
Wire Wire Line
	8800 5900 9600 5900
Wire Wire Line
	8800 6050 9050 6050
Wire Wire Line
	9050 6050 9050 5400
Wire Wire Line
	9050 5400 10050 5400
Wire Wire Line
	10050 5400 10050 5450
Wire Wire Line
	8800 6200 10050 6200
$Comp
L Device:R R11
U 1 1 62B5807A
P 10050 6000
F 0 "R11" H 10120 6046 50  0000 L CNN
F 1 "R" H 10120 5955 50  0000 L CNN
F 2 "" V 9980 6000 50  0001 C CNN
F 3 "~" H 10050 6000 50  0001 C CNN
	1    10050 6000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R12
U 1 1 62B5937C
P 10250 6000
F 0 "R12" H 10320 6046 50  0000 L CNN
F 1 "R" H 10320 5955 50  0000 L CNN
F 2 "" V 10180 6000 50  0001 C CNN
F 3 "~" H 10250 6000 50  0001 C CNN
	1    10250 6000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 62B59B41
P 10450 6000
F 0 "R13" H 10520 6046 50  0000 L CNN
F 1 "R" H 10520 5955 50  0000 L CNN
F 2 "" V 10380 6000 50  0001 C CNN
F 3 "~" H 10450 6000 50  0001 C CNN
	1    10450 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10050 6200 10050 6150
Wire Wire Line
	9900 6400 10450 6400
Wire Wire Line
	10450 6400 10450 6150
Wire Wire Line
	9900 5250 9900 6400
Wire Wire Line
	9600 6300 10250 6300
Wire Wire Line
	10250 6300 10250 6150
Wire Wire Line
	9600 5900 9600 6300
Wire Wire Line
	4000 1650 3900 1650
$Comp
L Driver_LED:PCA9685PW U?
U 1 1 629ACFA9
P 4700 2350
F 0 "U?" H 4700 3531 50  0000 C CNN
F 1 "PCA9685PW" H 4700 3440 50  0000 C CNN
F 2 "Package_SO:TSSOP-28_4.4x9.7mm_P0.65mm" H 4725 1375 50  0001 L CNN
F 3 "http://www.nxp.com/documents/data_sheet/PCA9685.pdf" H 4300 3050 50  0001 C CNN
	1    4700 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 3450 4450 3600
$Comp
L power:+3.3V #PWR?
U 1 1 62B95867
P 4450 3450
F 0 "#PWR?" H 4450 3300 50  0001 C CNN
F 1 "+3.3V" H 4450 3590 50  0000 C CNN
F 2 "" H 4450 3450 50  0000 C CNN
F 3 "" H 4450 3450 50  0000 C CNN
	1    4450 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 3600 4450 3600
Wire Wire Line
	4700 3450 4700 3600
Wire Wire Line
	7500 6050 7800 6050
$Comp
L zlibs:L9110S-Dual_H-Bridge_board PCB?
U 1 1 62A29A85
P 8250 2100
F 0 "PCB?" H 8250 2615 50  0000 C CNN
F 1 "L9110S-Dual_H-Bridge_board" H 8250 2524 50  0000 C CNN
F 2 "" H 8200 2500 50  0001 C CNN
F 3 "" H 8200 2500 50  0001 C CNN
	1    8250 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 700  7500 1150
Wire Wire Line
	7550 2350 7750 2350
Wire Wire Line
	7750 2150 7500 2150
Connection ~ 7500 2150
Wire Wire Line
	7500 2150 7500 3150
Wire Wire Line
	7750 3150 7500 3150
Connection ~ 7500 3150
Wire Wire Line
	7500 3150 7500 4150
Wire Wire Line
	7750 1150 7500 1150
Connection ~ 7500 1150
Wire Wire Line
	7500 1150 7500 2150
Wire Wire Line
	7750 4150 7500 4150
Connection ~ 7500 4150
Wire Wire Line
	7500 4150 7500 5100
Wire Wire Line
	7800 5100 7500 5100
Connection ~ 7500 5100
Wire Wire Line
	7500 5100 7500 6050
Wire Wire Line
	7800 6150 7650 6150
Wire Wire Line
	7650 6150 7650 5950
Wire Wire Line
	7650 5750 7800 5750
Connection ~ 7650 6150
Wire Wire Line
	7650 6150 7200 6150
Wire Wire Line
	7650 5750 7650 5200
Wire Wire Line
	7650 850  7750 850 
Connection ~ 7650 5750
Wire Wire Line
	7750 1250 7650 1250
Connection ~ 7650 1250
Wire Wire Line
	7650 1250 7650 1050
Wire Wire Line
	7750 1850 7650 1850
Connection ~ 7650 1850
Wire Wire Line
	7650 1850 7650 1250
Connection ~ 7650 2250
Wire Wire Line
	7750 2850 7650 2850
Connection ~ 7650 2850
Wire Wire Line
	7650 2850 7650 2250
Wire Wire Line
	7750 3250 7650 3250
Connection ~ 7650 3250
Wire Wire Line
	7650 3250 7650 3050
Wire Wire Line
	7750 3850 7650 3850
Connection ~ 7650 3850
Wire Wire Line
	7650 3850 7650 3250
Wire Wire Line
	7750 4250 7650 4250
Connection ~ 7650 4250
Wire Wire Line
	7650 4250 7650 4050
Wire Wire Line
	7800 4800 7650 4800
Connection ~ 7650 4800
Wire Wire Line
	7650 4800 7650 4250
Wire Wire Line
	7800 5200 7650 5200
Connection ~ 7650 5200
Wire Wire Line
	7650 5200 7650 5000
Wire Wire Line
	7650 2250 7750 2250
$Comp
L zlibs:GY-521-Accelerometer-PCB PCB?
U 1 1 629C330E
P 3200 4450
F 0 "PCB?" H 3628 4171 50  0000 L CNN
F 1 "GY-521-Accelerometer-PCB" H 3628 4080 50  0000 L CNN
F 2 "" H 3200 4700 50  0001 C CNN
F 3 "" H 3200 4700 50  0001 C CNN
	1    3200 4450
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 629C71D6
P 2850 4250
F 0 "#PWR?" H 2850 4100 50  0001 C CNN
F 1 "+3.3V" H 2850 4390 50  0000 C CNN
F 2 "" H 2850 4250 50  0000 C CNN
F 3 "" H 2850 4250 50  0000 C CNN
	1    2850 4250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 629C856D
P 1950 4500
F 0 "#PWR?" H 1950 4250 50  0001 C CNN
F 1 "GND" H 1955 4327 50  0000 C CNN
F 2 "" H 1950 4500 50  0001 C CNN
F 3 "" H 1950 4500 50  0001 C CNN
	1    1950 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 4600 2250 4600
Wire Wire Line
	2250 4600 2250 3500
Connection ~ 2250 3500
Wire Wire Line
	2900 4700 2400 4700
Wire Wire Line
	2400 4700 2400 3350
Connection ~ 2400 3350
Wire Wire Line
	2900 4400 2850 4400
Wire Wire Line
	2850 4400 2850 4250
Wire Wire Line
	2900 4500 1950 4500
$Comp
L Device:R R1
U 1 1 62A2B236
P 2000 4100
F 0 "R1" V 2207 4100 50  0000 C CNN
F 1 "10k" V 2116 4100 50  0000 C CNN
F 2 "" V 1930 4100 50  0001 C CNN
F 3 "~" H 2000 4100 50  0001 C CNN
	1    2000 4100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2150 4100 2150 4250
Wire Wire Line
	2150 4250 2850 4250
Connection ~ 2850 4250
Wire Wire Line
	1850 4300 2650 4300
Wire Wire Line
	2650 4300 2650 3900
Wire Wire Line
	2650 3900 3450 3900
Wire Wire Line
	3450 3900 3450 1400
Wire Wire Line
	2350 1400 3450 1400
Wire Wire Line
	3900 3500 3900 1650
Wire Wire Line
	2250 3500 3900 3500
Wire Wire Line
	3800 3350 3800 1750
Wire Wire Line
	2400 3350 3800 3350
Wire Wire Line
	3800 1750 4000 1750
Wire Wire Line
	1250 4100 900  4100
Wire Wire Line
	900  4100 900  3650
Wire Wire Line
	900  3650 3750 3650
Wire Wire Line
	3750 3650 3750 1500
Wire Wire Line
	2350 1500 3750 1500
Wire Wire Line
	1250 4200 800  4200
Wire Wire Line
	800  4200 800  3600
Wire Wire Line
	800  3600 3600 3600
Wire Wire Line
	3600 3600 3600 1600
Wire Wire Line
	2350 1600 3600 1600
$Comp
L power:GND #PWR?
U 1 1 62B7C121
P 6800 6550
F 0 "#PWR?" H 6800 6300 50  0001 C CNN
F 1 "GND" H 6805 6377 50  0000 C CNN
F 2 "" H 6800 6550 50  0001 C CNN
F 3 "" H 6800 6550 50  0001 C CNN
	1    6800 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 6550 6800 6400
Wire Wire Line
	6800 6400 7200 6400
Wire Wire Line
	7200 6400 7200 6150
$Comp
L Device:R R23
U 1 1 62B918F9
P 5900 4600
F 0 "R23" H 5970 4646 50  0000 L CNN
F 1 "R" H 5970 4555 50  0000 L CNN
F 2 "" V 5830 4600 50  0001 C CNN
F 3 "~" H 5900 4600 50  0001 C CNN
	1    5900 4600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R22
U 1 1 62B92498
P 5650 4600
F 0 "R22" H 5720 4646 50  0000 L CNN
F 1 "R" H 5720 4555 50  0000 L CNN
F 2 "" V 5580 4600 50  0001 C CNN
F 3 "~" H 5650 4600 50  0001 C CNN
	1    5650 4600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 62B93475
P 5450 3650
F 0 "R14" H 5520 3696 50  0000 L CNN
F 1 "R" H 5520 3605 50  0000 L CNN
F 2 "" V 5380 3650 50  0001 C CNN
F 3 "~" H 5450 3650 50  0001 C CNN
	1    5450 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 62B940BF
P 5700 3650
F 0 "R15" H 5770 3696 50  0000 L CNN
F 1 "R" H 5770 3605 50  0000 L CNN
F 2 "" V 5630 3650 50  0001 C CNN
F 3 "~" H 5700 3650 50  0001 C CNN
	1    5700 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 62B94CCF
P 5950 3650
F 0 "R16" H 6020 3696 50  0000 L CNN
F 1 "R" H 6020 3605 50  0000 L CNN
F 2 "" V 5880 3650 50  0001 C CNN
F 3 "~" H 5950 3650 50  0001 C CNN
	1    5950 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R17
U 1 1 62B958AE
P 6200 3650
F 0 "R17" H 6270 3696 50  0000 L CNN
F 1 "R" H 6270 3605 50  0000 L CNN
F 2 "" V 6130 3650 50  0001 C CNN
F 3 "~" H 6200 3650 50  0001 C CNN
	1    6200 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R25
U 1 1 62C1C0CD
P 6400 4600
F 0 "R25" H 6470 4646 50  0000 L CNN
F 1 "R" H 6470 4555 50  0000 L CNN
F 2 "" V 6330 4600 50  0001 C CNN
F 3 "~" H 6400 4600 50  0001 C CNN
	1    6400 4600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R24
U 1 1 62C1C0D3
P 6150 4600
F 0 "R24" H 6220 4646 50  0000 L CNN
F 1 "R" H 6220 4555 50  0000 L CNN
F 2 "" V 6080 4600 50  0001 C CNN
F 3 "~" H 6150 4600 50  0001 C CNN
	1    6150 4600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R18
U 1 1 62C1C0D9
P 5550 4100
F 0 "R18" H 5620 4146 50  0000 L CNN
F 1 "R" H 5620 4055 50  0000 L CNN
F 2 "" V 5480 4100 50  0001 C CNN
F 3 "~" H 5550 4100 50  0001 C CNN
	1    5550 4100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R19
U 1 1 62C1C0DF
P 5800 4100
F 0 "R19" H 5870 4146 50  0000 L CNN
F 1 "R" H 5870 4055 50  0000 L CNN
F 2 "" V 5730 4100 50  0001 C CNN
F 3 "~" H 5800 4100 50  0001 C CNN
	1    5800 4100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R20
U 1 1 62C1C0E5
P 6050 4100
F 0 "R20" H 6120 4146 50  0000 L CNN
F 1 "R" H 6120 4055 50  0000 L CNN
F 2 "" V 5980 4100 50  0001 C CNN
F 3 "~" H 6050 4100 50  0001 C CNN
	1    6050 4100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R21
U 1 1 62C1C0EB
P 6300 4100
F 0 "R21" H 6370 4146 50  0000 L CNN
F 1 "R" H 6370 4055 50  0000 L CNN
F 2 "" V 6230 4100 50  0001 C CNN
F 3 "~" H 6300 4100 50  0001 C CNN
	1    6300 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 1500 7600 1950
Wire Wire Line
	7550 1600 7550 2350
Wire Wire Line
	5500 1650 5500 950 
Wire Wire Line
	5500 950  7750 950 
Wire Wire Line
	5400 1750 5600 1750
Wire Wire Line
	5600 1750 5600 1100
Wire Wire Line
	5600 1100 5700 1100
Wire Wire Line
	6950 1100 6950 1350
Wire Wire Line
	5400 1850 5800 1850
Wire Wire Line
	5800 1850 5800 1500
Wire Wire Line
	5800 1500 5950 1500
Wire Wire Line
	5400 1950 5900 1950
Wire Wire Line
	5900 1950 5900 1600
Wire Wire Line
	5900 1600 6200 1600
Wire Wire Line
	5400 2050 5550 2050
Wire Wire Line
	6000 2050 6000 1700
Wire Wire Line
	6000 1700 7400 1700
Wire Wire Line
	7400 1700 7400 2950
Wire Wire Line
	5400 2150 5800 2150
Wire Wire Line
	6100 2150 6100 1800
Wire Wire Line
	6100 1800 7300 1800
Wire Wire Line
	7300 1800 7300 3350
Wire Wire Line
	5400 2750 6400 2750
Wire Wire Line
	5400 2650 6100 2650
Wire Wire Line
	5400 2550 5850 2550
Wire Wire Line
	5400 2250 6050 2250
Wire Wire Line
	7150 2250 7150 3950
Wire Wire Line
	5400 2350 6300 2350
Wire Wire Line
	7050 2350 7050 4350
Wire Wire Line
	5400 2450 5600 2450
Wire Wire Line
	6950 2450 6950 4900
Wire Wire Line
	6950 4900 7800 4900
$Comp
L zlibs:L9110S-Dual_H-Bridge_board PCB?
U 1 1 62E65FA3
P 8300 6000
F 0 "PCB?" H 8300 6515 50  0000 C CNN
F 1 "L9110S-Dual_H-Bridge_board" H 8300 6424 50  0000 C CNN
F 2 "" H 8250 6400 50  0001 C CNN
F 3 "" H 8250 6400 50  0001 C CNN
	1    8300 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 2550 6900 5300
Wire Wire Line
	6900 5300 7800 5300
Wire Wire Line
	6800 5850 7800 5850
Wire Wire Line
	6800 2650 6800 5850
Wire Wire Line
	6700 6250 7800 6250
Wire Wire Line
	6700 2750 6700 6250
Wire Wire Line
	5450 3500 5450 1650
Wire Wire Line
	5400 1650 5450 1650
Connection ~ 5450 1650
Wire Wire Line
	5450 1650 5500 1650
Wire Wire Line
	5700 3500 5700 1100
Connection ~ 5700 1100
Wire Wire Line
	5700 1100 6950 1100
Wire Wire Line
	5950 3500 5950 1500
Connection ~ 5950 1500
Wire Wire Line
	5950 1500 7600 1500
Wire Wire Line
	6200 3500 6200 1600
Connection ~ 6200 1600
Wire Wire Line
	6200 1600 7550 1600
Wire Wire Line
	5550 3950 5550 2050
Connection ~ 5550 2050
Wire Wire Line
	5550 2050 6000 2050
Wire Wire Line
	5800 3950 5800 2150
Connection ~ 5800 2150
Wire Wire Line
	5800 2150 6100 2150
Wire Wire Line
	6050 3950 6050 2250
Connection ~ 6050 2250
Wire Wire Line
	6050 2250 7150 2250
Wire Wire Line
	6300 3950 6300 2350
Connection ~ 6300 2350
Wire Wire Line
	6300 2350 7050 2350
Wire Wire Line
	5650 4450 5650 3900
Wire Wire Line
	5650 3900 5600 3900
Wire Wire Line
	5600 3900 5600 2450
Connection ~ 5600 2450
Wire Wire Line
	5600 2450 6950 2450
Wire Wire Line
	5900 4450 5900 3900
Wire Wire Line
	5900 3900 5850 3900
Wire Wire Line
	5850 3900 5850 2550
Connection ~ 5850 2550
Wire Wire Line
	5850 2550 6900 2550
Wire Wire Line
	6150 4450 6150 3950
Wire Wire Line
	6150 3950 6100 3950
Wire Wire Line
	6100 3950 6100 2650
Connection ~ 6100 2650
Wire Wire Line
	6100 2650 6800 2650
Wire Wire Line
	6400 4450 6400 2750
Connection ~ 6400 2750
Wire Wire Line
	6400 2750 6700 2750
$Comp
L power:GND #PWR?
U 1 1 630A85B8
P 5300 4900
F 0 "#PWR?" H 5300 4650 50  0001 C CNN
F 1 "GND" H 5305 4727 50  0000 C CNN
F 2 "" H 5300 4900 50  0001 C CNN
F 3 "" H 5300 4900 50  0001 C CNN
	1    5300 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 4750 6150 4750
Wire Wire Line
	6150 4750 5900 4750
Connection ~ 6150 4750
Wire Wire Line
	5900 4750 5650 4750
Connection ~ 5900 4750
Wire Wire Line
	5650 4750 5300 4750
Wire Wire Line
	5300 4750 5300 4900
Connection ~ 5650 4750
Wire Wire Line
	5300 4750 5300 4250
Wire Wire Line
	5300 3800 5450 3800
Connection ~ 5300 4750
Wire Wire Line
	5450 3800 5700 3800
Connection ~ 5450 3800
Wire Wire Line
	5700 3800 5950 3800
Connection ~ 5700 3800
Wire Wire Line
	5950 3800 6200 3800
Connection ~ 5950 3800
Wire Wire Line
	5300 4250 5550 4250
Connection ~ 5300 4250
Wire Wire Line
	5300 4250 5300 3800
Wire Wire Line
	5550 4250 5800 4250
Connection ~ 5550 4250
Wire Wire Line
	5800 4250 6050 4250
Connection ~ 5800 4250
Wire Wire Line
	6050 4250 6300 4250
Connection ~ 6050 4250
Wire Wire Line
	650  1200 650  3350
Wire Wire Line
	650  1200 1850 1200
Wire Wire Line
	650  3350 2400 3350
Wire Wire Line
	1850 1300 550  1300
Wire Wire Line
	550  1300 550  3500
Wire Wire Line
	550  3500 2250 3500
Wire Wire Line
	7800 5950 7650 5950
Connection ~ 7650 5950
Wire Wire Line
	7650 5950 7650 5750
Wire Wire Line
	7800 5000 7650 5000
Connection ~ 7650 5000
Wire Wire Line
	7650 5000 7650 4800
Wire Wire Line
	7750 4050 7650 4050
Connection ~ 7650 4050
Wire Wire Line
	7650 4050 7650 3850
Wire Wire Line
	7750 3050 7650 3050
Connection ~ 7650 3050
Wire Wire Line
	7650 3050 7650 2850
Wire Wire Line
	7750 1050 7650 1050
Connection ~ 7650 1050
Wire Wire Line
	7650 1050 7650 850 
Wire Wire Line
	7650 1850 7650 2050
Wire Wire Line
	7750 2050 7650 2050
Connection ~ 7650 2050
Wire Wire Line
	7650 2050 7650 2250
$EndSCHEMATC
