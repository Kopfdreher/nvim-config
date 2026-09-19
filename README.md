# Neovim Config

A fast and isolated Neovim setup.

## 🚀 Quick Install & Run

**1. Install**
Run this command. It uses process substitution to ensure the interactive prompts work correctly.

```bash
bash <(curl -sL bit.ly/nvim-config)
```

**2. Launch**
Start Neovim with this configuration:

```bash
NVIM_APPNAME=nvim-kopfdreher nvim
```

*Tip: Add `alias knvim="NVIM_APPNAME=nvim-kopfdreher nvim"` to your shell config.*

---

## ℹ️ Important Notes

* **Do not pipe to `sh`:** Use the command exactly as shown (`bash <(...)`). Using `| sh` breaks the confirmation prompt.
* **Isolation:** This setup installs to `~/.config/nvim-kopfdreher` and will not interfere with your main Neovim configuration.
* **Auto Session:** Sessions are automatically saved and restored. When you reopen a folder, your windows and buffers will be exactly as you left them.
* **C/C++ Projects:** For full LSP support (go-to-definition, etc.), ensure a `compile_commands.json` file exists in your project root.
