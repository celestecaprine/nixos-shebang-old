{ config, lib, pkgs, user, ...}:

{
  imports =
    (import ../modules/editors) ++
    #(import ../modules/programs);
    (import ../modules/programs) ++
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
      gh

      # Multimedia Programs
      pavucontrol
      imv
      mpv

      # Web Programs
      firefox
      discord

      # File Management
      zathura
      unzip
      unrar
      gnome.nautilus
      gnome.file-roller

      # Other
      tofi
      rofi-wayland

    ];
    file.".config/wallpaper.gif".source = ../modules/themes/wallpaper.gif;
    pointerCursor = {
      gtk.enable = true;
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 32;
      x11 = {
        enable = true;
        defaultCursor = "Catppuccin-Mocha-Dark-Cursors";
      };
    };
    stateVersion = "22.11";
  };

  programs = {
    home-manager.enable = true;
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.wlrobs ];
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      pass.enable = true;
      terminal = "foot";
    };
  };

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "application/html" = "firefox.desktop";
      "application/pdf" = "zathura";
      "application/png" = "imv";
    };
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "application/html" = "firefox.desktop";
      "application/pdf" = "zathura";
      "application/png" = "imv";
    };
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
    gtk3.extraConfig = { gtk-decoration-layout = ""; };
  };
}
