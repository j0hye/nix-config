# Enable flakes and switch (boot for WSL setup)
nix-shell -p git
git clone https://github.com/j0hye/nix-config.git

export NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild boot --flake .#WSL

wsl -t NixWSL
wsl -d NixWSL --user root exit
wsl -t NixWSL

Start new shell

# Install home-manager
nix run home-manager/master -- switch --flake .#johye
