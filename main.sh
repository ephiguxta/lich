#!/bin/bash
source lich.sh

colors=(red green blue)

for row in {0..7}; do
	for col in {0..7}; do
		actual_color="$(( ((row * 8) + col) % 3 ))"
		color="${colors[$actual_color]}"

		set_color "blue" "$row" "$col"
		sleep 0.06
		turnoff "blue" "$row" "$col"
		sleep 0.06
	done
done
