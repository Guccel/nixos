{ config, pkgs, lib, ... }:

let
  modifier = "Mod4";
  left = "h";
  down = "j";
  up = "k";
  right = "l";
  terminal = "${pkgs.kitty}/bin/kitty";
  menu = "${pkgs.wofi}/bin/wofi --show drun";
  browser = "${pkgs.firefox}/bin/firefox";
  # screenshot = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
in
{
  imports = [
    ../common
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "${modifier}";
      terminal = "${terminal}";
      menu = "${menu}";

      # Output configuration
      output = {
        "*" = {
          # bg = "~/Pictures/wallpaper.jpg fill";
        };
      };

      # Input configuration
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
          dwt = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_options = "caps:escape";
        };
      };

      # Workspaces
      workspaceAutoBackAndForth = true;

      # Keybindings
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+q" = "kill";
        "${modifier}+d" = "exec ${menu}";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway?' -b 'Yes, exit sway' 'swaymsg exit'";

        # Launch applications
        "${modifier}+b" = "exec ${browser}";
        # "${modifier}+p" = "exec ${screenshot}";

        # Focus
        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";

        # Move
        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";

        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        # Move focused container to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Layout
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";
        "${modifier}+a" = "focus parent";

        # Scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        # Resize mode
        "${modifier}+r" = "mode resize";
      };

      modes.resize = {
        "${left}" = "resize shrink width 10px";
        "${down}" = "resize grow height 10px";
        "${up}" = "resize shrink height 10px";
        "${right}" = "resize grow width 10px";
        "Escape" = "mode default";
        "Return" = "mode default";
      };

      bars = [ ]; # We'll use Waybar instead
    };
    extraConfig = ''
      # Gaps
      gaps inner 5
      gaps outer 3
      smart_gaps on

      # Borders
      default_border pixel 2
      default_floating_border pixel 2
      hide_edge_borders smart

      # Colors
      client.focused          #4c7899 #285577 #ffffff #2e9ef4   #285577
      client.focused_inactive #333333 #5f676a #ffffff #484e50   #5f676a
      client.unfocused        #333333 #222222 #888888 #292d2e   #222222
      client.urgent           #2f343a #900000 #ffffff #900000   #900000
      client.placeholder      #000000 #0c0c0c #ffffff #000000   #0c0c0c
      client.background       #ffffff

      # Floating windows
      for_window [app_id="pavucontrol"] floating enable
      for_window [app_id="nm-connection-editor"] floating enable

      # Autostart
      # exec waybar
      exec mako
      exec nm-applet --indicator
    '';
  };
}
