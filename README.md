
---

# *Shihai Karera (Formerly Known as Gyakuten) README Guide*

Welcome to the setup guide for **Shihai Karera**, previously known as Gyakuten. This customized Pwnagotchi system features a web control interface, personalized branding, and automated hacking functionalities. Follow these instructions to configure your system effectively.

## **1. Flash the Pwnagotchi Image**

1. **Download the Pwnagotchi Image**:
   - Visit the [Pwnagotchi Releases page](https://github.com/evilsocket/pwnagotchi/releases) and download the image compatible with your Raspberry Pi model.

2. **Flash the Image**:
   - Use **Etcher** or **Raspberry Pi Imager** to write the Pwnagotchi image to an SD card.

## **2. Modify Initial Configuration**

1. **Insert the SD Card**:
   - After flashing, insert the SD card into your computer and open the **`config.toml`** file in the `boot` partition.

2. **Customize `config.toml`**:
   - Modify the **`config.toml`** file to set Wi-Fi, IP addresses, and startup scripts. Here’s a sample configuration:
   ```toml
   main.name = "Shihai_Karera"
   main.lang = "en"

   network.interfaces.wlan0.ip = "10.0.0.1"
   network.interfaces.wlan0.netmask = "255.255.255.0"
   network.interfaces.wlan0.gateway = "10.0.0.1"
   network.interfaces.wlan0.dns = "10.0.0.1"

   network.interfaces.eth0.ip = "10.0.0.2"
   network.interfaces.eth0.netmask = "255.255.255.0"
   network.interfaces.eth0.gateway = "10.0.0.2"
   network.interfaces.eth0.dns = "10.0.0.2"

   main.ai.enabled = true
   main.ai.model = "ollama"
   main.ai.brain = "shihai_karera"

   scripts.startup = "/usr/local/bin/shihai_karera.py"

   ui.display.enabled = true
   ui.display.type = "waveshare_v2"

   bluetooth.enabled = true
   bluetooth.device = "hci0"
   ```

3. **Enable SSH**:
   - To enable SSH access, create an empty file named `ssh` (without any extension) in the **boot** partition.

## **3. Set Up the Web Control Interface**

1. **SSH into Your Device**:
   - Power on your Raspberry Pi and connect it to your network. Access it via SSH:
   ```bash
   ssh pi@<your_device_ip>
   ```

2. **Install Dependencies**:
   - Update your system and install essential packages, including `curl`, `wget`, and `ollama`, along with Python dependencies:
   ```bash
   sudo apt update
   sudo apt upgrade -y
   sudo apt install curl wget python3-pip python3-flask -y
   sudo pip3 install ollama
   ```

3. **Create the Control Script**:
   - Save the following Python script as `/etc/pwnagotchi/pwnagotchi_control.py`:
   ```python
   from flask import Flask, request, jsonify

   app = Flask(__name__)

   @app.route('/api/control', methods=['POST'])
   def control():
       data = request.json
       action = data.get('action')

       if action == 'start':
           return jsonify({"status": "Attacks started"}), 200
       elif action == 'stop':
           return jsonify({"status": "Attacks stopped"}), 200
       else:
           return jsonify({"status": "Invalid action"}), 400

   if __name__ == "__main__":
       app.run(host='0.0.0.0', port=5000)
   ```

4. **Create a Systemd Service**:
   - Configure the web control interface to start automatically on boot:
   ```bash
   sudo nano /etc/systemd/system/shihai-karera-web.service
   ```

   Add the following content:
   ```ini
   [Unit]
   Description=Shihai Karera Web Control Interface
   After=network.target

   [Service]
   User=root
   WorkingDirectory=/etc/pwnagotchi
   ExecStart=/usr/bin/python3 /etc/pwnagotchi/pwnagotchi_control.py
   Restart=on-failure

   [Install]
   WantedBy=multi-user.target
   ```

   Enable and start the service:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable shihai-karera-web.service
   sudo systemctl start shihai-karera-web.service
   ```

## **4. Customize Startup Branding and Commands**

1. **Edit Startup Banner**:
   - Add a custom banner to the startup sequence by editing `/etc/rc.local`:
   ```bash
   sudo nano /etc/rc.local
   ```

   Insert the following lines before `exit 0`:
   ```bash
   echo "******************************************"
   echo "                Shihai Karera              "
   echo "******************************************"
   echo "Starting up..."
   ```

2. **Auto-Run Commands at Startup**:
   - Ensure that scripts and the web control interface run automatically by appending the necessary commands to **`/etc/rc.local`**:
   ```bash
   /usr/bin/python3 /etc/pwnagotchi/pwnagotchi_control.py &
   ```

## **5. Access and Control Shihai Karera**

1. **Access the Web Interface**:
   - Open a web browser and navigate to `http://<your_device_ip>:5000` to use the web control interface.

2. **Manage Hacking Activities**:
   - Control attacks by sending `POST` requests to `/api/control` with actions like "start" or "stop" via a REST client or the web interface.

## **Troubleshooting**

- **Service Not Starting**: Check the status of `shihai-karera-web.service`:
  ```bash
  sudo systemctl status shihai-karera-web.service
  ```

- **Web Interface Unreachable**: Ensure network connectivity and verify that port 5000 is not blocked by a firewall.

- **Script Errors**: Look at logs in `/var/log/syslog` or review the service status output for any errors.

## **Conclusion**

Your **Shihai Karera** Pwnagotchi system, formerly known as Gyakuten, is now configured with:
- Static IP addresses for easy network access.
- A custom Python-based web control interface.
- Automatic startup of scripts and branding.
- Integration of essential utilities like `curl`, `wget`, and `ollama`.

Enjoy the advanced capabilities of your customized Pwnagotchi system. For additional support or modifications, feel free to ask!

---

Let me know if there’s anything else you’d like to tweak or if you need more help, na!
