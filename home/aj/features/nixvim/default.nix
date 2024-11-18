{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./autocmds.nix
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    performance.combinePlugins = {
      enable = true;
      standalonePlugins = [
        "nvim-treesitter"
      ];
    };

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    extraPlugins = [
      pkgs.vimPlugins.melange-nvim
    ];

    extraConfigLua = ''
      vim.cmd.colorscheme("melange")
    '';
  };
}
