{ pkgs, config, inputs, lib, palette, ... }:

{
  imports = [
    ../common
    ./keybinds.nix
  ];

  home.packages = with pkgs;
    [
      hyprland
      swww # for wallpapers
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xwayland
      meson
      wayland-protocols
      wayland-utils
      wl-clipboard
      wlroots
      hyprshot
      slurp
    ];

  wayland.windowManager.hyprland = {
    xwayland.enable = true;
    enable = true;
    systemd = {
      enable = true;
      # Same as default, but stop graphical-session too
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
    settings = {
      general = {
        sensitivity = 0.8;
        apply_sens_to_raw = true;
        border_size = 0;
        no_border_on_floating = false;
        gaps_in = 5;
        gaps_out = 10;
        # cursor_inactive_timeout = 1;
        layout = "dwindle";
      };
      decoration = {
        rounding = 7;
        # multisample_edges = true;
        active_opacity = 0.8;
        inactive_opacity = 0.5;
        fullscreen_opacity = 1.0;
        blur = {
          enabled = true;
          size = 4;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
        };
        drop_shadow = false;
        shadow_range = 12;
        shadow_offset = "3 3";
      };
      group = {
        groupbar = {
          font_size = 11;
        };
      };
      input = {
        kb_layout = "us";
        follow_mouse = 2;
        repeat_rate = 200;
        repeat_delay = 700;
        force_no_accel = true;
        sensitivity = 0.8;
        touchpad.disable_while_typing = true;
      };
      dwindle.split_width_multiplier = 1.35;
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
        close_special_on_empty = true;
        # Unfullscreen when opening something
        new_window_takes_over_fullscreen = 2;
      };
      layerrule = [
        "blur,waybar"
        "ignorezero,waybar"
      ];



      animations = {
        enabled = true;
        bezier = [
          "easein,0.11, 0, 0.5, 0"
          "easeout,0.5, 1, 0.89, 1"
          "easeinback,0.36, 0, 0.66, -0.56"
          "easeoutback,0.34, 1.56, 0.64, 1"
        ];

        animation = [
          "windowsIn,1,3,easeoutback,slide"
          "windowsOut,1,3,easeinback,slide"
          "windowsMove,1,3,easeoutback"
          "workspaces,1,2,easeoutback,slide"
          "fadeIn,1,3,easeout"
          "fadeOut,1,3,easein"
          "fadeSwitch,1,3,easeout"
          "fadeShadow,1,3,easeout"
          "fadeDim,1,3,easeout"
          "border,1,3,easeout"
        ];
      };
    };
    extraConfig = ''
      # monitor = HDMI-A-1,1920x1080@60,0x0,0.8
    '';
    #     # palette
    #     $background = ${palette.background}
    #     $foreground = ${palette.foreground}
    #     $cursor = ${palette.cursor}
    #     $black = ${palette.black}
    #     $red = ${palette.red}
    #     $green = ${palette.green}
    #     $yellow = ${palette.yellow}
    #     $blue = ${palette.blue}
    #     $magenta = ${palette.magenta}
    #     $cyan = ${palette.cyan}
    #     $white = ${palette.white}
    #
    #     general {
    #       col.active_border = ${palette.accent1}
    #       col.inactive_border = ${palette.brightBlack}
    #         # col.active_border = rgba(${palette.accent1}ee)
    #         # col.inactive_border = rgba(${palette.brightBlack}aa)
    #     }
    #
    #     decoration {
    #         col.shadow = rgba(1a1a1aee)
    #     }
    #   '';

  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Hint Electon apps to use wayland
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };


}
