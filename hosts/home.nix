{ config, lib, pkgs, user, ...}:

{
  imports =
    (import ../modules/editors) ++
    #(import ../modules/programs);
    (import ../modules/programs) ++
    (import ../modules/services);

  home = {
    file = {
      ".config/tofi/config".text = ''
        width = 100%
        height = 100%
        border-width = 0
        outline-width = 0
        padding-left = 35%
        padding-top = 35%
        result-spacing = 25
        num-results = 5
        font = Inter V
        text-color = #cdd6f4
        background-color = #1e1e2e80
        selection-color = #89b4fa
      '';
    };
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      
      # Terminal Utilities
      btop
      lf
      tldr
      todo
      pridefetch
      gh
      cava
      tree

      # Multimedia Programs
      pavucontrol
      imv
      mpv
      mpc-cli

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
