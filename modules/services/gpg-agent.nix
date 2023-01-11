{ config, lib, pkgs, ... }:

{
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
    };
  };
  programs = {
    gpg = {
      enable = true;
    };
  };
}
