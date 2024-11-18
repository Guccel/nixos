{ config, pkgs, palette, ... }:

{
  config = {
    home.packages = with pkgs; [ anki ];
  };
}

