#!/bin/bash

source ../zynthian-sys/zynthian_envars.sh


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

pushd $DIR

        cp -p zynia/mcp23008.h /usr/local/include/mcp23008.h
        cp -p zynia/wiringPi.h /usr/local/include/wiringPi.h
        cp -p zynia/wiringPiI2C.h /usr/local/include/wiringPiI2C.h
        cp -p zynia/ads1115.h /usr/local/include/ads1115.h

	if [ ! -d build ]; then
		mkdir build
	fi
	pushd build

		# Detect headphones amplifier kernel driver
		if lsmod | grep -wq "^snd_soc_tpa6130a2"; then
			export TPA6130_KERNEL_DRIVER_LOADED=1
		else
			export TPA6130_KERNEL_DRIVER_LOADED=0
		fi

		if [ "$1" == "debug" ]; then
			cmake -DCMAKE_BUILD_TYPE=Debug ..
		else
			cmake ..
		fi
		make
	popd
popd
