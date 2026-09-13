#!/usr/bin/env bash

echo 2400 | sudo tee /sys/class/backlight/intel_backlight/brightness
