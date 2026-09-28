upload() {
	tmux send-keys -t arduino-cli:3 C-c

	arduino-cli compile --upload

	tmux send-keys -t arduino-cli:3 "arduino-cli monitor -p /dev/ttyUSB0 -c baudrate=115200" C-m
}
