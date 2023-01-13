{ config, lib, pkgs, user,  ... }:

{
  services = {
    mpd = {
      enable = true;
      musicDirectory = "/home/${user}/Music";
      dataDir = "/home/${user}/.local/share/mpd";
      extraConfig = ''
        audio_output {
          type "pulse"
          name "MPD Pulse Output"
        }
      '';
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
