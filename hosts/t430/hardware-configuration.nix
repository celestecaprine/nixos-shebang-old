{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath)
    ];

  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" =
    { device = "/dev/disk/by-partuuid/";
      fsType = "bcachefs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-partuuid/";
      fsType = "vfat";
    };

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };
}
