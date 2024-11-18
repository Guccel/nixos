{ pkgs, ... }: {
  home.packages = with pkgs; [ ranger neofetch ];
}
