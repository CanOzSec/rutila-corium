#!/bin/bash

mkdir /opt/symlinks/
export symlinksToCreate=$(docker run --log-driver=none -a stdout --rm rutila-corium ls -l /opt/symlinks | awk '{print $9}')


for i in $symlinksToCreate; do
	echo $i;
	ln -sf $PWD/wrapper.py /opt/symlinks/$i;
done
