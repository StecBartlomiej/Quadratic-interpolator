#!/usr/bin/env bash

rm -rf run-verilator.log

TOP_DIR="${HOME}/new_intel/"
ACT_DIR="${TOP_DIR}/libs/ac_types/include"
CPP_DIR="${TOP_DIR}/c++-model"
RTL_DIR="${TOP_DIR}/rtl-model"

echo "--------------------------------------------------------------------------------"
echo "Compiling with 'verilator' ..."
echo "--------------------------------------------------------------------------------"

top_module="quadra_top"

verilator \
    --cc \
    -CFLAGS "-std=c++17 -I${ACT_DIR} -I${CPP_DIR}" \
    ${CPP_DIR}/Quadra.cpp \
    sim_main.cpp \
    --exe \
    --build \
    --timing \
    --trace \
    -j 0 \
    -Wall \
    -Wno-UNUSEDSIGNAL \
    -Wno-UNUSEDPARAM \
    -Wno-WIDTHTRUNC \
    -Wno-WIDTHEXPAND \
    \
    --error-limit 20 \
    --timescale 1ps/1ps \
    --timescale-override 1ps/1ps \
    --top-module ${top_module} \
    \
    +define+NOFLOPDELAY=1 \
    \
    +incdir+${RTL_DIR} \
    +incdir+${CPP_DIR} \
    \
    +1800-2009ext+vs \
    ${RTL_DIR}/quadra_top.vs \
    ${RTL_DIR}/square.vs \
    ${RTL_DIR}/lut.vs \
    ${RTL_DIR}/quadra.vs

echo "--------------------------------------------------------------------------------"
echo "... done with 'verilator'."
echo "--------------------------------------------------------------------------------"
