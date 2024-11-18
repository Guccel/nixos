{ config, lib, pkgs, palette, ... }:

{
  programs.wofi = {
    enable = true;
    package = pkgs.wofi.overrideAttrs (oa: {
      patches = (oa.patches or [ ]);
    });
    settings = {
      width = "25%";
      height = "34%";
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      gtk_dark = true;
    };
    # style = ''
    #
    #   window {
    #     background-color: ${palette.background};
    #     border: 2px solid ${palette.brightBlack};
    #     border-radius: 2px;
    #   }
    #
    #   #input {
    #     margin: 5px;
    #     border: none;
    #     color: ${palette.foreground};
    #     background-color: ${palette.black};
    #     border-radius: 5px;
    #   }
    #
    #   #inner-box {
    #     margin: 5px;
    #     background-color: ${palette.background};
    #   }
    #
    #   #outer-box {
    #     margin: 5px;
    #     padding: 10px;
    #     background-color: ${palette.background};
    #   }
    #
    #   #scroll {
    #     margin: 5px;
    #     border: none;
    #   }
    #
    #   #text {
    #     margin: 5px;
    #     color: ${palette.foreground};
    #   }
    #
    #   #entry:selected {
    #     background-color: ${palette.brightBlack};
    #     border-radius: 5px;
    #   }
    #
    #   #text:selected {
    #     color: ${palette.brightWhite};
    #   }
    # '';
  };
}
