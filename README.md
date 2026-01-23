# Neovim Config

A fast and isolated Neovim setup.

## 🚀 Quick Install & Run

**1. Install**
Run this command. It uses process substitution to ensure the interactive prompts (for cleaning up old files) work correctly.

```bash
bash <(curl -sL bit.ly/nvim-config)

```

**2. Launch**
Start Neovim with this configuration:

```bash
NVIM_APPNAME=nvim-kopfdreher nvim

```

*Tip: Add `alias knvim="NVIM_APPNAME=nvim-kopfdreher nvim"` to your shell config so you don't have to type the whole command every time.*

---

## ℹ️ Important Notes

* **Do not pipe to `sh`:** Use the command exactly as shown above. Using `| sh` breaks the script's ability to ask you for confirmation before deleting files.
* **Isolation:** This setup installs to `~/.config/nvim-kopfdreher`, keeping your default Neovim config safe.
