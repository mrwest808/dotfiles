# dotfiles

- [ ] Finish nvm setup
- [ ] Add keybindings (system, Alfred, SizeUp etc.)

## Installation

```bash
# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Homebrew Bundle
brew tap Homebrew/bundle

# Clone dotfiles repository
git clone git@github.com:mrwest808/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install brew dependencies
brew bundle
```

After that, `cd` into the directories and run the `install` scripts.

## Misc

### Map CAPS LOCK ⇪ to ESCAPE ⎋
Supported natively in macOS since Sierra 10.12.1, change in System Settings >
Modifier Keys...

### Use `sudo` without a password
Add `NOPASSWD:` in `/etc/sudoers`, e.g.

```bash
root	ALL = (ALL) NOPASSWD: ALL
```
