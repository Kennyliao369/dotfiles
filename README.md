# dotfiles

Personal config files for my setup.

Archlinux + niri + Noctalia

## Preview
 
![](./screenshots/desktop.png)

# Install

Copy (or symlink):

.config/* → ~/.config/

etc/zsh/zshenv → /etc/zsh/zshenv

## **Noctalia**

```sh
sudo pacman -S noctalia
```

- Put wallpapers in `~/Pictures/Wallpaper`, then change the wallpaper once to generate the theme files.
- Check the config with `noctalia config validate`.

## niri

```sh
sudo pacman -S niri
```

- edit `local.kdl` to change the monitor setup.
- Check the config with `niri validate`.

## Noctalia Greeter
 
```sh
paru -S noctalia-greeter
```

```sh
sudoedit /etc/greetd/config.toml   # [default_session] command = "/usr/bin/noctalia-greeter-session"
```

```sh
sudo systemctl disable sddm.service
sudo systemctl enable greetd
```
 
- Replace `sddm.service` with whatever `systemctl status display-manager.service` shows.
- After rebooting, sync the look in Noctalia: Settings → Security → Noctalia Greeter → **Sync Now**.

## Alacritty
 
```sh
sudo pacman -S alacritty ttf-jetbrains-mono-nerd
```

## zsh
 
```sh
sudo pacman -S zsh
sudo pacman -S zoxide zsh-syntax-highlighting
sudo pacman -S eza bat ripgrep
chsh -s /usr/bin/zsh
```
 
`etc/zsh/zshenv` must be deployed to `/etc`.

## yazi
 
```sh
sudo pacman -S yazi
sudo pacman -S chafa udisks2
ya pkg install
```
 
- `chafa`: image preview fallback, since Alacritty has no image protocol.
- `udisks2`: required by the `mount` plugin.
- `ya pkg upgrade` updates the packages to their latest versions.

## Helix
 
```sh
sudo pacman -S helix
```

## Neovim
 
```sh
sudo pacman -S neovim
```
