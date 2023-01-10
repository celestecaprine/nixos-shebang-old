{ config, lib, pkgs, user, ...}:

{
  imports =
    (import ../modules/editors) ++
    #(import ../modules/programs);
    #(import ../modules/programs) ++
    (import ../modules/services);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      
      # Terminal Utilities
      btop
      lf
      tldr
      pridefetch

      # Multimedia Programs
      imv
      mpv

      # Web Programs
      firefox

      # File Management
      zathura
      unzip
      unrar
      xfce.thunar
      gnome.file-roller

      # Other
      tofi

    ];
    file.".config/wallpaper.gif".source = ../modules/themes/wallpaper.gif;
    pointerCursor = {
      gtk.enable = true;
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
    };
    stateVersion = "22.11";
  };

  programs = {
    home-manager.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Dark";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Inter V";
    };
    gtk3.extraConfig = { gtk-decoration-layout = "menu:"; };
  };
}
