{ config, lib, pkgs, ... }:

{
  imports = [ ../../programs/waybar.nix ];

  services.dbus.enable = true;

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
      hyprwm-contrib-packages.grimblast
      waypipe
    ];
  };

  programs = {
    hyprland.enable = true;
  };
}
