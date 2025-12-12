# Installation Guide

## Prerequisites

```bash
sudo apt install inotify-tools -y
```

## Quick Install

### Method 1: Use from Cloned Repo (Easiest)
```bash
git clone https://github.com/YOUR_USERNAME/AutoList.git
cd AutoList
chmod +x dir-harvester
./dir-harvester start
```

### Method 2: Install to ~/bin
```bash
# Create bin directory if it doesn't exist
mkdir -p ~/bin

# Copy script
cp dir-harvester ~/bin/
chmod +x ~/bin/dir-harvester

# Add to PATH (if not already - add to ~/.bashrc or ~/.zshrc)
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Use from anywhere
dir-harvester start
```

### Method 3: System-Wide Install
```bash
sudo cp dir-harvester /usr/local/bin/
sudo chmod +x /usr/local/bin/dir-harvester
dir-harvester start
```

## Setup Auto-Start (Optional)

To start automatically on boot using systemd:

```bash
# Create service file
sudo nano /etc/systemd/system/dir-harvester.service
```

**Paste this (replace USERNAME with your username):**
```ini
[Unit]
Description=AutoList Directory Harvester
After=network.target

[Service]
Type=simple
User=USERNAME
ExecStart=/home/USERNAME/bin/dir-harvester daemon
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

**Enable and start:**
```bash
sudo systemctl daemon-reload
sudo systemctl enable dir-harvester
sudo systemctl start dir-harvester

# Check status
sudo systemctl status dir-harvester
```

## First Run

```bash
# Test with manual scan
dir-harvester scan

# Check stats
dir-harvester stats

# Start daemon
dir-harvester start

# Verify it's running
dir-harvester status
```

## File Locations

After installation, these files will be created:

- **Wordlist**: `~/wordlists/Dir-Harvester.txt`
- **Log**: `~/.dir-harvester.log`
- **State**: `~/.dir-harvester-state`

The wordlist directory (`~/wordlists/`) will be created automatically on first run.

## Verify Installation

```bash
# Check if inotify-tools installed
which inotifywait

# Check if script is executable
which dir-harvester

# Test run
dir-harvester status
```

## Uninstall

```bash
# Stop daemon
dir-harvester stop

# Remove script (depending on install method)
rm ~/bin/dir-harvester
# OR
sudo rm /usr/local/bin/dir-harvester

# Remove data files (optional)
rm ~/wordlists/Dir-Harvester.txt
rm ~/.dir-harvester.log
rm ~/.dir-harvester-state

# Remove systemd service (if installed)
sudo systemctl stop dir-harvester
sudo systemctl disable dir-harvester
sudo rm /etc/systemd/system/dir-harvester.service
sudo systemctl daemon-reload
```

## Troubleshooting

**Permission denied**
```bash
chmod +x dir-harvester
```

**inotifywait not found**
```bash
sudo apt install inotify-tools -y
```

**Daemon won't start**
```bash
# Check if already running
dir-harvester status

# Check logs
tail -f ~/.dir-harvester.log

# Try manual scan first
dir-harvester scan
```
