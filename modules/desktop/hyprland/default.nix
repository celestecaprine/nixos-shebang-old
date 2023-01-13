{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ../../programs/waybar];

  environment = {
    variables = {
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP="Hyprland";
    };
    systemPackages = with pkgs; [
      grim
      mpvpaper
      slurp
      wl-clipboard
      wlr-randr
      inputs.hyprwm-contrib.packages.${pkgs.system}.grimblast
      inputs.hyprland-portal.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      inputs.hyprland-portal.packages.${pkgs.system}.hyprland-share-picker
      waypipe
    ];
  };

  programs = {
    hyprland.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
