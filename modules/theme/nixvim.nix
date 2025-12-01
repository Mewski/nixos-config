{
  flake.homeModules.theme =
    {
      scheme,
      fonts,
      ...
    }:
    {
      programs.nixvim = {
        colorschemes.base16 = {
          enable = true;
          colorscheme = {
            base00 = "#${scheme.base00}";
            base01 = "#${scheme.base01}";
            base02 = "#${scheme.base02}";
            base03 = "#${scheme.base03}";
            base04 = "#${scheme.base04}";
            base05 = "#${scheme.base05}";
            base06 = "#${scheme.base06}";
            base07 = "#${scheme.base07}";
            base08 = "#${scheme.base08}";
            base09 = "#${scheme.base09}";
            base0A = "#${scheme.base0A}";
            base0B = "#${scheme.base0B}";
            base0C = "#${scheme.base0C}";
            base0D = "#${scheme.base0D}";
            base0E = "#${scheme.base0E}";
            base0F = "#${scheme.base0F}";
          };
        };

        opts.guifont = "${fonts.monospace.name}:h${toString (builtins.floor fonts.sizes.terminal)}";

        highlightOverride = {
          WinSeparator = {
            fg = "#${scheme.base01}";
            bg = "none";
          };
          VertSplit = {
            fg = "#${scheme.base01}";
            bg = "none";
          };

          NvimTreeNormal = {
            bg = "#${scheme.base00}";
          };
          NvimTreeNormalNC = {
            bg = "#${scheme.base00}";
          };
          NvimTreeWinSeparator = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base00}";
          };
          NvimTreeCursorLine = {
            bg = "#${scheme.base01}";
          };
          NvimTreeIndentMarker = {
            fg = "#${scheme.base02}";
          };
          NvimTreeFolderIcon = {
            fg = "#${scheme.base0D}";
          };
          NvimTreeFolderName = {
            fg = "#${scheme.base0D}";
          };
          NvimTreeOpenedFolderName = {
            fg = "#${scheme.base0D}";
          };
          NvimTreeEmptyFolderName = {
            fg = "#${scheme.base03}";
          };
          NvimTreeGitDirty = {
            fg = "#${scheme.base08}";
          };
          NvimTreeGitNew = {
            fg = "#${scheme.base0B}";
          };
          NvimTreeGitDeleted = {
            fg = "#${scheme.base08}";
          };
          NvimTreeGitStaged = {
            fg = "#${scheme.base0B}";
          };
          NvimTreeSpecialFile = {
            fg = "#${scheme.base0A}";
          };
          NvimTreeRootFolder = {
            fg = "#${scheme.base0E}";
            bold = true;
          };

          BufferLineFill = {
            bg = "#${scheme.base00}";
          };
          BufferLineBackground = {
            fg = "#${scheme.base03}";
            bg = "#${scheme.base00}";
          };
          BufferLineBuffer = {
            fg = "#${scheme.base03}";
            bg = "#${scheme.base00}";
          };
          BufferLineBufferSelected = {
            fg = "#${scheme.base05}";
            bg = "#${scheme.base01}";
            bold = true;
          };
          BufferLineBufferVisible = {
            fg = "#${scheme.base04}";
            bg = "#${scheme.base00}";
          };
          BufferLineCloseButton = {
            fg = "#${scheme.base03}";
            bg = "#${scheme.base00}";
          };
          BufferLineCloseButtonSelected = {
            fg = "#${scheme.base08}";
            bg = "#${scheme.base01}";
          };
          BufferLineCloseButtonVisible = {
            fg = "#${scheme.base03}";
            bg = "#${scheme.base00}";
          };
          BufferLineIndicatorSelected = {
            fg = "#${scheme.base0D}";
            bg = "#${scheme.base01}";
          };
          BufferLineSeparator = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base00}";
          };
          BufferLineSeparatorSelected = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base01}";
          };
          BufferLineSeparatorVisible = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base00}";
          };
          BufferLineModified = {
            fg = "#${scheme.base0B}";
            bg = "#${scheme.base00}";
          };
          BufferLineModifiedSelected = {
            fg = "#${scheme.base0B}";
            bg = "#${scheme.base01}";
          };
          BufferLineModifiedVisible = {
            fg = "#${scheme.base0B}";
            bg = "#${scheme.base00}";
          };

          IblIndent = {
            fg = "#${scheme.base02}";
          };
          IblScope = {
            fg = "#${scheme.base04}";
          };

          TelescopeNormal = {
            bg = "#${scheme.base00}";
          };
          TelescopeBorder = {
            fg = "#${scheme.base01}";
            bg = "#${scheme.base00}";
          };
          TelescopePromptNormal = {
            bg = "#${scheme.base01}";
          };
          TelescopePromptBorder = {
            fg = "#${scheme.base01}";
            bg = "#${scheme.base01}";
          };
          TelescopePromptTitle = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base08}";
          };
          TelescopePreviewTitle = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base0B}";
          };
          TelescopeResultsTitle = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base0D}";
          };
          TelescopeSelection = {
            bg = "#${scheme.base01}";
            fg = "#${scheme.base05}";
          };
          TelescopeResultsDiffAdd = {
            fg = "#${scheme.base0B}";
          };
          TelescopeResultsDiffChange = {
            fg = "#${scheme.base0A}";
          };
          TelescopeResultsDiffDelete = {
            fg = "#${scheme.base08}";
          };

          FloatBorder = {
            fg = "#${scheme.base0D}";
            bg = "#${scheme.base00}";
          };
          NormalFloat = {
            bg = "#${scheme.base00}";
          };

          DiagnosticError = {
            fg = "#${scheme.base08}";
          };
          DiagnosticWarn = {
            fg = "#${scheme.base0A}";
          };
          DiagnosticHint = {
            fg = "#${scheme.base0C}";
          };
          DiagnosticInfo = {
            fg = "#${scheme.base0D}";
          };

          GitSignsAdd = {
            fg = "#${scheme.base0B}";
          };
          GitSignsChange = {
            fg = "#${scheme.base0A}";
          };
          GitSignsDelete = {
            fg = "#${scheme.base08}";
          };

          CursorLine = {
            bg = "#${scheme.base01}";
          };
          CursorLineNr = {
            fg = "#${scheme.base05}";
            bold = true;
          };
          LineNr = {
            fg = "#${scheme.base03}";
          };

          Pmenu = {
            bg = "#${scheme.base01}";
            fg = "#${scheme.base05}";
          };
          PmenuSel = {
            bg = "#${scheme.base02}";
            fg = "#${scheme.base05}";
            bold = true;
          };
          PmenuSbar = {
            bg = "#${scheme.base01}";
          };
          PmenuThumb = {
            bg = "#${scheme.base03}";
          };

          WhichKey = {
            fg = "#${scheme.base0C}";
          };
          WhichKeyGroup = {
            fg = "#${scheme.base0D}";
          };
          WhichKeyDesc = {
            fg = "#${scheme.base0E}";
          };
          WhichKeySeperator = {
            fg = "#${scheme.base03}";
          };
          WhichKeySeparator = {
            fg = "#${scheme.base03}";
          };
          WhichKeyFloat = {
            bg = "#${scheme.base00}";
          };
          WhichKeyValue = {
            fg = "#${scheme.base03}";
          };

          # Lualine (NvChad-style statusline)
          lualine_a_normal = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base0D}";
            bold = true;
          };
          lualine_a_insert = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base0B}";
            bold = true;
          };
          lualine_a_visual = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base0E}";
            bold = true;
          };
          lualine_a_replace = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base08}";
            bold = true;
          };
          lualine_a_command = {
            fg = "#${scheme.base00}";
            bg = "#${scheme.base0A}";
            bold = true;
          };
          lualine_b_normal = {
            fg = "#${scheme.base05}";
            bg = "#${scheme.base01}";
          };
          lualine_c_normal = {
            fg = "#${scheme.base04}";
            bg = "#${scheme.base00}";
          };
        };
      };
    };
}
