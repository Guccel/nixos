{ config, lib, ... }:

{
  programs.nixvim = {
    globals.mapleader = " ";
    globals.maplocalleader = " ";
    keymaps = [
      # Set <Space> as leader
      {
        mode = [ "n" "v" ];
        key = "<SPACE>";
        action = "<NOP>";
        options = {
          silent = true;
          remap = false;
        };
      }

      # Save and Quit
      {
        mode = [ "n" "v" ];
        key = "<LEADER>w";
        action = "<CMD>w<CR>";
        options = {
          remap = false;
          desc = "Save current buffer";
        };
      }
      {
        mode = [ "n" "v" ];
        key = "<LEADER>x";
        action = "<CMD>x<CR>";
        options = {
          silent = true;
          remap = false;
          desc = "Quit current buffer";
        };
      }

      # remap for numbers
      {
        mode = [ "n" ];
        key = "<LEADER>a";
        action = "1";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEADER>s";
        action = "2";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEADER>d";
        action = "3";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEADER>f";
        action = "4";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEADER>g";
        action = "5";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEADER>h";
        action = "6";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEADER>j";
        action = "7";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEADER>k";
        action = "8";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEADER>l";
        action = "9";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEADER>;";
        action = "0";
        options = {
          silent = true;
          remap = false;
        };
      }

      # Remap for dealing with word wrap
      {
        mode = [ "n" ];
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          silent = true;
          remap = false;
          expr = true;
        };
      }
      {
        mode = [ "n" ];
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          silent = true;
          remap = false;
          expr = true;
        };
      }

      # Move selected up/down lines
      {
        mode = [ "n" ];
        key = "J";
        action = ":m+1<CR>==";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "K";
        action = ":m-2<CR>==";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "v" ];
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "v" ];
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options = {
          silent = true;
          remap = false;
        };
      }

      # Move between windows
      {
        mode = [ "n" ];
        key = "<C-h>";
        action = "<CMD>wincmd h<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<C-j>";
        action = "<CMD>wincmd j<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<C-k>";
        action = "<CMD>wincmd k<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<C-l>";
        action = "<CMD>wincmd l<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }

      # Resize windows
      {
        mode = [ "n" ];
        key = "<UP>";
        action = "<CMD>resize -2<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<DOWN>";
        action = "<CMD>resize +2<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<LEFT>";
        action = "<CMD>vertical resize -2<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<RIGHT>";
        action = "<CMD>vertical resize +2<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }

      # Add/remove lines
      {
        mode = [ "n" ];
        key = "<A-k>";
        action = "<CMD>call append(line('.') - 1, repeat([''], v:count1))<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = "<A-j>";
        action = "<CMD>call append(line('.'), repeat([''], v:count1))<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }

      # Increase/decrease indentaion
      {
        mode = [ "n" ];
        key = "<";
        action = "v<";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "n" ];
        key = ">";
        action = "v>";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "v" ];
        key = "<";
        action = "<gv";
        options = {
          silent = true;
          remap = false;
        };
      }
      {
        mode = [ "v" ];
        key = ">";
        action = ">gv";
        options = {
          silent = true;
          remap = false;
        };
      }
    ];
  };
}

