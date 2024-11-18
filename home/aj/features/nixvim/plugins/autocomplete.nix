{ opts, ... }:

{
  programs.nixvim.plugins = {
    cmp-nvim-lsp = { enable = true; }; # lsp
    cmp-buffer = { enable = true; };
    # copilot-cmp = { enable = true; }; # copilot suggestions
    cmp-path = { enable = true; }; # file system paths
    cmp_luasnip = { enable = true; }; # snippets
    cmp-cmdline = { enable = false; }; # autocomplete for cmdline
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        experimental = {
          ghost_text = true;
        };
        window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
          };
          documentation = {
            border = "rounded";
          };
        };
        snippet.expand = # lua
          ''
            function(args)
            require("luasnip").lsp_expand(args.body)
            end
          '';
        sources = [
          { name = "nvim_lsp_signature_help"; }
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          {
            name = "buffer";
            # Words from other open buffers can also be suggested.
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          { name = "path"; }
        ];
        mapping = {
          __raw = ''

            cmp.mapping.preset.insert({
              ["<C-k>"] = cmp.mapping.select_prev_item(),
              ["<C-j>"] = cmp.mapping.select_next_item(),
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<CR>"] = cmp.mapping.confirm({ select = false }),
            })
          '';
        };
        performance = {
          debounce = 60;
          fetching_timeout = 200;
          max_view_entries = 30;
        };
      };
    };
  };
}


