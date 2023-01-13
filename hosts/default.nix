{ lib, inputs, nixpkgs, home-manager, vscode-server, user, location, hyprland, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (self: super: {discord = super.discord.override { withOpenASAR = true; };
    })
    ];
  };

  lib = nixpkgs.lib;
in
{
  t430 = lib.nixosSystem {
    inherit system;
    inherit pkgs;
    specialArgs = {
      inherit inputs user location hyprland;
      host = {
        hostName = "np-t430";
        mainMonitor = "LVDS-1";
      };
    };
    modules = [
      vscode-server.nixosModule
        ({ config, pkgs, ... }: {
          services.vscode-server.enable = true;
        })
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
          imports = [(import ./home.nix)] ++ [(import ./t430/home.nix)] ++ [(import ../modules/programs/foot.nix)] ++ [(../modules/shell/zsh/home.nix)];
        };
      }
    ];
  };
}
