{ config, lib, pkgs, host, ... }:

let
  confFile = with host; '' 
    MONITORS
    
    # exec-once = waybar & hyprpaper & firefox
    exec-once=mpvpaper LVDS-1 -o "loop" $HOME/.config/wallpaper.gif
    exec-once=waybar &
    exec-once=hyprctl setcursor Catppuccin-Mocha-Dark-Cursors 32
    
    blurls=launcher

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = us
        follow_mouse = 1
        touchpad {
            natural_scroll = yes
        }
    }

    misc {
      no_vfr = yes
      focus_on_activate = yes
      disable_hyprland_logo = yes
      disable_splash_rendering = yes
      enable_swallow = yes
      swallow_regex = "foot"
    }
    
    general {
      gaps_in = 5
      gaps_out = 20
      border_size = 2
      #col.active_border = rgba(f5e0dcee) rgba(fab387ee) 45deg
      col.active_border = rgba(89b4faee)
      col.inactive_border = rgba(595959aa)
      layout = master
    }
    
    decoration {
      rounding = 0
      blur = yes
      blur_size = 3
      blur_passes = 1
      blur_new_optimizations = on

      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
    }
    
    animations {
      enabled = yes
      bezier = myBezier, 0.05, 0.9, 0.1, 1
      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }
    
    dwindle {
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }
    
    master {
      new_is_master = false
      new_on_top = false
      no_gaps_when_only = true
    }
    
    $mainMod = SUPER
    
    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, T, exec, foot
    bind = $mainMod, C, killactive, 
    bind = $mainMod SHIFT, Q, exit, 
    bind = $mainMod, E, exec, foot lf
    bind = $mainMod, V, togglefloating, 
    bind = $mainMod, R, exec, tofi-drun --drun-launch=true
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle
    bind = $mainMod, Print, exec, grimblast --notify copysave area $HOME/Pictures/Screenshots/screenshot-$(date +%Y-%d-%m_%H:%M:%S)
bind = $mainMod SHIFT, Print, exec, grimblast --notify copysave output $HOME/Pictures/Screenshots/screenshot-$(date +%Y-%d-%m_%H:%M:%S)
bind = $mainMod CONTROL, Print, exec, grimblast --notify copysave active $HOME/Pictures/Screenshots/$(${pkgs.hyprland}hyprctl activewindow -j | ${pkgs.jq}/bin/jq -r '.class')-$(date +%Y-%d-%m_%H:%M:%S)
    
    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d
    
    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10
    
    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10
    
    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1
    
    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow


  '';

  hyprlandConf = with host; builtins.replaceStrings ["MONITORS"]
    [
      (if hostName == "np-t430" then ''
        monitor=${toString mainMonitor},1920x1080@60,1920x0,1
      ''
      else false)
    ]
    "${confFile}";

  in {
    xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;
  }

