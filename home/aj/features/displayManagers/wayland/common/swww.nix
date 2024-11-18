{ outputs, config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    inputs.swww.packages.${pkgs.system}.swww
  ];
}
