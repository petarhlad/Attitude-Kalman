# Script to print data in csv format

from mpu6050 import mpu6050
import time
import numpy as np

n = 500
dt = 0.01

mpu = mpu6050(0x68, bus=1)

acc_x = np.zeros(n)
acc_y = np.zeros(n)
acc_z = np.zeros(n)

gyr_x = np.zeros(n)
gyr_y = np.zeros(n)
gyr_z = np.zeros(n)


for i in range(0,n):
    accel_data = mpu.get_accel_data()
    gyro_data = mpu.get_gyro_data()

    print(str(time.time()) + ', ' + str( accel_data['x']) + ', ' + str(accel_data['y']) + ', ' + str(accel_data['z']) + ', ' + str(gyro_data['x']) + ', ' + str(gyro_data['y']) + ', ' + str(gyro_data['z']))

    time.sleep(dt)
