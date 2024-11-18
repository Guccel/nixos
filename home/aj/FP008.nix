{ inputs, lib, pkgs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  imports = [

    # Features
    ./global
    ./features/displayManagers/wayland
    ./features/cli
    ./features/browsers/firefox.nix
    # ./features/officeStuff
    # ./features/communication/discord.nix
    # ./features/terminalEmulators/alacritty.nix
    ./features/kitty.nix
    ./features/nixvim
    # ./features/rdp.nix
    # ./features/helvum.nix
    # ./features/spotify.nix
    # ./features/libreoffice.nix
    # ./features/rclone.nix
  ];



  # colorscheme = lib.mkDefault colorSchemes.tokyo-city-terminal-dark;

  # wallpaper = 

  # monitors = [
  #
  # ];

  # stylix = {
  #   config = {
  #   enable = true;
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  #   image = lib.cleanSource ./palettes/wallpaper.jpg;
  #   # polarity = "dark";
  # };

  home.stateVersion = "24.05";
  # };
}
