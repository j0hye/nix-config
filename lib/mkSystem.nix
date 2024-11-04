{
  inputs,
  outputs,
  nixpkgs,
  # overlays,
}: {
  user,
  hostname,
  system,
  is_wsl ? false,
}: let
  inherit is_wsl;

  # pkgs = import nixpkgs {
  #   inherit system overlays;
  #   config.allowUnfree = true;
  # };
  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      inputs.nno.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  host_configuration = ./. + "/../hosts/${hostname}/configuration.nix";
  user_configuration = ./. + "/../home/${user}/home.nix";

  nixosConfiguration = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      {nixpkgs.pkgs = pkgs;}
      (
        if is_wsl
        then inputs.nixos-wsl.nixosModules.wsl
        else {}
      )
      host_configuration
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import user_configuration;
        home-manager.extraSpecialArgs = {inherit inputs outputs user hostname system;};
      }
    ];
    specialArgs = {inherit inputs outputs user hostname system;};
  };
in {
  nixosConfigurations = {
    ${hostname} = nixosConfiguration;
  };
}
