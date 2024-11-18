{ pkgs, lib, config, ... }:
{
  #home.packages = [ git-m7 git-fixup ];
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
  };
}
