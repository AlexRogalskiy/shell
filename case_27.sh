#!/bin/bash

arr=(f e d c b a m n y)
echo "Initial array: ${a[@]}"
arr_sorted=($(for i in "${a[@]}"; do
	echo $i
done | sort))
echo "Sorted array: ${arr_sorted[@]}"