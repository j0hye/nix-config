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

  environment.systemPackages = with pkgs; [
    xclip
    wslu
  ];

  system.stateVersion = "24.05";
}
