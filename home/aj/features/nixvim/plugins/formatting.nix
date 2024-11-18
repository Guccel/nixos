{
  programs.nixvim.plugins = {
    conform-nvim = {
      enable = true;
      formattersByFt = {
        lua = [ "stylua" ];
        svelte = [ [ "prettierd" "prettier" ] ];
        python = [ [ "prettierd" "prettier" ] ];
        javascript = [ [ "prettierd" "prettier" ] ];
        typescript = [ [ "prettierd" "prettier" ] ];
        javascriptreact = [ [ "prettierd" "prettier" ] ];
        typescriptreact = [ [ "prettierd" "prettier" ] ];
        json = [ [ "prettierd" "prettier" ] ];
        graphql = [ [ "prettierd" "prettier" ] ];
        java = [ "google-java-format" ];
        kotlin = [ "ktlint" ];
        ruby = [ "standardrb" ];
        markdown = [ [ "prettierd" "prettier" ] ];
        erb = [ "htmlbeautifier" ];
        html = [ "htmlbeautifier" ];
        bash = [ "beautysh" ];
        proto = [ "buf" ];
        rust = [ "rustfmt" ];
        yaml = [ "yamlfix" ];
        toml = [ "taplo" ];
        css = [ [ "prettierd" "prettier" ] ];
        scss = [ [ "prettierd" "prettier" ] ];
      };
      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };
      };
    };

    guess-indent = {
      enable = true;
      settings.auto_cmd = true;
    };
  };
}
