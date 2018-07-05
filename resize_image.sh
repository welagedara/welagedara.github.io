#!/bin/bash

# Prerequisite 
# 1. ImageMagick

IMAGE=$1

convert ./artifacts/$IMAGE -resize 600 ./artifacts/600/$IMAGE
convert ./artifacts/$IMAGE -resize 850 ./artifacts/850/$IMAGE
convert ./artifacts/$IMAGE -resize 1200 ./artifacts/1200/$IMAGE