{
  inputs,
  outputs,
  nixpkgs,
  overlays,
}: {
  user,
  hostname,
  system,
  is_wsl ? false,
}: let
  inherit is_wsl;

  common_configuration = ./. + "/../modules/common.nix";
  host_configuration = ./. + "/../hosts/${hostname}/configuration.nix";
  user_configuration = ./. + "/../home/${user}/home.nix";

  nixosConfiguration = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs outputs user hostname system;};
    modules = [
      {nixpkgs.overlays = overlays;}
      {nixpkgs.config.allowUnfree = true;}
      (
        if is_wsl
        then inputs.nixos-wsl.nixosModules.wsl
        else {}
      )
      host_configuration
      common_configuration
      inputs.home-manager.nixosModules.default
    ];
  };

  homeConfiguration = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.${system};
    extraSpecialArgs = {inherit inputs outputs user hostname system;};
    modules = [
      user_configuration
      {
        home = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      }
    ];
  };
in {
  nixosConfigurations = {
    ${hostname} = nixosConfiguration;
  };
  homeConfigurations = {
    ${user} = homeConfiguration;
  };
}
