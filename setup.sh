#!/bin/bash

echo "==================================="
echo "AutoList - Quick Setup"
echo "==================================="
echo ""

# Check for inotify-tools
if ! command -v inotifywait &> /dev/null; then
    echo "❌ inotify-tools not installed"
    echo "Install with: sudo apt install inotify-tools -y"
    exit 1
fi

echo "✓ inotify-tools found"

# Make executable
chmod +x dir-harvester
echo "✓ Made dir-harvester executable"

# Create wordlist directory
mkdir -p ~/wordlists
echo "✓ Created ~/wordlists directory"

# Test run
echo ""
echo "Testing..."
./dir-harvester scan

echo ""
echo "==================================="
echo "Setup complete!"
echo "==================================="
echo ""
echo "Quick commands:"
echo "  ./dir-harvester start    # Start daemon"
echo "  ./dir-harvester status   # Check status"
echo "  ./dir-harvester stats    # View statistics"
echo ""
echo "Your wordlist: ~/wordlists/Dir-Harvester.txt"
echo "Log file: ~/.dir-harvester.log"
echo ""
