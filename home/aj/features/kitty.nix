{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 0;
      startup_session = "launch ${pkgs.zsh}/bin/zsh";

      font_size = "10.0";

      cursor = "none";
      cursor_text_color = "background";
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_blink_interval = 0;

      repaint_delay = 100;
    };
  };
}
