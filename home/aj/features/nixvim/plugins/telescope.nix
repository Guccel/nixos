{ }
  programs.nixvim.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      frecency.enable = true;
      media-files.enable = true;
      undo.enable = true;
    };
    keymaps = {
      "1" = "find_files";
      "2" = "live_grep";
    };
  };
}
