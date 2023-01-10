{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" "bcache" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" =
    { device = "/dev/disk/by-partuuid/eb0782e7-f6b0-0b41-bd4b-65f676e05e3e";
      fsType = "bcachefs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-partuuid/ad259d1d-1a4a-bc41-bc6e-99fa74e9aa0c";
      fsType = "vfat";
    };

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
