{
  programs.starship = {
    enable = true;
    presets = ["pure-preset"];
    settings = {
      nix_shell = {
        format = "via [$symbol(\($name\))]($style) ";
        symbol = " ";
      };
    };
  };
}
