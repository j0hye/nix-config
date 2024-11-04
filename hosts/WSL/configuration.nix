{
  pkgs,
  user,
  hostname,
  ...
}: {
  wsl.enable = true;

  wsl.defaultUser = "${user}";
  wsl.wslConf.network.hostname = hostname;
  wsl.wslConf.interop.appendWindowsPath = false;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '';

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    xclip
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "24.05";
}
