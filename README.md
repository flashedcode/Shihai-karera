

---

# Shihai Karera ⌐■_■ (formerly known as Gyakuten)
                 #Official Readme
**Shihai Karera** is an advanced AI-powered WiFi penetration testing and monitoring system built upon Pwnagotchi. With custom enhancements for improved performance, automated processes, and a sleek boot sequence, Shihai Karera is designed to be efficient, fast, and adaptable to different devices.

## Key Features

- **Minimalistic Boot Sequence**: Enjoy a clean, professional startup featuring ASCII art `⌐■_■ Shihai Karera` followed by a Windows 11-like loading screen.
- **AI Integration**: The system optimizes itself for the hardware it’s running on, using AI to fine-tune performance.
- **Automated Processes**: Automated WPA handshake capture, CPU and GPU-accelerated cracking with Hashcat, and device monitoring with tools like Flipper Zero Fiber AI.
- **Real-time Updates**: Automated updates of drivers and software to ensure compatibility and performance improvements.
- **Lightweight & Efficient**: Optimized for low-power devices like Raspberry Pi, with resource-efficient operations.

---

## Getting Started

### 1. Download & Flash the Image

1. **Download the Shihai Karera Image**:
   - Download the latest pre-configured image from the [official releases](https://github.com/jayofelony/pwnagotchi/releases/download/v2.8.9/pwnagotchi-2.8.9-32bit.img.xz).

2. **Flash the Image**:
   - Use **balenaEtcher** (or your preferred flashing tool) to flash the image to your SD card.
   - Insert the SD card into your Raspberry Pi or compatible device.

### 2. First Boot

1. **Power On**: Upon powering on, the system will display the minimal ASCII art: 
   ```
   ⌐■_■ Shihai Karera
   ```
   followed by a Windows 11-style loading screen.

2. **System Initialization**: Shihai Karera will automatically initialize Pwnagotchi, update itself, and start necessary services.

### 3. System Configuration

1. **Configuration File**: Shihai Karera is pre-configured, but you can customize it further by editing the `/etc/pwnagotchi/config.toml` file.
   - **Default Configuration**:
     ```ini
     main.name = "Shihai_Karera"
     main.lang = "en"

     [network.interfaces.wlan0]
     ip = "10.0.0.1"
     netmask = "255.255.255.0"
     gateway = "10.0.0.1"
     dns = "10.0.0.1"

     # AI Configuration
     main.ai.enabled = true
     main.ai.model = "ollama"
     main.ai.brain = "shihai_karera"

     # Device Health Management AI
     main.ai.device_health.enabled = true
     main.ai.device_health.model = "device_health_ai"
     main.ai.device_health.data_path = "/home/pi/device_health_data.json"

     # Hashcat Configuration for WPA2 Cracking
     hashcat.enabled = true
     hashcat.cpu = true                  # Enable CPU cracking
     hashcat.gpu = true                  # Enable GPU cracking
     hashcat.cpu_wordlist = "/home/pi/wordlists/top24million.txt"
     hashcat.gpu_wordlist = "/home/pi/wordlists/top24million.txt"
     hashcat.data_path = "/home/pi/handshakes"

     # Startup Script
     scripts.startup = "/usr/local/bin/shihai_karera.py"

     # Handshake Saving Location
     handshake.directory = "/home/pi/handshakes"
     ```

### 4. Key Commands

1. **Start Pwnagotchi**: The system auto-starts Pwnagotchi, but you can also run it manually with:
   ```bash
   sudo systemctl start pwnagotchi
   ```

2. **Capture WPA Handshake**:
   ```bash
   sudo pwnagotchi --start
   ```

3. **Update the System**:
   ```bash
   sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
   ```

4. **Monitor Device Performance**:
   - Utilize the Flipper Zero integration and other monitoring tools to keep track of the device's health and performance.

### 5. Automating Startup Tasks

Shihai Karera automates key tasks during startup via a custom script. You can modify this script (`/path/to/startup.sh`) if you need to add additional startup routines.

1. **Default Startup Script**:
   ```bash
   #!/bin/bash
   clear
   echo "⌐■_■ Shihai Karera"
   sleep 3
   plymouth --show-splash
   sleep 5

   pwnagotchi &
   sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
   python3 /usr/local/bin/shihai_monitoring.py &
   sudo systemctl start wpa_supplicant.service
   ```

2. **Automate on Boot**:
   The script is automatically run on boot via `rc.local`. If you need to customize it further, you can find it in `/etc/rc.local`.

---

## Advanced Features

### 1. AI-Driven Optimizations
- **Hardware-Specific Tuning**: On first boot, Shihai Karera analyzes the hardware it's running on and adjusts settings for optimal performance.
- **Auto-Updates**: Regular updates to drivers and system files ensure that Shihai Karera stays current with the latest optimizations.

### 2. GPU and CPU-Accelerated Cracking
- **Hashcat Integration**: For high-speed WPA password cracking, Shihai Karera utilizes both CPU and GPU power. The system is configured to use Hashcat with pre-installed wordlists for efficient brute force operations.

### 3. Real-Time Monitoring
- **Flipper Zero Integration**: Shihai Karera includes tools for monitoring device performance and network activity in real-time. Automated reports and alerts can be enabled via configuration.

### 4. Custom Boot Sequence
- **Minimalist Boot Screen**: Displayed on startup, followed by a clean Windows 11-like loading animation.
- **Plymouth Themes**: Easily change or update the boot theme by customizing `plymouth` settings.

---

## Troubleshooting

1. **Logs**: All logs related to Shihai Karera are stored in `/var/log/shihai_karera.log`. This is the first place to check for issues.
2. **Manual Updates**: While the system auto-updates, you can manually trigger updates using:
   ```bash
   sudo apt-get update && sudo apt-get upgrade
   ```
3. **Reset Configuration**: If something goes wrong with the configuration, you can reset the config file by re-flashing the image or restoring a backup of `/etc/pwnagotchi/config.toml`.

---

## Contributing

Shihai Karera is open-source and welcomes contributions. If you have a feature request, bug report, or improvement suggestion, feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/jayofelony/pwnagotchi).

---

## Credits

- **Pwnagotchi**: The original base for Shihai Karera.
- **Jayofelony**: For the 2.8.9 release that powers this system.
- **Ollama AI**: For the AI-powered optimizations that improve attack performance.
- **Flipper Zero Fiber AI**: For advanced device monitoring and system health tools.
- **Open-Source Community**: For ongoing contributions and support in the development of this tool.

---

## License

Shihai Karera is released under the [MIT License](LICENSE). Feel free to use, modify, and distribute the software in accordance with the license terms.

---

This README provides comprehensive guidance on setting up, configuring, and using **Shihai Karera**, ensuring a smooth experience from installation to advanced operations.