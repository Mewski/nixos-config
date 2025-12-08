{
  flake.homeModules.theme =
    {
      theme,
      scheme,
      ...
    }:
    {
      programs.zen-browser.profiles.default = {
        settings = {
          "zen.view.window.scheme" = if theme.polarity == "dark" then 0 else 1;
          "layout.css.prefers-color-scheme.content-override" = if theme.polarity == "dark" then 0 else 1;
          "devtools.theme" = if theme.polarity == "dark" then "dark" else "light";
          "zen.theme.accent-color" = scheme.withHashtag.base0D;
        };

        userChrome = ''
          :root {
            --zen-colors-primary: ${scheme.withHashtag.base02} !important;
            --zen-primary-color: ${scheme.withHashtag.base0D} !important;
            --zen-colors-secondary: ${scheme.withHashtag.base02} !important;
            --zen-colors-tertiary: ${scheme.withHashtag.base01} !important;
            --zen-colors-border: ${scheme.withHashtag.base0D} !important;
            --toolbarbutton-icon-fill: ${scheme.withHashtag.base0D} !important;
            --lwt-text-color: ${scheme.withHashtag.base05} !important;
            --toolbar-field-color: ${scheme.withHashtag.base05} !important;
            --tab-selected-textcolor: ${scheme.withHashtag.base05} !important;
            --toolbar-field-focus-color: ${scheme.withHashtag.base05} !important;
            --toolbar-color: ${scheme.withHashtag.base05} !important;
            --newtab-text-primary-color: ${scheme.withHashtag.base05} !important;
            --arrowpanel-color: ${scheme.withHashtag.base05} !important;
            --arrowpanel-background: ${scheme.withHashtag.base00} !important;
            --sidebar-text-color: ${scheme.withHashtag.base05} !important;
            --lwt-sidebar-text-color: ${scheme.withHashtag.base05} !important;
            --lwt-sidebar-background-color: ${scheme.withHashtag.base00} !important;
            --toolbar-bgcolor: ${scheme.withHashtag.base02} !important;
            --newtab-background-color: ${scheme.withHashtag.base00} !important;
            --zen-themed-toolbar-bg: ${scheme.withHashtag.base00} !important;
            --zen-main-browser-background: ${scheme.withHashtag.base00} !important;
            --toolbox-bgcolor-inactive: ${scheme.withHashtag.base01} !important;
          }

          #permissions-granted-icon {
            color: ${scheme.withHashtag.base05} !important;
          }

          .sidebar-placesTree {
            background-color: ${scheme.withHashtag.base00} !important;
          }

          #zen-workspaces-button {
            background-color: ${scheme.withHashtag.base00} !important;
          }

          #TabsToolbar {
            background-color: ${scheme.withHashtag.base00} !important;
          }

          .urlbar-background {
            background-color: ${scheme.withHashtag.base02} !important;
          }

          .content-shortcuts {
            background-color: ${scheme.withHashtag.base00} !important;
            border-color: ${scheme.withHashtag.base0D} !important;
          }

          .urlbarView-url {
            color: ${scheme.withHashtag.base0D} !important;
          }

          #urlbar-input::selection {
            background-color: ${scheme.withHashtag.base0D} !important;
            color: ${scheme.withHashtag.base00} !important;
          }

          #zenEditBookmarkPanelFaviconContainer {
            background: ${scheme.withHashtag.base00} !important;
          }

          #zen-media-controls-toolbar {
            & #zen-media-progress-bar {
              &::-moz-range-track {
                background: ${scheme.withHashtag.base02} !important;
              }
            }
          }

          toolbar .toolbarbutton-1 {
            &:not([disabled]) {
              &:is([open], [checked])
                > :is(
                  .toolbarbutton-icon,
                  .toolbarbutton-text,
                  .toolbarbutton-badge-stack
                ) {
                fill: ${scheme.withHashtag.base00};
              }
            }
          }

          .identity-color-blue {
            --identity-tab-color: ${scheme.withHashtag.base0D} !important;
            --identity-icon-color: ${scheme.withHashtag.base0D} !important;
          }

          .identity-color-turquoise {
            --identity-tab-color: ${scheme.withHashtag.base0C} !important;
            --identity-icon-color: ${scheme.withHashtag.base0C} !important;
          }

          .identity-color-green {
            --identity-tab-color: ${scheme.withHashtag.base0B} !important;
            --identity-icon-color: ${scheme.withHashtag.base0B} !important;
          }

          .identity-color-yellow {
            --identity-tab-color: ${scheme.withHashtag.base0A} !important;
            --identity-icon-color: ${scheme.withHashtag.base0A} !important;
          }

          .identity-color-orange {
            --identity-tab-color: ${scheme.withHashtag.base09} !important;
            --identity-icon-color: ${scheme.withHashtag.base09} !important;
          }

          .identity-color-red {
            --identity-tab-color: ${scheme.withHashtag.base08} !important;
            --identity-icon-color: ${scheme.withHashtag.base08} !important;
          }

          .identity-color-pink {
            --identity-tab-color: ${scheme.withHashtag.base0E} !important;
            --identity-icon-color: ${scheme.withHashtag.base0E} !important;
          }

          .identity-color-purple {
            --identity-tab-color: ${scheme.withHashtag.base0F} !important;
            --identity-icon-color: ${scheme.withHashtag.base0F} !important;
          }

          hbox#titlebar {
            background-color: ${scheme.withHashtag.base00} !important;
          }

          #zen-appcontent-navbar-container {
            background-color: ${scheme.withHashtag.base00} !important;
          }

          #contentAreaContextMenu menu,
          menuitem,
          menupopup {
            color: ${scheme.withHashtag.base05} !important;
          }
        '';

        userContent = ''
          @-moz-document url-prefix("about:") {
            :root {
              --in-content-page-color: ${scheme.withHashtag.base05} !important;
              --color-accent-primary: ${scheme.withHashtag.base0D} !important;
              --color-accent-primary-hover: ${scheme.withHashtag.base0D} !important;
              --color-accent-primary-active: ${scheme.withHashtag.base0D} !important;
              background-color: ${scheme.withHashtag.base00} !important;
              --in-content-page-background: ${scheme.withHashtag.base00} !important;
            }
          }

          @-moz-document url("about:newtab"), url("about:home") {
            :root {
              --newtab-background-color: ${scheme.withHashtag.base00} !important;
              --newtab-background-color-secondary: ${scheme.withHashtag.base02} !important;
              --newtab-element-hover-color: ${scheme.withHashtag.base02} !important;
              --newtab-text-primary-color: ${scheme.withHashtag.base05} !important;
              --newtab-wordmark-color: ${scheme.withHashtag.base05} !important;
              --newtab-primary-action-background: ${scheme.withHashtag.base0D} !important;
            }

            .icon {
              color: ${scheme.withHashtag.base0D} !important;
            }

            .card-outer:is(:hover, :focus, .active):not(.placeholder) .card-title {
              color: ${scheme.withHashtag.base0D} !important;
            }

            .top-site-outer .search-topsite {
              background-color: ${scheme.withHashtag.base0D} !important;
            }

            .compact-cards .card-outer .card-context .card-context-icon.icon-download {
              fill: ${scheme.withHashtag.base0B} !important;
            }
          }

          @-moz-document url-prefix("about:preferences") {
            :root {
              --zen-colors-tertiary: ${scheme.withHashtag.base01} !important;
              --in-content-text-color: ${scheme.withHashtag.base05} !important;
              --link-color: ${scheme.withHashtag.base0D} !important;
              --link-color-hover: ${scheme.withHashtag.base0D} !important;
              --zen-colors-primary: ${scheme.withHashtag.base02} !important;
              --in-content-box-background: ${scheme.withHashtag.base02} !important;
              --zen-primary-color: ${scheme.withHashtag.base0D} !important;
            }

            groupbox, moz-card {
              background: ${scheme.withHashtag.base00} !important;
            }

            button,
            groupbox menulist {
              background: ${scheme.withHashtag.base02} !important;
              color: ${scheme.withHashtag.base05} !important;
            }

            .main-content {
              background-color: ${scheme.withHashtag.base00} !important;
            }

            .identity-color-blue {
              --identity-tab-color: ${scheme.withHashtag.base0D} !important;
              --identity-icon-color: ${scheme.withHashtag.base0D} !important;
            }

            .identity-color-turquoise {
              --identity-tab-color: ${scheme.withHashtag.base0C} !important;
              --identity-icon-color: ${scheme.withHashtag.base0C} !important;
            }

            .identity-color-green {
              --identity-tab-color: ${scheme.withHashtag.base0B} !important;
              --identity-icon-color: ${scheme.withHashtag.base0B} !important;
            }

            .identity-color-yellow {
              --identity-tab-color: ${scheme.withHashtag.base0A} !important;
              --identity-icon-color: ${scheme.withHashtag.base0A} !important;
            }

            .identity-color-orange {
              --identity-tab-color: ${scheme.withHashtag.base09} !important;
              --identity-icon-color: ${scheme.withHashtag.base09} !important;
            }

            .identity-color-red {
              --identity-tab-color: ${scheme.withHashtag.base08} !important;
              --identity-icon-color: ${scheme.withHashtag.base08} !important;
            }

            .identity-color-pink {
              --identity-tab-color: ${scheme.withHashtag.base0E} !important;
              --identity-icon-color: ${scheme.withHashtag.base0E} !important;
            }

            .identity-color-purple {
              --identity-tab-color: ${scheme.withHashtag.base0F} !important;
              --identity-icon-color: ${scheme.withHashtag.base0F} !important;
            }
          }

          @-moz-document url-prefix("about:addons") {
            :root {
              --zen-dark-color-mix-base: ${scheme.withHashtag.base01} !important;
              --background-color-box: ${scheme.withHashtag.base00} !important;
            }
          }

          @-moz-document url-prefix("about:protections") {
            :root {
              --zen-primary-color: ${scheme.withHashtag.base00} !important;
              --social-color: ${scheme.withHashtag.base0E} !important;
              --coockie-color: ${scheme.withHashtag.base0D} !important;
              --fingerprinter-color: ${scheme.withHashtag.base0A} !important;
              --cryptominer-color: ${scheme.withHashtag.base0F} !important;
              --tracker-color: ${scheme.withHashtag.base0B} !important;
              --in-content-primary-button-background-hover: ${scheme.withHashtag.base03} !important;
              --in-content-primary-button-text-color-hover: ${scheme.withHashtag.base05} !important;
              --in-content-primary-button-background: ${scheme.withHashtag.base03} !important;
              --in-content-primary-button-text-color: ${scheme.withHashtag.base05} !important;
            }

            .card {
              background-color: ${scheme.withHashtag.base02} !important;
            }
          }
        '';
      };
    };
}
