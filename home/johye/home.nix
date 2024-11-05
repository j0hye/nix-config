{
  pkgs,
  user,
  ...
}: {
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05";

  imports = [
    ../modules/neovim.nix
    ../modules/zsh.nix
    ../modules/starship.nix
  ];

  home.packages = with pkgs; [
    # build
    gcc
    gnumake
    cargo
    # util
    wget
    curl
    unzip
    fd
    ripgrep
    bat
    eza
    fzf
    tree
    zoxide
    htop
    # nix
    nh
  ];

  # Session variables
  home.sessionVariables = {
    # LANG = "sv_SE.UTF-8";
    # LC_ALL = "sv_SE.UTF-8";
    EDITOR = "nvim";
    FLAKE = "/home/${user}/.config/nix-config";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
