# Installation

Run the `./install` script to symlink files and directories.

## Neovim

Ensure neovim is installed (or reset if already installed).

```sh
# required (if applicable)
mv ~/.config/nvim ~/.config/nvim.bak

# optional but recommended
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

## tmux

Ensure `tpm` is installed before starting `tmux`.

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Run `tmux` and press `<C-a> <S-i>` to install packages.

## Alacritty

Ensure the `SFMono Nerd Font` font family is installed on the system.
