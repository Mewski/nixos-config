{
  flake.homeModules.dunst = {
    services.dunst = {
      enable = true;

      settings = {
        global = {
          follow = "mouse";
          width = "(0, 300)";
          height = 150;
          origin = "top-center";
          offset = "0x18";
          notification_limit = 5;
          gap_size = 4;
          padding = 12;
          horizontal_padding = 12;
          frame_width = 2;
          corner_radius = 8;
          separator_height = 2;
          sort = "yes";
          idle_threshold = 120;
          line_height = 0;
          markup = "full";
          format = "<b>%s</b>\\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = 60;
          word_wrap = true;
          ellipsize = "middle";
          ignore_newline = false;
          stack_duplicates = true;
          hide_duplicate_count = false;
          show_indicators = false;
          icon_position = "left";
          min_icon_size = 32;
          max_icon_size = 64;
          enable_recursive_icon_lookup = true;
          sticky_history = true;
          history_length = 20;
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
        };

        urgency_low.timeout = 5;
        urgency_normal.timeout = 10;
        urgency_critical.timeout = 0;

        osd = {
          appname = "osd";
          format = "<b>%s</b>";
          alignment = "center";
        };

        osd-text = {
          appname = "osd-text";
          format = "<b>%s</b>";
          alignment = "center";
        };
      };
    };
  };
}
