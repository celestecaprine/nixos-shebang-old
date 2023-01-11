{
  description = "Shebang's Flake!";

  inputs = {
    nixpkgs.url= "github:nixos/nixpkgs/nixos-unstable";

    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-portal = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, hyprwm-contrib, hyprland-portal, ... }:
    let
      user = "shebang";
      location = "$HOME/.flake";
      
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
	  inherit inputs nixpkgs home-manager user location hyprland hyprwm-contrib hyprland-portal;
	}
      );
    };
}
