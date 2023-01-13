{ config, lib, pkgs, host, user, ... }:

{

  home-manager.users.${user} = { 
    home.file.".config/waybar/cava-barconfig".source = ./cava-barconfig;
    programs.waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
  });
      settings = with host; {
        Main = {
          layer = "top";
          position = "top";
          height = 30;
          output = [ "${mainMonitor}" ];
          modules-left = [ "wlr/workspaces" "custom/cava-internal" "hyprland/window" ];
          modules-right = ["mpd" "tray" "idle_inhibitor" "clock" "battery"];
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
              "active"="";
              "default"="";
            };
          };
          "custom/cava-internal" = {
            "exec" = "sleep 1s && cava-internal";
            "tooltip" = false;
          };
          "hyprland/window" = {
            "format" = "{}";
            "separate-outputs" = true;
          };
          "mpd" = {
            "max-length" = 25;
            "format" = "<span foreground='#89b4fa'></span> {title}";
            "format-paused" = " {title}";
            "format-stopped" = "<span foreground='#89b4fa'></span>";
            "format-disconnected" = "";
            "on-click" = "mpc --quiet toggle";
            "on-click-right" = "mpc ls | mpc add";
            "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
            "on-scroll-up" = "mpc --quiet prev";
            "on-scroll-down" = "mpc --quiet next";
            "smooth-scrolling-threshold" = 5;
            "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
          };
          "tray" = {
            "icon-size" = 16;
            "spacing" = 16;
          };
          "idle_inhibitor" = {
            "format" = "{icon}";
            "format-icons" = {
              "activated" = "";
              "deactivated" = "";
            };
          };
          "clock" = {
            "format" = "{:%a, %B %d %I:%M %p}";
          };
          "battery" = {
            "format" = "{capacity}% {icon}";
            "format-icons" = ["" "" "" "" ""];
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
        	    color: @blue;
        }
        
        button:hover {
        	border-radius: 0px;
        }
        
        
        #tray, #custom-cava-internal, #clock, #idle_inhibitor, #mpd, #battery {
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
