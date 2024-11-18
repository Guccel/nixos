{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./git.nix

    ./btop.nix
    ./ranger.nix
    ./ssh.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    bc # Calculator
    fd # Better find
    timer # To help with my ADHD paralysis
  ];
}
