{ user, ...  }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = false;
    enableSyntaxHighlighting = false;
    history.size = 10000;

    prezto = {
      enable = true;
      #prompt.showReturnVal = true;
      terminal.autoTitle = true;
    };
    #zplug = {
    #  enable = true;
    #  plugins = [
    #    { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
    #  ];
    #};
    initExtra = ''
      prompt peepcode $
      pridefetch -f bisexual
    '';
  };
}
