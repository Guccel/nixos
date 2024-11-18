{
  programs.nixvim.autoCmd = [
    {
      desc = "Saves file automatically";
      event = [ "FocusLost" "WinLeave" "BufLeave" ];
      command = "silent! wa";
    }

    {
      desc = "Highlights text after 80 characters";
      event = [ "BufRead" "BufNewFile" ];
      pattern = "*";
      command = "match Error /\\%>80v\\.\\+/";
    }

    {
      desc = "Highlights yanked text";
      event = [ "TextYankPost" ];
      callback = {
        __raw = ''
          function()
             vim.highlight.on_yank({
               higroup = "IncSearch",
               timeout = 150,
             })
           end
        '';
      };
    }

    {
      event = "FileType";
      pattern = [
        "tex"
        "latex"
        "markdown"
      ];
      command = "setlocal spell spelllang=en";
    }

    {
      desc = "Auto create dir when save file, in case some intermediate directory is missing";
      event = [ "BufWritePre" ];
      callback = {
        __raw = ''
          function(event)
            if event.match:match("^%w%w+://") then
              return
            end
            local file = vim.loop.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
      };
    }

    # {
    #   desc = "Set up automatic linting";
    #   event = [
    #     "BufEnter"
    #     "BufWritePost"
    #     "InsertLeave"
    #   ];
    #   callback = {
    #     __raw = ''
    #       function(event)
    #         require("lint").try_lint()
    #       end
    #     '';
    #   };
    # }

  ];
}
