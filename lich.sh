led_array_addr="0x46"

write() {
	data_addr="$1"
	val="$2"
	mode="$3"

	i2cset -f -y 1 $led_array_addr $data_addr $val $mode
}

clean() {
	data_addr="$1"
	val="$2"
	mode="$3"

	i2cset -f -y 1 $led_array_addr $data_addr 0x00 $mode
}
