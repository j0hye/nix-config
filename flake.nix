{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    # Home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim nightly overlay
    # https://github.com/nix-community/neovim-nightly-overlay/tree/flake-update
    nno.url = "github:nix-community/neovim-nightly-overlay";
    nno.inputs.nixpkgs.follows = "nixpkgs";

    # Dotfiles
    dotfiles.url = "github:j0hye/dotfiles";
    dotfiles.flake = false;
  };
  outputs = {
    self,
    nixpkgs,
    nno,
    ...
  } @ inputs: let
    inherit (self) outputs;

    overlays = [
      nno.overlays.default
    ];

    mkSystem = import ./lib/mkSystem.nix {
      inherit inputs outputs nixpkgs overlays;
    };
  in
    mkSystem {
      user = "johye";
      hostname = "WSL";
      system = "x86_64-linux";
      is_wsl = true;
    };
}
