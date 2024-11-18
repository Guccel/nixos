{ config, pkgs, ... }:

{
  config = {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "docker" "kubectl" ];
        theme = "robbyrussell";
      };
      initExtra = ''
        export PATH=$HOME/.local/bin:$PATH
      '';
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
      };
    };
  };
}
