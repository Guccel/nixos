{ pkgs, ... }:

{
  programs.eww = {
    enable = true;
    configDir = ../features/displayManagers/eww;
  };
}
