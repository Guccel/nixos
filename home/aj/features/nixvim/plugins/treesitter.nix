{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        highlight.enable = true;
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<C-space>";
            node_incremental = "<C-space>";
            scope_incremental = false;
            node_decremental = "<bs>";
          };
        };
        indent.enable = true;
        auto_install = true;
        ensure_installed = [
          "json"
          "javascript"
          "typescript"
          "tsx"
          "yaml"
          "html"
          "python"
          "css"
          "prisma"
          "markdown"
          "markdown_inline"
          "svelte"
          "graphql"
          "bash"
          "lua"
          "vim"
          "nix"
          "dockerfile"
          "gitignore"
          "query"
        ];
      };
    };

    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 5;
        line_numbers = true;
        seperator = "▔";
      };
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
      navigation = {
        enable = true;
        keymaps = {
          gotoDefinition = "gd";
          listDefinitions = "gD";
          listDefinitionsToc = "gO";
          gotoNextUsage = "gn";
          gotoPreviousUsage = "gN";
        };
      };
      smartRename = {
        enable = true;
        keymaps = {
          smartRename = "R";
        };
      };
    };

    treesitter-textobjects = {
      enable = false;

      select = {
        enable = true;

        lookahead = true;
        keymaps = {
          "a=" = "@assignment.outer";
          "i=" = "@assignment.inner";
          "l=" = "@assignment.lhs";
          "r=" = "@assignment.rhs";

          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";

          "ai" = "@conditional.outer";
          "ii" = "@conditional.inner";

          "al" = "@loop.outer";
          "il" = "@loop.inner";

          "af" = "@call.outer";
          "if" = "@call.inner";

          "am" = "@function.outer";
          "im" = "@function.inner";

          "ac" = "@class.outer";
          "ic" = "@class.inner";
        };
      };
      swap = {
        enable = true;
        swapNext = {
          "<leader>na" = "@parameter.inner";
          "<leader>nm" = "@function.outer";
        };
        swapPrevious = {
          "<leader>pa" = "@parameter.inner";
          "<leader>pm" = "@function.outer";
        };
      };
      move = {
        enable = true;
        gotoNextStart = {
          "f" = "@call.outer";
          "m" = "@function.outer";
          "c" = "@class.outer";
          "i" = "@conditional.outer";
          "l" = "@loop.outer";

          "s" = "@scope";
          "z" = "@fold";
        };
        gotoNextEnd = {
          "F" = "@call.outer";
          "M" = "@function.outer";
          "C" = "@class.outer";
          "I" = "@conditional.outer";
          "L" = "@loop.outer";
        };
        gotoPreviousStart = {
          "f" = "@call.outer";
          "m" = "@function.outer";
          "c" = "@class.outer";
          "i" = "@conditional.outer";
          "l" = "@loop.outer";
        };
        gotoPreviousEnd = {
          "F" = "@call.outer";
          "M" = "@function.outer";
          "C" = "@class.outer";
          "I" = "@conditional.outer";
          "L" = "@loop.outer";
        };
      };
    };
  };
}
