# dotfiles

Work in progress.

- [ ] Atom setup
- [ ] OSX defaults setup
- [ ] Fish setup
  - [ ] Update `pure` theme to not insert newline after <kbd>ctrl</kbd><kbd>+</kbd><kbd>l</kbd>
- [ ] Basic .vimrc (for commit messages etc.)
- [ ] Assets (fonts etc.)
- [ ] Node setup (nvm)
- [ ] Keybindings (OSX, Alfred, SizeUp etc.)

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

### Atom
```bash
./atom/install
```
