{ lib, inputs, nixpkgs, home-manager, user, location, hyprland, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user location hyprland;
      host = {
        hostName = "np-nixos";
      };
    };
    modules = [
      hyprland.nixosModules.default
      ./vm
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
          host = {
            hostname = "np-nixos";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./vm/home.nix)] ++ [(import ../modules/shell/zsh/home.nix)] ++ [(import ../modules/programs/foot.nix)];
        };
      }
    ];
  };
}
