{
  programs.nixvim.plugins = {
    trouble = {
      enable = true;
      settings = {
        auto_close = true;
      };
    };
  };
  programs.nixvim.keymaps = [
    {
      mode = [ "n" ];
      key = "<SPACE>d";
      action = "<CMD>Trouble diagnostics toggle<CR>";
      options = {
        silent = true;
        remap = false;
      };
    }
  ];
}
