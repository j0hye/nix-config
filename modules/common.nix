{
  pkgs,
  hostname,
  ...
}: {
  networking.hostName = hostname;
  time.timeZone = "Europe/Stockholm";

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # keep-outputs = true
  # keep-derivations = true

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
}
