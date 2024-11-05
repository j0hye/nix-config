{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;

  time.timeZone = "Europe/Stockholm";

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '';

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
}
