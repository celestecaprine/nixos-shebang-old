{ config, lib, pkgs, inputs, user, location, ... }:

{
  imports =
    ( import ../modules/shell );
  
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "kvm" "libvirtd" ];
    shell = pkgs.zsh;
  };
  
  time.timeZone = "America/Chicago";

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  

  fonts.fonts = with pkgs; [
    font-awesome
    inter
    fira
    fira-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-extra
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  environment = {
    variables = {
      TERMINAL = "foot";
      EDITOR= "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      pridefetch
      killall
      pciutils
      usbutils
      curl
      git
    ];
  };
  
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
	support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    openssh = {
      enable = true;
      allowSFTP = true;
    };
    gvfs = {
      enable = true;
    };
    tlp = {
      enable = true;
    };
    flatpak.enable = true;
  };

  
  nix = {
    settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nixpkgs.config.allowUnfree = true;

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.11";
  };
}
