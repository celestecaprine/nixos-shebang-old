{ pkgs, ... }:

{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/scripts/home.nix
  ];
}
