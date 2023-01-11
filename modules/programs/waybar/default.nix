{ config, lib, pkgs, host, user, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
  ];

  nixpkgs.overlays = [
    (final: prev: {
      waybar =
        let
          hyprctl = "${pkgs.hyprland}/bin/hyprctl";
          waybarPatchFile = import ./workspace-patch.nix { inherit pkgs hyprctl; };
        in
        prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          patches = (oldAttrs.patches or [ ]) ++ [ waybarPatchFile ];
        });
    })
  ];

  home-manager.users.${user} = {
    programs.waybar = {
      enable = true;
      settings = with host; {
        Main = {
          layer = "top";
          position = "top";
          height = 30;
          output = [ "${mainMonitor}" ];
          modules-left = [ "wlr/workspaces" "hyprland/window" ];
          modules-right = ["mpd" "tray" "idle_inhibitor" "clock"];
          "wlr/workspaces" = {
            "format"="{icon}";
            "on-click"="activate";
            "format-icons"={
              "1"="";
              "2"="";
              "3"="";
              "4"="";
              "5"="";
              "urgent"="";
              "active"="";
              "default"="";
            };
          };
        };
      };
      style = ''
        /*
        *
        * Catppuccin Mocha palette
        * Maintainer: rubyowo
        *
        */
        
        @define-color base   #1e1e2e;
        @define-color mantle #181825;
        @define-color crust  #11111b;
        
        @define-color text     #cdd6f4;
        @define-color subtext0 #a6adc8;
        @define-color subtext1 #bac2de;
        
        @define-color surface0 #313244;
        @define-color surface1 #45475a;
        @define-color surface2 #585b70;
        
        @define-color overlay0 #6c7086;
        @define-color overlay1 #7f849c;
        @define-color overlay2 #9399b2;
        
        @define-color blue      #89b4fa;
        @define-color lavender  #b4befe;
        @define-color sapphire  #74c7ec;
        @define-color sky       #89dceb;
        @define-color teal      #94e2d5;
        @define-color green     #a6e3a1;
        @define-color yellow    #f9e2af;
        @define-color peach     #fab387;
        @define-color maroon    #eba0ac;
        @define-color red       #f38ba8;
        @define-color mauve     #cba6f7;
        @define-color pink      #f5c2e7;
        @define-color flamingo  #f2cdcd;
        @define-color rosewater #f5e0dc;
        
        * {
            min-height: 0;
            border: none;
            font-family: "Inter", "Font Awesome 6 Free";
            font-size: 14px;
            margin: 0px;
            padding: 0px;
        }
        
        window#waybar {
        	/*background-image: linear-gradient(45deg, @blue, @lavender);*/
        	background: @blue;
        }
        
        #window {
            padding: 0px 10px 0px;
            background: transparent;
        
        }
        window#waybar.empty #window {  
         background:none;  
        }
        
        
        
        #workspaces {
            color: @text;
            background-color: @base;
            border-radius: 0px;
        }
        
        #workspaces button {
           padding: 0px 6px;
        }
        
        #workspaces button.active {
            	border-radius: 0px;
        	background-color: @blue;
        }
        
        button:hover {
        	border-radius: 0px;
        }
        
        
        #tray, #custom-weather, #custom-cava-internal, #clock, #idle_inhibitor, #cpu, #memory, #mpd, #custom-mpd-zscroll {
            color: @text;
            background-color: @base;
            padding: 0px 8px 0px;
        }
        
        #custom-cava-internal {
            font-family: "Fira Code";
        }
        
        #idle_inhibitor {
            font-family: "Fira Code";
        }
        
        #clock {
        }
        
        #battery {
        }
        
        #battery icon {
            color: red;
        }
        
        #battery.charging {
        }
        
        @keyframes blink {
            to {
                background-color: #ffffff;
                color: black;
            }
        }
        
        #battery.warning:not(.charging) {
            color: white;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }
        
        #network.disconnected {
            background: #f53c3c;
        }
        
        tooltip {
          background: rgba(43, 48, 59, 0.5);
          border: 1px solid rgba(100, 114, 125, 0.5);
        }
        tooltip label {
          color: white;
        }
      '';
    };
  };
}
