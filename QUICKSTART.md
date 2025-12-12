# Quick Reference - AutoList

## First Time Setup
```bash
# 1. Install dependencies
sudo apt install inotify-tools -y

# 2. Run setup script
chmod +x setup.sh
./setup.sh

# 3. Start daemon
./dir-harvester start
```

## Daily Commands
```bash
dir-harvester start      # Start monitoring
dir-harvester stop       # Stop monitoring
dir-harvester status     # Check if running
dir-harvester stats      # View statistics
dir-harvester scan       # Manual scan once
```

## File Locations
- **Wordlist**: `~/wordlists/Dir-Harvester.txt`
- **Log**: `~/.dir-harvester.log`
- **State**: `~/.dir-harvester-state`

## Supported Tools
- gobuster
- dirb
- feroxbuster
- ffuf
- dirsearch

## File Naming
Save scan outputs as:
- `target-gobuster.txt`
- `site-dirb.txt`
- `webapp-ferox.txt`
- `api-ffuf.txt`

## Monitored Directories (Default)
- `~/ctf/`
- `~/Desktop/`
- `~/Downloads/`
- `~/Documents/`

See CUSTOMIZE.md to change these.

## Quick Test
```bash
# Create test file
echo "==> DIRECTORY: http://test.com/admin/" > ~/Desktop/test-dirb.txt

# Check if processed (wait 1 second)
grep "admin" ~/wordlists/Dir-Harvester.txt
```

## Troubleshooting
```bash
# Check logs
tail -f ~/.dir-harvester.log

# Verify inotify-tools
which inotifywait

# Kill stuck process
pkill -f "dir-harvester daemon"

# Fresh start
dir-harvester stop
dir-harvester start
```
