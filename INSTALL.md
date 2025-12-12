# Dir Harvester - Installation & Usage Guide

## Quick Start

### 1. Install the script
```bash
# Copy to your projects directory
sudo cp dir-harvester-fixed /home/mingy/My-Projects/dir-harvester
sudo chmod +x /home/mingy/My-Projects/dir-harvester
```

### 2. Test manually first
```bash
# Run a single scan to test
/home/mingy/My-Projects/dir-harvester scan

# Check stats
/home/mingy/My-Projects/dir-harvester stats
```

### 3. Start daemon (Option A: Simple)
```bash
# Start in background
/home/mingy/My-Projects/dir-harvester start

# Check status
/home/mingy/My-Projects/dir-harvester status

# Stop when needed
/home/mingy/My-Projects/dir-harvester stop
```

### 4. Start daemon (Option B: Systemd - Auto-start on boot)
```bash
# Install systemd service
sudo cp dir-harvester.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable dir-harvester
sudo systemctl start dir-harvester

# Check status
sudo systemctl status dir-harvester

# View logs
journalctl -u dir-harvester -f
```

## Supported Tools

The script automatically detects and parses output from:
- **Gobuster**: `/admin (Status: 200)`
- **Dirb**: `==> DIRECTORY:` and `CODE:200` lines  
- **Feroxbuster**: `200 GET ... http://url/admin`
- **ffuf**: `admin [Status: 200, Size: 1234]`
- **Dirsearch**: `[12:34:56] 200 - /admin`

## File Naming

Save your scan outputs with the tool name in the filename:
- `target-gobuster.txt`
- `target-dirb.txt`
- `target-feroxbuster.txt` or `target-ferox.txt`
- `target-ffuf.txt`
- `target-dirsearch.txt`

**Monitored directories** (searches recursively):
- `~/ctf/` (and all subdirectories)
- `~/Desktop/`
- `~/Downloads/`
- `~/Documents/`

To add more directories, edit `WATCH_DIRS` array in the script.

## Output

**Wordlist**: `~/Desktop/found_dirs.txt`
**Log file**: `~/Desktop/dir-harvester.log`
**State file**: `~/.dir-harvester-state`

## Excluded Patterns

The script automatically filters out:
- Static asset directories (css, js, images, fonts, icons)
- Build directories (node_modules, vendor, dist, build)
- Version control (.git, .svn)
- Files with extensions (only keeps directories)

## Troubleshooting

### Daemon not starting?
```bash
# Check if already running
pgrep -f "dir-harvester daemon"

# Kill any existing instances
pkill -f "dir-harvester daemon"

# Try starting again
/home/mingy/My-Projects/dir-harvester start
```

### Not finding directories?
```bash
# Run manual scan with verbose output
/home/mingy/My-Projects/dir-harvester scan

# Check log file
tail -f ~/Desktop/dir-harvester.log

# Verify file naming matches patterns in monitored directories
ls ~/ctf/*{gobuster,dirb,ferox,ffuf,dirsearch}*.txt
ls ~/Desktop/*{gobuster,dirb,ferox,ffuf,dirsearch}*.txt
ls ~/Downloads/*{gobuster,dirb,ferox,ffuf,dirsearch}*.txt
```

### Test directory extraction
```bash
# Create test file (any monitored directory works)
echo "==> DIRECTORY: http://test.com/admin/" > ~/Desktop/test-dirb.txt

# Run manual scan
/home/mingy/My-Projects/dir-harvester scan

# Check if "admin" was added
grep "admin" ~/Desktop/found_dirs.txt
```
