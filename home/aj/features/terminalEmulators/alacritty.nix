{ config, pkgs, palette, ... }:
{
  config = {
    programs.alacritty = {
      enable = true;
      settings = {
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = [];
        };
        # font = {
        #   normal = {
        #     family = "JetBrainsMono Nerd Font";
        #     style = "Regular";
        #   };
        #   size = 12.0;
        # };
        window = {
          padding = {
            x = 5;
            y = 5;
          };
        };
        # colors = {
        #   primary = {
        #     background = "#282c34";
        #     foreground = "#abb2bf";
        #   };
        # };
      };
    };
  };
}
