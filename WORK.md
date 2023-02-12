# Updated installation instructions

## Clone Git repository

- Generate new SSH keys according to [this guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- Install ~XCode command line utilities when prompted

```sh
git clone git@github.com:mrwest808/dotfiles.git ~/.dotfiles
```

## Install Homebrew etc.

- Install `homebrew` according to the [latest installation instructions](https://brew.sh)

```sh
# Install system things~
brew install neovim tmux volta z zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting
# Install applications
brew install --cask alacritty firefox raycast spotify visual-studio-code
# Install these work-related things if relevant
brew install colima maven
brew install --cask corretto
```

## Run install scripts in this repo

```sh
# Setup Git config & ignore
./git/install
# Setup zsh
./zsh/install
# Setup macOS settings
./macos/install
```

Restart computer afterwards.

## Configure terminal

- `touch ~/.hushlogin`
- Clone `.config`-related repositories (Alacritty, Neovim, etc.)
- Install Nerd-patched font(s)
- Install [powerline10k](https://github.com/romkatv/powerlevel10k)
  - Pure, Original, Right, No (time), 2 lines, Sparse, Transient prompt, Verbose

## Tweak System Settings

- Change CAPS LOCK modifier to Esc
- Change the following keyboard shortcuts
  - Move focus to the menu bar: `shift+cmd+'`
  - Move focus to next window: `cmd+§`
  - Move focus to status menus: `alt+cmd+'`
- Disable Spotlight
- Set menu bar icons in correct order
  - Wi-Fi, Bluetooth, Battery

## Setup Raycast

- Setup Raycast, give it correct permissions and import settings file
- Set keyboard shortcut to `cmd+space`

## Install globals with Volta

```sh
volta install node pnpm@latest
# If applicable
volta install skal yarn@1
```

Copy `skal`-related files from another computer.

## Setup IntelliJ Ultimate

- Ensure `.ideavim` is symlinked to `~`.
- Enable Settings Sync in IntelliJ's settings (choose "get settings")
