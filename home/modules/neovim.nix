{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    extraPackages = with pkgs; [
      lua5_1
      luarocks
      # Nix
      nixd
      alejandra
      # Lua
      lua-language-server
      stylua
    ];
    extraLuaPackages = p:
      with p; [
        luautf8
        pathlib-nvim
      ];
    # Aliases
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # Providers
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };
}
