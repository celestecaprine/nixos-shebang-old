{
  description = "Shebang's Flake!";

  inputs = {
    nixpkgs.url= "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, ... }:
    let
      user = "shebang";
      location = "$HOME/.flake";
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
	  inherit inputs nixpkgs home-manager user location hyprland;
	}
      );
    };
}
