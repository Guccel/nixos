{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.wayland.windowManager.hyprland.keybindings;

  # Helper function to generate bind commands
  mkBind = key: action: "bind = ${key}, ${action}";
  mkBindE = key: action: "binde = ${key}, ${action}";

in
{
  options.wayland.windowManager.hyprland.keybindings = {
    enable = mkEnableOption "Hyprland keybindings";

    modifier = "${mod}, SUPER";
    # Window management
    closeWindow = "${mod}, Q";
    toggleFloating = "${mod}, V";
    toggleFullscreen = "${mod}, F";
    # Workspace management
    workspaceNext = "${mod}, right";

    workspacePrev = "${mod}, left";

    moveToWorkspace = mkOption {
      type = types.attrsOf types.str;
      default = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "0";
      };
      description = "Keys to move to specific workspaces";
    };

    moveWindowToWorkspace = mkOption {
      type = types.attrsOf types.str;
      default = {
        "1" = "SHIFT, 1";
        "2" = "SHIFT, 2";
        "3" = "SHIFT, 3";
        "4" = "SHIFT, 4";
        "5" = "SHIFT, 5";
        "6" = "SHIFT, 6";
        "7" = "SHIFT, 7";
        "8" = "SHIFT, 8";
        "9" = "SHIFT, 9";
        "10" = "SHIFT, 0";
      };

      # Focus
      focusLeft = "${mod}, left";
      focusRight = "${mod}, right";
      focusUp = "${mod}, up";
      focusDown = "${mod}, down";

      # Move windows
      moveLeft = "${mod}, SHIFT, left";

      moveRight = "${mod}, SHIFT, right";

      moveUp = "${mod}, SHIFT, up";
      description = "Keys to move the focused window up";

      moveDown = "${mod}, SHIFT, down";

      # Resize windows
      resizeActive = "${mod}, R";

      # Launchers
      terminalLauncher = "${mod}, RETURN";
      applicationsLauncher = "${mod}, D";

      # System controls
      volumeUp = "${mod}, , XF86AudioRaiseVolume";
      volumeDown = "${mod}, , XF86AudioLowerVolume";
      volumeMute = "${mod}, , XF86AudioMute";
      brightnessUp = "${mod}, , XF86MonBrightnessUp";
      brightnessDown = "${mod}, , XF86MonBrightnessDown";

      # Screenshots
      screenshotFull = "${mod}, , Print";
      screenshotRegion = "${mod}, SHIFT, Print";

      # Lock screen
      lockScreen = "${mod}, L";

      config = mkIf cfg.enable {
        wayland.windowManager.hyprland.extraConfig = ''
                      # Window management
                      ${mkBind "${cfg.modifier}, ${cfg.closeWindow}" "killactive"}
                      ${mkBind "${cfg.modifier}, ${cfg.toggleFloating}" "togglefloating"}
                      ${mkBind "${cfg.modifier}, ${cfg.toggleFullscreen}" "fullscreen"}

                      # Workspace management
                      ${mkBind "${cfg.modifier}, ${cfg.workspaceNext}" "workspace, e+1"}
                      ${mkBind "${cfg.modifier}, ${cfg.workspacePrev}" "workspace, e-1"}
                      ${concatStringsSep "\n" (mapAttrsToList (workspace: key:
          mkBind "${cfg.modifier}, ${key}" "workspace, ${workspace}"
          ) cfg.moveToWorkspace)}
                      ${concatStringsSep "\n" (mapAttrsToList (workspace: key:
          mkBind "${cfg.modifier} ${key}" "movetoworkspace, ${workspace}"
          ) cfg.moveWindowToWorkspace)}

                      # Focus
                      ${mkBind "${cfg.modifier}, ${cfg.focusLeft}" "movefocus, l"}
                      ${mkBind "${cfg.modifier}, ${cfg.focusRight}" "movefocus, r"}
                      ${mkBind "${cfg.modifier}, ${cfg.focusUp}" "movefocus, u"}
                      ${mkBind "${cfg.modifier}, ${cfg.focusDown}" "movefocus, d"}

                      # Move windows
                      ${mkBind "${cfg.modifier} ${cfg.moveLeft}" "movewindow, l"}
                      ${mkBind "${cfg.modifier} ${cfg.moveRight}" "movewindow, r"}
                      ${mkBind "${cfg.modifier} ${cfg.moveUp}" "movewindow, u"}
                      ${mkBind "${cfg.modifier} ${cfg.moveDown}" "movewindow, d"}

                      # Resize windows
                      ${mkBind "${cfg.modifier}, ${cfg.resizeActive}" "submap, resize"}
                      submap = resize
                      ${mkBindE ", right" "resizeactive, 10 0"}
                      ${mkBindE ", left" "resizeactive, -10 0"}
                      ${mkBindE ", up" "resizeactive, 0 -10"}
                      ${mkBindE ", down" "resizeactive, 0 10"}
                      ${mkBind ", escape" "submap, reset"}
                      submap = reset

                      # Launchers
                      ${mkBind "${cfg.modifier}, ${cfg.terminalLauncher}" "exec, $TERMINAL"}
                      ${mkBind "${cfg.modifier}, ${cfg.applicationsLauncher}" "exec, $MENU"}

                      # System controls
                      ${mkBindE cfg.volumeUp "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"}
                      ${mkBindE cfg.volumeDown "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"}
                      ${mkBind cfg.volumeMute "exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"}
                      ${mkBindE cfg.brightnessUp "exec, brightnessctl set 5%+"}
                      ${mkBindE cfg.brightnessDown "exec, brightnessctl set 5%-"}

                      # Screenshots
                      ${mkBind cfg.screenshotFull "exec, grimblast copy"}
                      ${mkBind "${cfg.modifier} ${cfg.screenshotRegion}" "exec, grimblast copy area"}

                      # Lock screen
                      ${mkBind "${cfg.modifier}, ${cfg.lockScreen}" "exec, swaylock"}
        '';
      };
    }
