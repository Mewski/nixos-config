{
  flake.homeModules.theme =
    {
      preferences,
      scheme,
      fonts,
      polarity,
      ...
    }:
    {
      programs.zed-editor = {
        enable = true;

        userSettings = {
          "buffer_font_family" = fonts.monospace.name;
          "buffer_font_size" = fonts.sizes.terminal * 4.0 / 3.0;
          "ui_font_family" = fonts.sansSerif.name;
          "ui_font_size" = fonts.sizes.application * 4.0 / 3.0;
          "theme" = "Base16 ${scheme.scheme-name}";
        };

        themes = {
          "Base16 ${scheme.scheme-name}" = {
            name = "Base16 ${scheme.scheme-name}";
            author = "${preferences.user.name}";
            themes = [
              {
                name = "Base16 ${scheme.scheme-name}";
                appearance = if polarity == "dark" then "dark" else "light";
                style = {
                  border = "#${scheme.base03}ff";
                  "border.variant" = "#${scheme.base01}ff";
                  "border.focused" = null;
                  "border.selected" = null;
                  "border.transparent" = null;
                  "border.disabled" = null;
                  "elevated_surface.background" = "#${scheme.base01}";
                  "surface.background" = "#${scheme.base00}";
                  background = "#${scheme.base00}";
                  "element.background" = "#${scheme.base00}";
                  "element.hover" = "#${scheme.base01}ff";
                  "element.active" = "#${scheme.base02}ff";
                  "element.selected" = "#${scheme.base02}ff";
                  "element.disabled" = "#${scheme.base03}d3";
                  "ghost_element.background" = "#${scheme.base00}";
                  "ghost_element.hover" = "#${scheme.base01}ff";
                  "ghost_element.active" = "#${scheme.base02}ff";
                  "ghost_element.selected" = "#${scheme.base02}ff";
                  "ghost_element.disabled" = "#${scheme.base03}d3";
                  "drop_target.background" = "#${scheme.base03}d3";
                  text = "#${scheme.base05}";
                  "text.muted" = "#${scheme.base04}";
                  "text.placeholder" = "#${scheme.base03}";
                  "text.disabled" = "#${scheme.base03}";
                  "text.accent" = "#${scheme.base0D}";
                  icon = "#${scheme.base05}";
                  "icon.muted" = "#${scheme.base03}";
                  "icon.disabled" = "#${scheme.base03}";
                  "icon.placeholder" = "#${scheme.base03}";
                  "icon.accent" = "#${scheme.base0D}";
                  "status_bar.background" = "#${scheme.base00}";
                  "title_bar.background" = "#${scheme.base00}";
                  "title_bar.inactive_background" = "#${scheme.base00}";
                  "toolbar.background" = "#${scheme.base00}";
                  "tab_bar.background" = "#${scheme.base00}";
                  "tab.inactive_background" = "#${scheme.base00}";
                  "tab.active_background" = "#${scheme.base01}";
                  "search.match_background" = "#${scheme.base02}";
                  "panel.background" = "#${scheme.base00}";
                  "panel.focused_border" = null;
                  "pane.focused_border" = "#${scheme.base00}";
                  "scrollbar.thumb.background" = "#${scheme.base01}d3";
                  "scrollbar.thumb.hover_background" = "#${scheme.base02}";
                  "scrollbar.thumb.border" = "#00000000";
                  "scrollbar.track.background" = "#00000000";
                  "scrollbar.track.border" = "#00000000";
                  "editor.foreground" = "#${scheme.base05}";
                  "editor.background" = "#${scheme.base00}";
                  "editor.gutter.background" = "#${scheme.base00}";
                  "editor.subheader.background" = "#${scheme.base00}";
                  "editor.active_line.background" = "#${scheme.base01}";
                  "editor.highlighted_line.background" = "#${scheme.base02}";
                  "editor.line_number" = "#${scheme.base03}";
                  "editor.active_line_number" = "#${scheme.base05}";
                  "editor.invisible" = "#${scheme.base03}";
                  "editor.wrap_guide" = "#${scheme.base03}";
                  "editor.active_wrap_guide" = "#${scheme.base03}d3";
                  "editor.document_highlight.read_background" = "#${scheme.base02}d3";
                  "editor.document_highlight.write_background" = "#${scheme.base03}d3";
                  "link_text.hover" = "#${scheme.base0D}";

                  conflict = "#${scheme.base0B}";
                  "conflict.background" = "#${scheme.base0B}d3";
                  "conflict.border" = "#${scheme.base03}";

                  created = "#${scheme.base0B}";
                  "created.background" = "#${scheme.base0B}d3";
                  "created.border" = "#${scheme.base03}";

                  deleted = "#${scheme.base08}";
                  "deleted.background" = "#${scheme.base08}d3";
                  "deleted.border" = "#${scheme.base03}";

                  error = "#${scheme.base08}";
                  "error.background" = "#${scheme.base08}d3";
                  "error.border" = "#${scheme.base03}";

                  hidden = "#${scheme.base03}";
                  "hidden.background" = "#${scheme.base00}";
                  "hidden.border" = "#${scheme.base03}";

                  hint = "#${scheme.base0D}";
                  "hint.background" = "#${scheme.base0D}d3";
                  "hint.border" = "#${scheme.base03}";

                  ignored = "#${scheme.base03}";
                  "ignored.background" = "#${scheme.base00}";
                  "ignored.border" = "#${scheme.base03}";

                  info = "#${scheme.base0D}";
                  "info.background" = "#${scheme.base0D}d3";
                  "info.border" = "#${scheme.base03}";

                  modified = "#${scheme.base0A}";
                  "modified.background" = "#${scheme.base0A}d3";
                  "modified.border" = "#${scheme.base03}";

                  predictive = "#${scheme.base0E}";
                  "predictive.background" = "#${scheme.base0E}d3";
                  "predictive.border" = "#${scheme.base03}";

                  renamed = "#${scheme.base0D}";
                  "renamed.background" = "#${scheme.base0D}d3";
                  "renamed.border" = "#${scheme.base03}";

                  success = "#${scheme.base0B}";
                  "success.background" = "#${scheme.base0B}d3";
                  "success.border" = "#${scheme.base03}";

                  unreachable = "#${scheme.base03}";
                  "unreachable.background" = "#${scheme.base00}";
                  "unreachable.border" = "#${scheme.base03}";

                  warning = "#${scheme.base0A}";
                  "warning.background" = "#${scheme.base0A}d3";
                  "warning.border" = "#${scheme.base03}";

                  players = [
                    {
                      cursor = "#${scheme.base0D}";
                      background = "#${scheme.base0D}20";
                      selection = "#${scheme.base0D}30";
                    }
                    {
                      cursor = "#${scheme.base0E}";
                      background = "#${scheme.base0E}20";
                      selection = "#${scheme.base0E}30";
                    }
                    {
                      cursor = "#${scheme.base0E}";
                      background = "#${scheme.base0E}20";
                      selection = "#${scheme.base0E}30";
                    }
                    {
                      cursor = "#${scheme.base09}";
                      background = "#${scheme.base09}20";
                      selection = "#${scheme.base09}30";
                    }
                    {
                      cursor = "#${scheme.base0B}";
                      background = "#${scheme.base0B}20";
                      selection = "#${scheme.base0B}30";
                    }
                    {
                      cursor = "#${scheme.base08}";
                      background = "#${scheme.base08}20";
                      selection = "#${scheme.base08}30";
                    }
                    {
                      cursor = "#${scheme.base0A}";
                      background = "#${scheme.base0A}20";
                      selection = "#${scheme.base0A}30";
                    }
                    {
                      cursor = "#${scheme.base0B}";
                      background = "#${scheme.base0B}20";
                      selection = "#${scheme.base0B}30";
                    }
                  ];

                  syntax = {
                    attribute = {
                      color = "#${scheme.base0D}";
                      font_style = null;
                      font_weight = null;
                    };
                    boolean = {
                      color = "#${scheme.base0E}";
                      font_style = null;
                      font_weight = null;
                    };
                    comment = {
                      color = "#${scheme.base03}";
                      font_style = "italic";
                      font_weight = null;
                    };
                    "comment.doc" = {
                      color = "#${scheme.base03}";
                      font_style = "italic";
                      font_weight = 700;
                    };
                    constant = {
                      color = "#${scheme.base0E}";
                      font_style = null;
                      font_weight = null;
                    };
                    constructor = {
                      color = "#${scheme.base0B}";
                      font_style = null;
                      font_weight = null;
                    };
                    directive = {
                      color = "#${scheme.base0E}";
                      font_style = null;
                      font_weight = null;
                    };
                    escape = {
                      color = "#${scheme.base0D}";
                      font_style = "italic";
                      font_weight = null;
                    };
                    function = {
                      color = "#${scheme.base0D}";
                      font_style = "italic";
                      font_weight = null;
                    };
                    "function.decorator" = {
                      color = "#${scheme.base0D}";
                      font_style = "italic";
                      font_weight = null;
                    };
                    "function.magic" = {
                      color = "#${scheme.base0D}";
                      font_style = "italic";
                      font_weight = null;
                    };
                    keyword = {
                      color = "#${scheme.base0E}";
                      font_style = "italic";
                      font_weight = null;
                    };
                    label = {
                      color = "#${scheme.base05}";
                      font_style = null;
                      font_weight = null;
                    };
                    local = {
                      color = "#${scheme.base08}";
                      font_style = null;
                      font_weight = null;
                    };
                    markup = {
                      color = "#${scheme.base09}";
                      font_style = null;
                      font_weight = null;
                    };
                    meta = {
                      color = "#${scheme.base05}";
                      font_style = null;
                      font_weight = null;
                    };
                    modifier = {
                      color = "#${scheme.base05}";
                      font_style = null;
                      font_weight = null;
                    };
                    namespace = {
                      color = "#${scheme.base08}";
                      font_style = null;
                      font_weight = null;
                    };
                    number = {
                      color = "#${scheme.base0A}";
                      font_style = null;
                      font_weight = null;
                    };
                    operator = {
                      color = "#${scheme.base0E}";
                      font_style = null;
                      font_weight = null;
                    };
                    parameter = {
                      color = "#${scheme.base05}";
                      font_style = null;
                      font_weight = null;
                    };
                    punctuation = {
                      color = "#${scheme.base05}";
                      font_style = null;
                      font_weight = null;
                    };
                    regexp = {
                      color = "#${scheme.base0C}";
                      font_style = null;
                      font_weight = null;
                    };
                    self = {
                      color = "#${scheme.base05}";
                      font_style = null;
                      font_weight = 700;
                    };
                    string = {
                      color = "#${scheme.base0B}";
                      font_style = null;
                      font_weight = null;
                    };
                    strong = {
                      color = "#${scheme.base0D}";
                      font_style = null;
                      font_weight = 700;
                    };
                    support = {
                      color = "#${scheme.base0E}";
                      font_style = null;
                      font_weight = null;
                    };
                    symbol = {
                      color = "#${scheme.base0A}";
                      font_style = null;
                      font_weight = null;
                    };
                    tag = {
                      color = "#${scheme.base0D}";
                      font_style = null;
                      font_weight = null;
                    };
                    text = {
                      color = "#${scheme.base05}";
                      font_style = null;
                      font_weight = null;
                    };
                    type = {
                      color = "#${scheme.base0B}";
                      font_style = null;
                      font_weight = null;
                    };
                    variable = {
                      color = "#${scheme.base05}";
                      font_style = null;
                      font_weight = null;
                    };
                  };

                  "terminal.background" = "#${scheme.base00}ff";
                  "terminal.foreground" = "#${scheme.base05}ff";
                  "terminal.ansi.black" = "#${scheme.base00}ff";
                  "terminal.ansi.red" = "#${scheme.base08}ff";
                  "terminal.ansi.green" = "#${scheme.base0B}ff";
                  "terminal.ansi.yellow" = "#${scheme.base0A}ff";
                  "terminal.ansi.blue" = "#${scheme.base0D}ff";
                  "terminal.ansi.magenta" = "#${scheme.base0E}ff";
                  "terminal.ansi.cyan" = "#${scheme.base0C}ff";
                  "terminal.ansi.white" = "#${scheme.base05}ff";
                  "terminal.ansi.bright_black" = "#${scheme.base03}ff";
                  "terminal.ansi.bright_red" = "#${scheme.base08}ff";
                  "terminal.ansi.bright_green" = "#${scheme.base0B}ff";
                  "terminal.ansi.bright_yellow" = "#${scheme.base0A}ff";
                  "terminal.ansi.bright_blue" = "#${scheme.base0D}ff";
                  "terminal.ansi.bright_magenta" = "#${scheme.base0E}ff";
                  "terminal.ansi.bright_cyan" = "#${scheme.base0C}ff";
                  "terminal.ansi.bright_white" = "#${scheme.base05}ff";
                };
              }
            ];
          };
        };
      };
    };
}
