# Dotfiles

## Fonts to install
* MesloLGS NF

## Packages to install
* sway, swaybg, swaylock, swayidle (not configured)
* zathura, zathura-pdf-poppler
* spicetify
* mako
* waybar
* ranger
* rofi
* brightnessctl
* playerctl
* grim, slurp, wl-clipboard, swappy
* wmname

## zsh config
* oh-my-zsh
* powerlevel10k
* zsh-autosuggestions
* zsh-syntax-highlighting

## Wifi auto-connect
```
nmcli connection modify name connection.autoconnect yes wifi-sec.psk-flags 0
```

## Screen sharing
In Gmeet: download Chromium, then in `chrome://flags`, set `WebRTC PipeWire Support` to enabled: it should work.

For web apps, use webapp-manager to install them.
