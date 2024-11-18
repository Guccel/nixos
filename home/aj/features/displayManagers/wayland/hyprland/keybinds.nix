{ config, lib, pkgs, ... }:

let
  mod = "SUPER";
  binds = {
    # Window management
    closeWindow = "${mod} SHIFT, Q";
    toggleFloating = "${mod}, V";
    toggleFullscreen = "${mod}, F";

    # Workspace management
    workspaceNext = "${mod}, right";
    workspacePrev = "${mod}, left";
    workspaceSwitch1 = "${mod}, 1";
    workspaceSwitch2 = "${mod}, 2";
    workspaceSwitch3 = "${mod}, 3";
    workspaceSwitch4 = "${mod}, 4";
    workspaceSwitch5 = "${mod}, 5";
    workspaceSwitch6 = "${mod}, 6";
    workspaceSwitch7 = "${mod}, 7";
    workspaceSwitch8 = "${mod}, 8";
    workspaceSwitch9 = "${mod}, 9";
    workspaceSwitch10 = "${mod}, 0";

    # Window movement to workspaces
    moveToWorkspace1 = "${mod} SHIFT, 1";
    moveToWorkspace2 = "${mod} SHIFT, 2";
    moveToWorkspace3 = "${mod} SHIFT, 3";
    moveToWorkspace4 = "${mod} SHIFT, 4";
    moveToWorkspace5 = "${mod} SHIFT, 5";
    moveToWorkspace6 = "${mod} SHIFT, 6";
    moveToWorkspace7 = "${mod} SHIFT, 7";
    moveToWorkspace8 = "${mod} SHIFT, 8";
    moveToWorkspace9 = "${mod} SHIFT, 9";
    moveToWorkspace10 = "${mod} SHIFT, 0";

    # Focus
    focusLeft = "${mod}, h";
    focusRight = "${mod}, l";
    focusUp = "${mod}, k";
    focusDown = "${mod}, j";

    # Move windows
    moveLeft = "${mod} SHIFT, h";
    moveRight = "${mod} SHIFT, l";
    moveUp = "${mod} SHIFT, k";
    moveDown = "${mod} SHIFT, j";

    # Resize windows
    resizeActive = "${mod}, R";

    # Launchers
    terminalLauncher = "${mod}, RETURN";
    applicationsLauncher = "${mod}, D";

    # System controls
    volumeUp = ", XF86AudioRaiseVolume";
    volumeDown = ", XF86AudioLowerVolume";
    volumeMute = ", XF86AudioMute";
    brightnessUp = ", XF86MonBrightnessUp";
    brightnessDown = ", XF86MonBrightnessDown";

    # Screenshots
    screenshotFull = "${mod}, P";
    screenshotRegion = "SHIFT, Print";
    # screenshotWindow = "${mod}, Print";

    # Lock screen
    lockScreen = "${mod}, L";
  };

  # Define paths to various executables
  swaylock = "${pkgs.swaylock}/bin/swaylock";
  wofi = "${pkgs.wofi}/bin/wofi";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  terminal = "${pkgs.kitty}/bin/kitty";
  screenshot = "${pkgs.hyprshot}/bin/hyprshot";

in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = [
      # Window management
      "${binds.closeWindow}, killactive"
      "${binds.toggleFloating}, togglefloating"
      "${binds.toggleFullscreen}, fullscreen"

      # Workspace management
      "${binds.workspaceNext}, workspace, e+1"
      "${binds.workspacePrev}, workspace, e-1"
      "${binds.workspaceSwitch1}, workspace, 1"
      "${binds.workspaceSwitch2}, workspace, 2"
      "${binds.workspaceSwitch3}, workspace, 3"
      "${binds.workspaceSwitch4}, workspace, 4"
      "${binds.workspaceSwitch5}, workspace, 5"
      "${binds.workspaceSwitch6}, workspace, 6"
      "${binds.workspaceSwitch7}, workspace, 7"
      "${binds.workspaceSwitch8}, workspace, 8"
      "${binds.workspaceSwitch9}, workspace, 9"
      "${binds.workspaceSwitch10}, workspace, 10"

      # Move windows to workspaces
      "${binds.moveToWorkspace1}, movetoworkspace, 1"
      "${binds.moveToWorkspace2}, movetoworkspace, 2"
      "${binds.moveToWorkspace3}, movetoworkspace, 3"
      "${binds.moveToWorkspace4}, movetoworkspace, 4"
      "${binds.moveToWorkspace5}, movetoworkspace, 5"
      "${binds.moveToWorkspace6}, movetoworkspace, 6"
      "${binds.moveToWorkspace7}, movetoworkspace, 7"
      "${binds.moveToWorkspace8}, movetoworkspace, 8"
      "${binds.moveToWorkspace9}, movetoworkspace, 9"
      "${binds.moveToWorkspace10}, movetoworkspace, 10"

      # Focus
      "${binds.focusLeft}, movefocus, l"
      "${binds.focusRight}, movefocus, r"
      "${binds.focusUp}, movefocus, u"
      "${binds.focusDown}, movefocus, d"

      # Move windows
      "${binds.moveLeft}, movewindow, l"
      "${binds.moveRight}, movewindow, r"
      "${binds.moveUp}, movewindow, u"
      "${binds.moveDown}, movewindow, d"

      # Launchers
      "${binds.terminalLauncher}, exec, ${terminal}"
      "${binds.applicationsLauncher}, exec, ${wofi} --show drun"

      # Lock screen
      # "${binds.lockScreen}, exec, ${swaylock}"

      # Screenshots
      "${binds.screenshotFull}, exec, ${screenshot} -m output -m active -o $HOME/Screenshots -f $(date +'%Y:%m:%d;%H:%M:%S.png')"
      # "${binds.screenshotRegion}, exec, grim -g \"$(slurp)\" ~/Screenshots/$(date +'%Y-%m-%d-%H%M%S_grim.png')"

    ];

    # Correct syntax for Hyprland's resize mode
    # binde = [
    #   "$mod, R, submap, resize"
    # # System controls (using binde for repeat)
    #     "${binds.volumeUp}, exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
    #     "${binds.volumeDown}, exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
    #     "${binds.volumeMute}, exec, ${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
    #     "${binds.brightnessUp}, exec, light -A 5"
    #     "${binds.brightnessDown}, exec, light -U 5"
    # ];
    #
    # "submap=resize" = {
    #   "right, resizeactive, 10 0" = null;
    #   "left, resizeactive, -10 0" = null;
    #   "up, resizeactive, 0 -10" = null;
    #   "down, resizeactive, 0 10" = null;
    #   "escape, submap, reset" = null;
    # };

  };
}
