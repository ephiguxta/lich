source lich.sh

for i in {0..191}; do
	data=$(printf '0x%02x' $i)

	sleep 0.05
	write $data 0x0f

	sleep 0.05
	clean $data 0x00
done
