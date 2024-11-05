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
