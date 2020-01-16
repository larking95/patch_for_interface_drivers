#!/bin/bash
modprobe dpg0100
modprobe cp3100
modprobe cp3300
modprobe cp6204

modprobe dpg0101
dpg0101 -s 3100
modprobe dpg0101
dpg0101 -s 3300
modprobe dpg0101
dpg0101 -s 6204

insmod /usr/realtime/modules/rtai_hal.ko
insmod /usr/realtime/modules/rtai_sched.ko
