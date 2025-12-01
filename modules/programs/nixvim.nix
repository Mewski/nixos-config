{ inputs, ... }:
{
  flake.homeModules.nixvim = {
    imports = [ inputs.nixvim.homeModules.nixvim ];

    programs.nixvim = {
      enable = true;

      defaultEditor = true;

      globals.mapleader = " ";

      opts = {
        number = true;
        relativenumber = true;

        shiftwidth = 2;

        foldcolumn = "1";
        foldlevel = 99;
        foldlevelstart = 99;
        foldenable = true;
      };

      autoCmd = [
        {
          event = [ "VimEnter" ];
          callback = {
            __raw = ''
              function()
                pcall(vim.cmd.aunmenu, {'PopUp.How-to\\ disable\\ mouse'})
                pcall(vim.cmd.aunmenu, {'PopUp.-2-'})
              end
            '';
          };
        }
      ];

      keymaps = [
        {
          mode = "n";
          key = "<leader>a";
          action.__raw = "function() require'harpoon':list():add() end";
        }
        {
          mode = "n";
          key = "<C-e>";
          action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
        }
        {
          mode = "n";
          key = "<C-h>";
          action.__raw = "function() require'harpoon':list():select(1) end";
        }
        {
          mode = "n";
          key = "<C-j>";
          action.__raw = "function() require'harpoon':list():select(2) end";
        }
        {
          mode = "n";
          key = "<C-k>";
          action.__raw = "function() require'harpoon':list():select(3) end";
        }
        {
          mode = "n";
          key = "<C-l>";
          action.__raw = "function() require'harpoon':list():select(4) end";
        }
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>Neotree toggle<cr>";
        }
        {
          mode = "n";
          key = "-";
          action = "<cmd>Oil<cr>";
        }
      ];

      plugins = {
        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
        };

        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
          };
        };

        harpoon.enable = true;

        oil = {
          enable = true;
          settings = {
            view_options.show_hidden = true;
          };
        };

        neo-tree = {
          enable = true;
          settings.close_if_last_window = true;
        };

        web-devicons.enable = true;

        nvim-ufo.enable = true;
        lualine.enable = true;
        which-key.enable = true;
        luasnip.enable = true;

        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.close()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            };
          };
        };

        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            lua_ls.enable = true;
          };
        };

        comment.enable = true;
        nvim-autopairs.enable = true;
        illuminate.enable = true;

        conform-nvim = {
          enable = true;
          settings = {
            format_on_save = {
              timeout_ms = 500;
              lsp_fallback = true;
            };
          };
        };

        trouble.enable = true;
        gitsigns.enable = true;
        diffview.enable = true;
      };
    };
  };
}
