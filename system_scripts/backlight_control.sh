#!/bin/bash

if [ "$1" = up ];then
    light -A 1 -s sysfs/backlight/nvidia_wmi_ec_backlight && light -A 1
fi

if [ "$1" = down ];then
    light -U 1 -s sysfs/backlight/nvidia_wmi_ec_backlight && light -U 1
fi
