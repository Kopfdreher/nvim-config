# Neovim Config

A fast and simple setup script for my Neovim configuration.

## 🚀 Quick Install

Run this command in your terminal to install. This method ensures that the interactive prompts (asking to clean up old files) work correctly.

```bash
bash <(curl -sL bit.ly/nvim-config)

```

## ℹ️ What this script does

1. **Clean Install:** It will ask if you want to delete your existing Neovim configuration (`~/.config/nvim`) and data (`~/.local/share/nvim`) to ensure a fresh start.
2. **Setup:** Downloads the configuration and installs the package manager.

> **⚠️ Important:** Please use the command above exactly as written.
> Do **not** use `curl ... | sh`. The pipe method breaks the interactive prompts, preventing you from confirming the cleanup step.

```

### What I added:
* **The Command:** Prominently displayed.
* **The "Why":** A specific note explaining *why* they shouldn't use the pipe (`|`) method, addressing the issue you faced earlier.
* **Transparency:** Briefly lists that it touches `.config` and `.local` folders so users know what is happening to their system.

**Would you like me to create a "Manual Installation" section for people who don't like running curl scripts?**

```
