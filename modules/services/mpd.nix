{ config, lib, pkgs, user,  ... }:

{
  services = {
    mpd = {
      enable = true;
      musicDirectory = "/home/\${user}/Music";
      mpddataDir = "/home/\${user}/.local/share/mpd";
    };
    mpdris2 = {
      enable = true;
    };
  };
  programs = {
    ncmpcpp = {
      enable = true;
    };
  };
}
