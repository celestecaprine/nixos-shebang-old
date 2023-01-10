{ pkgs, user, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;
    };
  };
  home-manager.users.${user} = {
    programs.zsh = {
      prezto = {
        enable = true;
      };
    };
    xdg.dataFile."/home/${user}/.zshrc".text = ''
        #!/bin/env zsh
        pridefetch -f bisexual
      '';
  };
  
}
