#!/bin/bash

led_array_addr="0x46"

red_table=()
green_table=()
blue_table=()

print_index() {
	echo -n $(( (row * 8) + col ))
}

gen_color_table() {
	local color="$1"

	declare -A color_table
	local first_addr=""

	case $color in
		red)
			first_addr="0x00"
			;;
		green)
			first_addr="0x08"
			;;
		blue)
			first_addr="0x10"
			;;
	esac

	for row in {0..7}; do
		for col in {0..7}; do
			index=$(print_index $row $col)
			color_table[$index]=$(printf '0x%02x' $(( first_addr + col )))

			test $color = red && red_table[$index]=${color_table[$index]}
			test $color = green && green_table[$index]=${color_table[$index]}
			test $color = blue && blue_table[$index]=${color_table[$index]}
		done

		first_addr=$(( first_addr + 24 ))
	done
}

gen_color_table red
gen_color_table green
gen_color_table blue

get_led_color_addr() {
	local cell_addr=$(get_led_pos_addr $row $col)
	cell_addr=$(printf '%d' $cell_addr )


	if [ $color = red ]; then
		pos_addr=${red_table[$cell_addr]}

	elif [ $color = green ]; then
		pos_addr=${green_table[$cell_addr]}

	elif [ $color = blue ]; then
		pos_addr=${blue_table[$cell_addr]}
	fi

	printf '0x%02x' $pos_addr
}

get_led_pos_addr() {
	row="$1"
	col="$2"

	printf '0x%02x' $(print_index $row $col)
}

set_color() {
	color="$1"
	pos_addr="$(get_led_pos_addr $2 $3)"
	color_addr="$(get_led_color_addr $color $row $col)"

	write $color_addr $data $mode
}

write() {
	i2cset -f -y 1 $led_array_addr $color_addr ${data:-0x0f} $mode
}

turnoff() {
	local data=""
	data="0x00"
	set_color $1 $2 $3 $data
}
