{ user, ... }:

{
  programs.zsh = {
    #prezto = {
    #  enable = true;
    #  terminal.autoTitle = true;
    #  prompt = {
    #    theme = "pure";
    #  };
    #  editor.keymap = "vi";
    #};
    oh-my-zsh = {
      enable = true;
      theme = "refined";
    };
  };
  xdg.dataFile."/home/${user}/.zshrc".text = ''
      #!/bin/env zsh
      pridefetch -f bisexual
    '';
}
