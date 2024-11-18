{
  programs.nixvim.plugins = {
    lualine = {
      enable = true;
      globalstatus = true;
      iconsEnabled = true;
      ignoreFocus = [ ];
      theme = "auto";
      sectionSeparators = {
        left = " ";
        right = " ";
      };
      componentSeparators = {
        left = " │ ";
        right = " │ ";
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" "diff" "diagnostics" ];
        lualine_c = [ "filename" ];
        lualine_x = [ "encoding" "filesize" ];
        lualine_y = [ "filetype" ];
        lualine_z = [ ''os.date("%R")'' ];
      };
    };

    indent-blankline = {
      enable = true;
    };

    improved-search = {
      enable = true;
      keymaps = [
        {
          action = "stable_next";
          key = "n";
          mode = [ "n" "x" "o" ];
        }
        {
          action = "stable_previous";
          key = "N";
          mode = [ "n" "x" "o" ];
        }
        {
          action = "forward";
          key = "n";
          mode = "x";
        }
        {
          action = "backward";
          key = "N";
          mode = "x";
        }
      ];
    };

    which-key.enable = true;

    noice.enable = true;

    zen-mode.enable = true;

    twilight.enable = true;

    # oil.enable = true;
  };
}
