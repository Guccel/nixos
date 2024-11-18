{ config, ... }:

{
  programs.nixvim = {
    opts = {

      # [[ Backup/undo ]]
      backup = false; #  creates a backup file
      swapfile = false; #  creates a swapfile
      undofile = true; #  enable persistent undo
      writebackup = false; #  if a file is being edited by another program (or was written to file while editing with another program); it is not allowed to be edited

      # [[ Cursor ]]
      wrap = false; #  display lines as one long line
      mouse = "a"; #  allow the mouse to be used in neovim
      number = true; #  set numbered lines
      guifont = "monospace:h17";
      guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25";
      pumheight = 10; #  pop up menu height
      scrolloff = 20; #  is one of my fav
      cursorline = true; #  highlight the current line
      signcolumn = "yes"; #  always show the sign column; otherwise it would shift the text each time
      breakindent = true;
      sidescrolloff = 20;
      relativenumber = true; #  set relative numbered lines

      # [[ General ]]
      hidden = true; #  required to keep multiple buffers and open multiple buffers
      clipboard = "unnamedplus"; #  allows neovim to access the system clipboard
      cmdheight = 2; #  more space in the neovim command line for displaying messages
      errorbells = false;
      conceallevel = 0; #  so that `` is visible in markdown files
      fileencoding = "utf-8"; #  the encoding written to a file


      # [[ Search ]]
      hlsearch = false; #  highlight all matches on previous search pattern
      incsearch = true;
      ignorecase = true; #  ignore case in search patterns

      # [[ Smart ]]
      smartcase = true; #  smart case
      smartindent = true; #  make indenting smarter again

      # [[ Spliting ]]
      splitbelow = true; #  force all horizontal splits to go below current window
      splitright = true; #  force all vertical splits to go to the right of current window

      # [[ Tabs ]]
      tabstop = 2; #  insert 2 spaces for a tab
      expandtab = true; #  convert tabs to spaces
      shiftwidth = 2; #  the number of spaces inserted for each indentation
      numberwidth = 2;
      showtabline = 2; #  always show tabs
      softtabstop = 2;

      # [[ Terminal ]]
      termguicolors = true; #  set term gui colors (most terminals support this)

      # [[ Times ]]
      timeout = true;
      timeoutlen = 300; #  time to wait for a mapped sequence to complete (in milliseconds)
      updatetime = 300; #  faster completion (4000ms default)
    };
  };
}
