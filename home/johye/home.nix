{
  pkgs,
  user,
  ...
}: {
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05";

  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.neovim;
  # };

  home.packages = [
    # nix lsp and formatter
    pkgs.nixd
    pkgs.alejandra
    # lua lsp and formatter
    pkgs.lua-language-server
    pkgs.stylua
    #
    pkgs.neovim-unwrapped-nightly
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Default editor
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
