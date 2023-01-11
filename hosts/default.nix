{ lib, inputs, nixpkgs, home-manager, user, location, hyprland, hyprwm-contrib, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (self: super: {
      hyprwm-contrib-packages = hyprwm-contrib.packages.${system};
      })
    ];
  };

  lib = nixpkgs.lib;
in
{
  vm = lib.nixosSystem {
    inherit system;
    inherit pkgs;
    specialArgs = {
      inherit inputs user location hyprland hyprwm-contrib;
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
            hostName = "np-nixos";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./vm/home.nix)] ++ [(import ../modules/shell/zsh/home.nix)] ++ [(import ../modules/programs/foot.nix)];
        };
      }
    ];
  };
  t430 = lib.nixosSystem {
    inherit system;
    inherit pkgs;
    specialArgs = {
      inherit inputs user location hyprland hyprwm-contrib;
      host = {
        hostName = "np-t430";
        mainMonitor = "LVDS-1";
      };
    };
    modules = [
      hyprland.nixosModules.default
      ./t430
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
          host = {
            hostName = "np-t430";
            mainMonitor = "LVDS-1";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./t430/home.nix)] ++ [(import ../modules/shell/zsh/home.nix)] ++ [(import ../modules/programs/foot.nix)];
        };
      }
    ];
  };
}
