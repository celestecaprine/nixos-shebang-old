{config, lib, pkgs, ...}:

let
  cava-internal = pkgs.writeShellScriptBin "cava-internal" ''
    cava -p $HOME/.config/waybar/cava-barconfig | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
  '';
  tofi-powermenu = pkgs.writeShellScriptBin "tofi-powermenu" ''
    case $(echo -e "lock\nsuspend\nreboot\nshutdown" | tofi --prompt-text "exit:") in
    lock)
    sway-lock;;
    suspend)
    systemctl suspend;;
    reboot)
    systemctl reboot;;
    shutdown)
    systemctl poweroff;;
    esac
  '';
in
{
  home.packages = with pkgs; [
    cava-internal
    tofi-powermenu
  ];
}