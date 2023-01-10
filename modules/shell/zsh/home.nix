{ user, ... }:

{
  programs.zsh = {
    prezto = {
      enable = true;
    };
  };
  xdg.dataFile."/home/${user}/.zshrc".text = ''
      #!/bin/env zsh
      pridefetch -f bisexual
    '';
}
