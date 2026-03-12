#!/usr/bin/env bash

vcd_file="dump.vcd"
gtkw_file="waves.gtkw"

if [ ! [ -f ${vcd_file} ] ]; then
   echo "Could not find VCD file ${vcd_file} -- exiting!"
   exit -1;
fi

gtkwave --save=${gtkw_file} ${vcd_file} &
