# AutoList - Directory Harvester

**Automatically build custom directory wordlists from your penetration testing scans.**

AutoList monitors your directories in real-time and extracts discovered directories from tool outputs (gobuster, dirb, feroxbuster, ffuf, dirsearch), building a comprehensive custom wordlist for future scans.

## Features

- 🔥 **Live Monitoring** - Real-time file watching with `inotify`
- 🎯 **Multi-Tool Support** - Works with gobuster, dirb, feroxbuster, ffuf, dirsearch
- 🚀 **Instant Processing** - Processes files the moment they're created
- 🔄 **Smart Deduplication** - Maintains unique directory list
- 🎭 **Intelligent Filtering** - Automatically excludes static assets, build directories
- 📊 **Recursive Search** - Scans all subdirectories
- 💾 **State Tracking** - Never processes the same file twice
- 🎮 **Easy Management** - Simple `start`, `stop`, `status` commands

## Quick Start

```bash
# Install dependencies
sudo apt install inotify-tools -y

# Clone repo
git clone https://github.com/YOUR_USERNAME/AutoList.git
cd AutoList

# Make executable
chmod +x dir-harvester

# Run manual scan
./dir-harvester scan

# Start daemon
./dir-harvester start
```

## Installation

### Option 1: Local Install
```bash
# Copy to your projects directory
cp dir-harvester ~/bin/dir-harvester
chmod +x ~/bin/dir-harvester

# Add ~/bin to PATH if not already (add to ~/.bashrc or ~/.zshrc)
export PATH="$HOME/bin:$PATH"
```

### Option 2: System-Wide Install
```bash
sudo cp dir-harvester /usr/local/bin/
sudo chmod +x /usr/local/bin/dir-harvester
```

### Option 3: Run from Repo
```bash
# Just use it directly
./dir-harvester start
```

## Usage

### Basic Commands
```bash
dir-harvester start      # Start daemon (background)
dir-harvester stop       # Stop daemon
dir-harvester status     # Check if running
dir-harvester scan       # Manual scan once
dir-harvester stats      # Show statistics
```

### File Naming Convention
Save your scan outputs with the tool name in the filename:
```
target-gobuster.txt
10.10.10.5-dirb.txt
webapp-feroxbuster.txt
api-ffuf.txt
example.com-dirsearch.txt
```

### Default Configuration

**Output Wordlist:** `~/wordlists/Dir-Harvester.txt`

**Monitored Directories:**
- `~/ctf/` (and all subdirectories)
- `~/Desktop/`
- `~/Downloads/`
- `~/Documents/`

**Log File:** `~/.dir-harvester.log`

## Supported Tools

| Tool | Format Detected |
|------|----------------|
| Gobuster | `/admin (Status: 200)` |
| Dirb | `==> DIRECTORY:` and `CODE:200` |
| Feroxbuster | `200 GET ... http://url/admin` |
| ffuf | `admin [Status: 200, Size: 1234]` |
| Dirsearch | `[12:34:56] 200 - /admin` |

## Customization

Want to monitor different directories or exclude different patterns? See [CUSTOMIZE.md](CUSTOMIZE.md)

## Example Workflow

```bash
# 1. Start the daemon
dir-harvester start

# 2. Run your normal scans (daemon picks them up automatically)
gobuster dir -u http://target.com -w /usr/share/wordlists/common.txt -o target-gobuster.txt
feroxbuster -u http://target.com -o target-ferox.txt

# 3. Check your growing wordlist
wc -l ~/wordlists/Dir-Harvester.txt
cat ~/wordlists/Dir-Harvester.txt

# 4. Use your custom wordlist in future scans
gobuster dir -u http://newtarget.com -w ~/wordlists/Dir-Harvester.txt
```

## How It Works

1. **Monitors** configured directories using `inotifywait`
2. **Detects** when scan output files are created/modified
3. **Extracts** directory names from tool-specific formats
4. **Filters** out static assets and build directories
5. **Deduplicates** and adds to master wordlist
6. **Tracks** processed files to avoid reprocessing

## Troubleshooting

### Daemon won't start
```bash
# Check if inotify-tools installed
which inotifywait

# Install if missing
sudo apt install inotify-tools -y
```

### Not finding directories
```bash
# Check log file
tail -f ~/.dir-harvester.log

# Verify file naming
ls ~/*{gobuster,dirb,ferox,ffuf,dirsearch}*.txt

# Run manual scan to test
dir-harvester scan
```

### Test extraction
```bash
# Create test file
echo "==> DIRECTORY: http://test.com/admin/" > ~/Desktop/test-dirb.txt

# Check if processed (wait 1 second)
grep "admin" ~/wordlists/Dir-Harvester.txt
```

## Requirements

- Linux (Debian/Ubuntu/Kali)
- `inotify-tools`
- Bash 4.0+

## License

MIT License - See [LICENSE](LICENSE) file

## Contributing

Contributions welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests

## Author

Built for penetration testers, by penetration testers.

---

**⭐ If this tool helps you, give it a star!**
