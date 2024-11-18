{ outputs, config, lib, pkgs, palette, ... }:

let
  # Dependencies
  cat = "${pkgs.coreutils}/bin/cat";
  cut = "${pkgs.coreutils}/bin/cut";
  find = "${pkgs.findutils}/bin/find";
  grep = "${pkgs.gnugrep}/bin/grep";
  pgrep = "${pkgs.procps}/bin/pgrep";
  tail = "${pkgs.coreutils}/bin/tail";
  wc = "${pkgs.coreutils}/bin/wc";
  xargs = "${pkgs.findutils}/bin/xargs";
  timeout = "${pkgs.coreutils}/bin/timeout";
  ping = "${pkgs.iputils}/bin/ping";

  jq = "${pkgs.jq}/bin/jq";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  wofi = "${pkgs.wofi}/bin/wofi";

  # Function to simplify making waybar outputs
  jsonOutput = name: { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-${name}";

  hasSway = config.wayland.windowManager.sway.enable;
  sway = config.wayland.windowManager.sway.package;
  hasHyprland = config.wayland.windowManager.hyprland.enable;
  hyprland = config.wayland.windowManager.hyprland.package;
in
{
  # Let it try to start a few more times
  systemd.user.services.waybar = {
    Unit.StartLimitBurst = 30;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    # settings = {
    #   primary = {
    #     mode = "dock";
    #     layer = "top";
    #     height = 24;
    #     # margin = "6";
    #     spacing = 4;
    #     position = "top";
    #     modules-left = [
    #       # "cava"
    #     ] ++ (lib.optionals hasSway [
    #       "sway/workspaces"
    #       "sway/mode"
    #     ]) ++ (lib.optionals hasHyprland [
    #       "hyprland/workspaces"
    #       "hyprland/submap"
    #     ]);
    #
    #     modules-center = [
    #       "clock"
    #     ];
    #
    #     modules-right = [
    #       # "wireplumber"
    #       "battery"
    #     ];
    #
    #     "sway/window" = {
    #       "format" = "{title}";
    #       "max-length" = 40;
    #       "all-outputs" = true;
    #     };
    #
    #     "sway/mode" = {
    #       format = "{}";
    #     };
    #
    #     clock = {
    #       interval = 1;
    #       format = "{:%d/%m %H:%M:%S}";
    #       format-alt = "{:%Y-%m-%d %H:%M:%S %z}";
    #       on-click-left = "mode";
    #       tooltip-format = ''
    #         <big>{:%Y %B}</big>
    #         <tt><small>{calendar}</small></tt>'';
    #     };
    #
    #     backlight = {
    #       format = "{icon} {percent}%";
    #       format-icons = [ "" "" "" "" "" "" "" "" "" ];
    #     };
    #
    #     battery = {
    #       states = {
    #         warning = 30;
    #         critical = 15;
    #       };
    #       format = "{icon} {capacity}%";
    #       format-full = "{icon} {capacity}%";
    #       format-charging = " {capacity}%";
    #       format-plugged = " {capacity}%";
    #       format-alt = "{icon} {time}";
    #       format-icons = [ "" "" "" "" "" ];
    #     };
    #
    #   };
    # };
    #
    # style = ''
    #       * {
    #   	font-size: 20px;
    #   	font-family: monospace;
    #     min-height: 0;
    #   }
    #
    #   window#waybar {
    #     opacity: 0.5;
    #     transition-property: background-color;
    #     transition-duration: .5s;
    #   }
    #
    #   window#waybar.hidden {
    #     opacity: 0.2;
    #   }
    #
    #   #window {
    #     margin: 2;
    #     padding-left: 8;
    #     padding-right: 8;
    #     background-color: rgba(0,0,0,0.3);
    #     font-size:14px;
    #     font-weight: bold;
    #   }
    #
    #   #workspaces,
    #   #clock,
    #   #clock.2,
    #   #clock.3,
    #   #pulseaudio,
    #   #memory,
    #   #cpu,
    #   #battery,
    #   #disk,
    #   #tray {
    #   	background: #1a1a1a;
    #   }
    #
    #   button {
    #     /* Use box-shadow instead of border so the text isn't offset */
    #     box-shadow: inset 0 -3px transparent;
    #     /* Avoid rounded borders under each button name */
    #     border: none;
    #     border-radius: 0;
    #   }
    #
    #   /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    #   button:hover {
    #     background: inherit;
    #     border-top: 2px solid #c9545d;
    #   }
    #
    #   #workspaces button {
    #     padding: 0 4px;
    #     /*    background-color: rgba(0,0,0,0.3); */
    #   }
    #
    #   #workspaces button:hover {
    #   }
    #
    #   #workspaces button.focused {
    #     /*    box-shadow: inset 0 -2px #c9545d; */
    #     background-color: rgba(0,0,0,0.3);
    #     color:#c9545d;
    #     border-top: 2px solid #c9545d;
    #   }
    #
    #   #workspaces button.urgent {
    #     background-color: #eb4d4b;
    #   }
    #   #clock,
    #   #pulseaudio,
    #   #memory,
    #   #cpu,
    #   #battery,
    #   #disk {
    #   	padding: 0 10px;
    #   }
    # '';
  };
}




