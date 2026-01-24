# Neovim Config

A fast and isolated Neovim setup.

## 🛠️ Prerequisites

This config requires **compiledb** to generate build files (`compile_commands.json`) for C/C++ completion.

**1. Check if installed:**
```bash
compiledb --version
```

**2. Install if missing:**

```bash
pip install compiledb
```

---

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
* **Isolation:** This setup installs to `~/.config/nvim-kopfdreher`.
* **C/C++ Projects:** If you open a C/C++ project, run `compiledb make` (or your build command) in your terminal first so the LSP can find your definitions.
