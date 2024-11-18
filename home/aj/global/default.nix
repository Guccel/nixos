{ inputs, lib, pkgs, config, outputs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nix-colors.homeManagerModule
    ./fonts.nix
  ];

  config = {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };

    programs = {
      # home-manager.enable = true;
      git.enable = true;
    };

    home = {
      username = lib.mkDefault "AJ";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "24.11";
      sessionPath = [ "$HOME/.local/bin" ];
      sessionVariables = {
        FLAKE = "$HOME/Documents/NixConfig";
      };
    };

    systemd.user.startServices = "sd-switch";
  };
}
