#!/bin/bash

# Configuration
REPO_URL="https://github.com/Kopfdreher/nvim-config.git"
APP_NAME="nvim-kopfdreher"
CONFIG_DIR="$HOME/.config/$APP_NAME"
CACHE_DIR="$HOME/.cache/$APP_NAME"
DATA_DIR="$HOME/.local/share/$APP_NAME"
STATE_DIR="$HOME/.local/state/$APP_NAME"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}   Kopfdreher's Neovim Eval Setup        ${NC}"
echo -e "${BLUE}=========================================${NC}"

# 1. Check/Install compiledb (User-local install)
# ---------------------------------------------------------
echo -e "${BLUE}[+] Checking for compiledb...${NC}"
export PATH="$HOME/.local/bin:$PATH"

if ! command -v compiledb &> /dev/null; then
    echo -e "    compiledb not found. Installing via pip3 (local)..."
    if command -v pip3 &> /dev/null; then
        pip3 install --user compiledb --quiet
        echo -e "${GREEN}    compiledb installed successfully!${NC}"
    else
        echo -e "${RED}    Warning: pip3 not found. Skipping compiledb install.${NC}"
    fi
else
    echo -e "${GREEN}    compiledb is already installed.${NC}"
fi

# 2. Check Neovim
# ---------------------------------------------------------
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}Error: Neovim is not installed on this machine.${NC}"
    exit 1
fi

# 3. Setup/Update the Config
# ---------------------------------------------------------
if [ -d "$CONFIG_DIR" ]; then
    echo -e "${BLUE}[+] Updating config...${NC}"
    git -C "$CONFIG_DIR" pull -q
else
    echo -e "${BLUE}[+] Cloning configuration...${NC}"
    git clone --depth 1 "$REPO_URL" "$CONFIG_DIR" -q
fi

# 4. Keyboard Tweaks (Caps -> Escape)
# ---------------------------------------------------------
echo -e "${BLUE}[+] Setting CapsLock to Escape...${NC}"
setxkbmap -option caps:escape

# 5. Run Neovim in Sandbox Mode
# ---------------------------------------------------------
echo -e "${GREEN}[+] Starting Neovim...${NC}"
echo -e "    (Press Enter if prompted)"
export NVIM_APPNAME="$APP_NAME"
nvim "$@"

# 6. Cleanup Prompt
# ---------------------------------------------------------
echo -e "${BLUE}=========================================${NC}"
read -p "Evaluation done? Delete all config/cache files? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}[+] Cleaning up files...${NC}"
    rm -rf "$CONFIG_DIR" "$CACHE_DIR" "$DATA_DIR" "$STATE_DIR"
    
    echo -e "${BLUE}[+] Resetting Keyboard...${NC}"
    setxkbmap -option # Resets CapsLock back to normal
    
    echo -e "${GREEN}All traces removed. Have a nice day!${NC}"
else
    echo -e "${BLUE}Files kept. Resetting keyboard only.${NC}"
    setxkbmap -option
fi
