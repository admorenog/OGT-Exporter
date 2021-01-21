#/bin/bash

convert rick.jpg txt: | awk -f ./exportOGT.awk > image.ogt
