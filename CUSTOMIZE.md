# Customizing Monitored Directories

The script monitors multiple directories recursively by default:
```bash
WATCH_DIRS=(
    ~/ctf
    ~/Desktop
    ~/Downloads
    ~/Documents
)
```

## Add More Directories

Edit the script and add to the array:

```bash
nano /home/mingy/My-Projects/dir-harvester

# Add your directories to WATCH_DIRS array:
WATCH_DIRS=(
    ~/ctf
    ~/Desktop
    ~/Downloads
    ~/Documents
    ~/htb                    # Add HackTheBox directory
    ~/thm                    # Add TryHackMe directory  
    ~/pentesting/boxes       # Add custom pentesting directory
    /mnt/shared/scans        # Add network share
)
```

Then restart the daemon:
```bash
/home/mingy/My-Projects/dir-harvester stop
/home/mingy/My-Projects/dir-harvester start
```

## How It Works

- Searches **recursively** in all directories and subdirectories
- Only processes files from **last 7 days** (modify `-mtime -7` to change)
- Matches filenames containing: `gobuster`, `dirb`, `feroxbuster`, `ferox`, `ffuf`, `dirsearch`
- Files must have `.txt` extension

## Examples

All these locations will be scanned:
```
~/ctf/box1/scan-gobuster.txt          ✓
~/Desktop/target-ferox.txt             ✓
~/Downloads/www-ffuf-results.txt       ✓
~/ctf/deep/nested/dir/dirb-scan.txt    ✓
~/Documents/pentest/gobuster.txt       ✓
```

## Performance

The script is lightweight:
- Runs every 5 minutes
- Only processes new/changed files
- Skips already-processed files using hash tracking
