{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      capabilities = "offsetEncoding =  'utf-16'";
      servers = {
        clangd = { enable = true; };
        lua-ls = {
          enable = true;
          extraOptions = {
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace";
                };
                telemetry = {
                  enabled = false;
                };
                hint = { enable = true; };
              };
            };
          };
        };
        eslint = { enable = true; };
        pyright = { enable = true; };
        ruff-lsp = { enable = true; };
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          settings = {
            checkOnSave = true;
            check = {
              command = "clippy";
            };
            inlayHints = {
              enable = true;
              showParameterNames = true;
              parameterHintsPrefix = "<- ";
              otherHintsPrefix = "=> ";
            };
            procMacro = {
              enable = true;
            };
          };
        };
      };
    };

    lsp-lines.enable = true;

    lsp-status.enable = true;

    lspkind = {
      enable = true;
      cmp.enable = true;
    };
  };
}
