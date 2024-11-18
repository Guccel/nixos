{ lib, config, pkgs, inputs, ... }: {
  imports = [
    # ../common
    ../common/mako.nix
    ../common/wofi.nix
    ../common/gammastep.nix

    ./basic-binds.nix
    ./hyprbars.nix
  ];

  xdg.portal = {
    extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.inputs.hyprland.hyprland ];
  };

  home.packages = with pkgs; [
    # inputs.hyprwm-contrib.grimblast
    # hyprslurp
    # hyprpicker
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.inputs.hyprland.hyprland.override { wrapRuntimeDeps = false; };
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
        gaps_in = 15;
        gaps_out = 20;
        border_size = 2.7;
        cursor_inactive_timeout = 4;
        "col.active_border" = "0xff${config.colorscheme.colors.base0C}";
        "col.inactive_border" = "0xff${config.colorscheme.colors.base02}";
      };
      group = {
        "col.border_active" = "0xff${config.colorscheme.colors.base0B}";
        "col.border_inactive" = "0xff${config.colorscheme.colors.base04}";
        groupbar = {
          font_size = 11;
        };
      };
      input = {
        kb_layout = "us";
        touchpad.disable_while_typing = false;
      };
      dwindle.split_width_multiplier = 1.35;
      misc = {
        vfr = true;
        close_special_on_empty = true;
        # Unfullscreen when opening something
        new_window_takes_over_fullscreen = 2;
      };
      layerrule = [
        "blur,waybar"
        "ignorezero,waybar"
      ];

      decoration = {
        active_opacity = 0.97;
        inactive_opacity = 0.77;
        fullscreen_opacity = 1.0;
        rounding = 7;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
        };
        drop_shadow = true;
        shadow_range = 12;
        shadow_offset = "3 3";
      };
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

      exec = [
        # "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"
      ];

      bind =
        let
          swaylock = "${config.programs.swaylock.package}/bin/swaylock";
          playerctl = "${config.services.playerctld.package}/bin/playerctl";
          playerctld = "${config.services.playerctld.package}/bin/playerctld";
          makoctl = "${config.services.mako.package}/bin/makoctl";
          wofi = "${config.programs.wofi.package}/bin/wofi";
          pass-wofi = "${pkgs.pass-wofi.override {
          pass = config.programs.password-store.package;
        }}/bin/pass-wofi";

          pactl = "${pkgs.pulseaudio}/bin/pactl";
          tly = "${pkgs.tly}/bin/tly";
          gtk-play = "${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play";
          notify-send = "${pkgs.libnotify}/bin/notify-send";

          gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
          xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
          defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";

          terminal = "${pkgs.alacritty}/bin/alacritty";

          browser = defaultApp "x-scheme-handler/https";
          editor = defaultApp "text/plain";
        in
        [
          # Program bindings
          "SUPER,Return,exec,${terminal}"
          "SUPER,e,exec,${editor}"
          "SUPER,b,exec,${browser}"
          # Brightness control (only works if the system has lightd)
          ",XF86MonBrightnessUp,exec,light -A 10"
          ",XF86MonBrightnessDown,exec,light -U 10"
          # Volume
          ",XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
          ",XF86AudioMute,exec,${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
          "SHIFT,XF86AudioMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
          ",XF86AudioMicMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
        ] ++

        (lib.optionals config.services.playerctld.enable [
          # Media control
          ",XF86AudioNext,exec,${playerctl} next"
          ",XF86AudioPrev,exec,${playerctl} previous"
          ",XF86AudioPlay,exec,${playerctl} play-pause"
          ",XF86AudioStop,exec,${playerctl} stop"
          "ALT,XF86AudioNext,exec,${playerctld} shift"
          "ALT,XF86AudioPrev,exec,${playerctld} unshift"
          "ALT,XF86AudioPlay,exec,systemctl --user restart playerctld"
        ]) ++
        # Notification manager
        (lib.optionals config.services.mako.enable [
          "SUPER,w,exec,${makoctl} dismiss"
        ]) ++

        # Launcher
        (lib.optionals config.programs.wofi.enable [
          "SUPER,x,exec,${wofi} -S drun -x 10 -y 10 -W 25% -H 60%"
          "SUPER,d,exec,${wofi} -S run"
        ] ++ (lib.optionals config.programs.password-store.enable [
          ",Scroll_Lock,exec,${pass-wofi}" # fn+k
          ",XF86Calculator,exec,${pass-wofi}" # fn+f12
          "SUPER,semicolon,exec,pass-wofi"
        ]));

      # monitor = map
      #   (m:
      #     let
      #       resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
      #       position = "${toString m.x}x${toString m.y}";
      #     in
      #     "${m.name},${if m.enabled then "${resolution},${position},1" else "disable"}"
      #   )
      #   (config.monitors);

      # workspace = map
      #   (m:
      #     "${m.name},${m.workspace}"
      #   )
      #   (lib.filter (m: m.enabled && m.workspace != null) config.monitors);

    };
    # This is order sensitive, so it has to come here.
    extraConfig = ''
      # Passthrough mode (e.g. for VNC)
      bind=SUPER,P,submap,passthrough
      submap=passthrough
      bind=SUPER,P,submap,reset
      submap=reset
    '';
  };
}