#!/bin/bash

# Clear screen and display welcome message
clear
echo "⌐■_■ Shihai Karera (formerly known as Gyakuten)"
sleep 3

# Display Windows 11-style loading screen
plymouth --show-splash
sleep 5

# Update and upgrade the system
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# Install necessary packages
sudo apt-get install -y curl wget git zsh python3-pip

# Install Oh My Zsh using curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Python3-pip after Oh My Zsh
sudo apt-get install -y python3-pip

# Install Ollama AI
pip3 install ollama

# Install Fiber AI
pip3 install fiber

# Clone and set up Flipper Zero Fiber AI
git clone https://github.com/flipperzero/fiberai.git /home/pi/flipper_fiberai
cd /home/pi/flipper_fiberai
./install.sh

# Create directory for handshakes
mkdir -p /home/pi/handshakes

# Configure and start Pwnagotchi
sudo systemctl start pwnagotchi

# Create and run startup script
cat <<EOF > /usr/local/bin/shihai_karera.py
#!/usr/bin/env python3

import os

# Clear screen and display welcome message
os.system('clear')
print("⌐■_■ Shihai Karera (formerly known as Gyakuten)")
os.system('sleep 3')

# Display Windows 11-style loading screen
os.system('plymouth --show-splash')
os.system('sleep 5')

# Start Pwnagotchi
os.system('pwnagotchi &')

# Update and upgrade the system
os.system('sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y')

# Start monitoring scripts
os.system('python3 /usr/local/bin/shihai_monitoring.py &')
os.system('sudo systemctl start wpa_supplicant.service')

# Start handshake capturing
os.system('sudo pwnagotchi --start')

EOF

# Make startup script executable
chmod +x /usr/local/bin/shihai_karera.py

# Configure rc.local to run the startup script
sudo sed -i '/exit 0/i /usr/local/bin/shihai_karera.py &' /etc/rc.local

# Display final message
echo "Setup complete! Rebooting now..."
sudo reboot
