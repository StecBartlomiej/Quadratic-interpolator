#! /usr/bin/env bash

if [ -f coeffs.txt ]; then
    rm coeffs.txt
fi

octave approx.m |& tee coeffs.txt

# optionally, use optimized coeffs:
# octave approx_opt.m |& tee coeffs.txt

octave print_coeffs.m |& tee hex_coeffs.txt

