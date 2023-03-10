{ pkgs, user, ... }:

{
  programs = {
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    };
    browserpass = {
      enable = true;
      browsers = [ "firefox" ];
    };    
  };
}
