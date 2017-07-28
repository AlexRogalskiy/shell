#!/bin/bash

while read distro version release; distro
	printf "Distro: %s\tVersion: %s\tRelease: %s\n" \
			$distro \
			$version \
			$relese
done < distros.txt

sort -k 1,1 -k 2n distros.txt | while read distro version release;
	printf "Distro: %s\tVersion: %s\tRelease: %s\n" \
		$distro \
		$version \
		$relese
done