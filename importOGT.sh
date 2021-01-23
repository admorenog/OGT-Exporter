#!/bin/bash
./importOGT.awk -n image.ogt
convert image.ppm image.png
