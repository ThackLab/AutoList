# Customization Guide

## Change Monitored Directories

Edit the script to monitor your preferred directories:

```bash
nano dir-harvester  # or vim, code, etc.
```

**Find this section (around line 11):**
```bash
WATCH_DIRS=(
    ~/ctf
    ~/Desktop
    ~/Downloads
    ~/Documents
)
```

**Add your directories:**
```bash
WATCH_DIRS=(
    ~/ctf
    ~/Desktop
    ~/Downloads
    ~/Documents
    ~/htb                     # HackTheBox
    ~/thm                     # TryHackMe
    ~/pentesting/targets      # Custom directory
    ~/bug-bounty/recon        # Bug bounty work
    /mnt/shared/scans         # Network share
)
```

**Restart daemon to apply:**
```bash
dir-harvester stop
dir-harvester start
```

## Change Output Wordlist Location

**Find this line (around line 6):**
```bash
WORDLIST=~/wordlists/Dir-Harvester.txt
```

**Change to your preferred location:**
```bash
WORDLIST=~/my-wordlists/custom-dirs.txt
# OR
WORDLIST=~/.config/wordlists/discovered.txt
# OR
WORDLIST=/opt/wordlists/harvested-dirs.txt
```

## Add Exclusion Patterns

Exclude specific patterns from being added to your wordlist.

**Find this section (around line 19):**
```bash
EXCLUDE_PATTERNS=(
    "css"
    "js"
    "javascript"
    "images"
    "img"
    "static"
    "fonts"
    "icons"
    "vendor"
    "node_modules"
    "bower_components"
    ".git"
    ".svn"
    "dist"
    "build"
    "cache"
)
```

**Add your patterns:**
```bash
EXCLUDE_PATTERNS=(
    # ... existing patterns ...
    "assets"          # Exclude /assets
    "uploads"         # Exclude /uploads  
    "media"           # Exclude /media
    "tmp"             # Exclude /tmp
    "backup"          # Exclude anything with "backup"
)
```

## Change Log Location

**Find this line (around line 8):**
```bash
LOG_FILE=~/.dir-harvester.log
```

**Change to:**
```bash
LOG_FILE=~/logs/dir-harvester.log
# OR
LOG_FILE=/var/log/dir-harvester.log  # requires sudo permissions
```

## Modify File Age Threshold

By default, only files modified in the last 7 days are scanned.

**Find this line (around line 187):**
```bash
\) -mtime -7 2>/dev/null)
```

**Change the number:**
```bash
\) -mtime -30 2>/dev/null)  # Last 30 days
\) -mtime -1 2>/dev/null)   # Last 24 hours
```

## Add Support for New Tools

To add support for a new directory enumeration tool:

**1. Add filename pattern to line 133:**
```bash
if ! echo "$file" | grep -qE "(gobuster|dirb|feroxbuster|ferox|dirsearch|ffuf|newtool).*\.txt$"; then
```

**2. Add parsing logic around line 75:**
```bash
elif grep -q "NewToolSignature" "$file" 2>/dev/null; then
    # NewTool: /path/to/directory [200]
    grep -E "your-regex-pattern" "$file" | awk '{print $1}' | sed 's|^/||; s|/$||' >> $temp_file
```

**3. Update the help text (line 346):**
```bash
echo "Supported tools: gobuster, dirb, feroxbuster, ffuf, dirsearch, newtool"
```

## Examples

### Minimal Setup (Only ~/ctf)
```bash
WATCH_DIRS=(
    ~/ctf
)
```

### Comprehensive Setup (All common directories)
```bash
WATCH_DIRS=(
    ~/ctf
    ~/htb
    ~/thm
    ~/vulnhub
    ~/pentesting
    ~/bug-bounty
    ~/Desktop
    ~/Downloads
    ~/Documents
    ~/recon
)
```

### Exclude Common False Positives
```bash
EXCLUDE_PATTERNS=(
    "css"
    "js"
    "javascript"
    "images"
    "img"
    "static"
    "fonts"
    "icons"
    "vendor"
    "node_modules"
    "bower_components"
    ".git"
    ".svn"
    "dist"
    "build"
    "cache"
    "assets"
    "uploads"
    "media"
    "tmp"
    "temp"
    "backup"
    "old"
    "test"
)
```

## Tips

- Always restart the daemon after making changes
- Test with `dir-harvester scan` before starting the daemon
- Check logs if directories aren't being added: `tail -f ~/.dir-harvester.log`
- Use absolute paths or `~/` for directories (avoid relative paths)
