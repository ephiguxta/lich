#!/bin/bash

RESET=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)

for row in {1..24}; do
	for col in {1..8}; do
		cell=$(( ((row - 1) * 8) + (col - 1) ))
		opt=$(( (cell/ 8) % 3 ))

		case $opt in
			0)
				echo -n "${RED} $(printf '0x%02x ' $cell) ${RESET}"
				;;
			1)
				echo -n "${GREEN} $(printf '0x%02x ' $cell) ${RESET}"
				;;
			2)
				echo -n "${BLUE} $(printf '0x%02x ' $cell) ${RESET}"
				;;
		esac
	done

	echo ""
done
