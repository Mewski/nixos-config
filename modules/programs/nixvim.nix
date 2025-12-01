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
        tabstop = 2;
        expandtab = true;
        smartindent = true;
        wrap = false;
        swapfile = false;
        backup = false;
        undofile = true;
        hlsearch = true;
        incsearch = true;
        termguicolors = true;
        scrolloff = 8;
        signcolumn = "yes";
        updatetime = 50;
        colorcolumn = "80";
        laststatus = 3;
        showmode = false;
        cursorline = true;
        splitbelow = true;
        splitright = true;
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
          mode = "i";
          key = "<C-b>";
          action = "<ESC>^i";
          options.desc = "Beginning of line";
        }
        {
          mode = "i";
          key = "<C-e>";
          action = "<End>";
          options.desc = "End of line";
        }
        {
          mode = "i";
          key = "<C-h>";
          action = "<Left>";
          options.desc = "Move left";
        }
        {
          mode = "i";
          key = "<C-l>";
          action = "<Right>";
          options.desc = "Move right";
        }
        {
          mode = "i";
          key = "<C-j>";
          action = "<Down>";
          options.desc = "Move down";
        }
        {
          mode = "i";
          key = "<C-k>";
          action = "<Up>";
          options.desc = "Move up";
        }

        {
          mode = "n";
          key = "<Esc>";
          action = "<cmd>noh<CR>";
          options.desc = "Clear highlights";
        }
        {
          mode = "n";
          key = "<C-s>";
          action = "<cmd>w<CR>";
          options.desc = "Save file";
        }
        {
          mode = "n";
          key = "<C-c>";
          action = "<cmd>%y+<CR>";
          options.desc = "Copy entire file";
        }

        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
          options.desc = "Window left";
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
          options.desc = "Window right";
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
          options.desc = "Window down";
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
          options.desc = "Window up";
        }

        {
          mode = "n";
          key = "<leader>n";
          action = "<cmd>set nu!<CR>";
          options.desc = "Toggle line number";
        }
        {
          mode = "n";
          key = "<leader>rn";
          action = "<cmd>set rnu!<CR>";
          options.desc = "Toggle relative number";
        }

        {
          mode = "n";
          key = "<C-n>";
          action = "<cmd>NvimTreeToggle<CR>";
          options.desc = "Toggle file tree";
        }
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>NvimTreeFocus<CR>";
          options.desc = "Focus file tree";
        }

        {
          mode = "n";
          key = "<Tab>";
          action = "<cmd>bnext<CR>";
          options.desc = "Next buffer";
        }
        {
          mode = "n";
          key = "<S-Tab>";
          action = "<cmd>bprev<CR>";
          options.desc = "Previous buffer";
        }
        {
          mode = "n";
          key = "<leader>x";
          action = "<cmd>bdelete<CR>";
          options.desc = "Close buffer";
        }
        {
          mode = "n";
          key = "<leader>b";
          action = "<cmd>enew<CR>";
          options.desc = "New buffer";
        }

        {
          mode = "n";
          key = "<leader>/";
          action = "gcc";
          options = {
            desc = "Toggle comment";
            remap = true;
          };
        }
        {
          mode = "v";
          key = "<leader>/";
          action = "gc";
          options = {
            desc = "Toggle comment";
            remap = true;
          };
        }

        {
          mode = "n";
          key = "<leader>fm";
          action.__raw = ''function() require("conform").format({ lsp_fallback = true }) end'';
          options.desc = "Format file";
        }

        {
          mode = "n";
          key = "<leader>ds";
          action.__raw = "vim.diagnostic.setloclist";
          options.desc = "LSP diagnostic loclist";
        }

        {
          mode = "t";
          key = "<C-x>";
          action = "<C-\\><C-N>";
          options.desc = "Exit terminal mode";
        }

        {
          mode = "n";
          key = "<leader>h";
          action.__raw = ''
            function()
              require("toggleterm.terminal").Terminal:new({ direction = "horizontal" }):toggle()
            end
          '';
          options.desc = "New horizontal terminal";
        }
        {
          mode = "n";
          key = "<leader>v";
          action.__raw = ''
            function()
              require("toggleterm.terminal").Terminal:new({ direction = "vertical" }):toggle()
            end
          '';
          options.desc = "New vertical terminal";
        }

        {
          mode = "n";
          key = "<leader>wK";
          action = "<cmd>WhichKey<CR>";
          options.desc = "All keymaps";
        }
        {
          mode = "n";
          key = "<leader>wk";
          action.__raw = ''function() vim.cmd("WhichKey " .. vim.fn.input("WhichKey: ")) end'';
          options.desc = "Query keymap";
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
          settings = {
            defaults = {
              prompt_prefix = "   ";
              selection_caret = " ";
              entry_prefix = " ";
              sorting_strategy = "ascending";
              layout_config = {
                horizontal = {
                  prompt_position = "top";
                  preview_width = 0.55;
                };
                width = 0.87;
                height = 0.80;
              };
            };
          };
          keymaps = {
            "<leader>ff" = {
              action = "find_files";
              options.desc = "Find files";
            };
            "<leader>fa" = {
              action = "find_files";
              options = {
                desc = "Find all files";
              };
            };
            "<leader>fw" = {
              action = "live_grep";
              options.desc = "Live grep";
            };
            "<leader>fb" = {
              action = "buffers";
              options.desc = "Find buffers";
            };
            "<leader>fh" = {
              action = "help_tags";
              options.desc = "Help tags";
            };
            "<leader>fo" = {
              action = "oldfiles";
              options.desc = "Recent files";
            };
            "<leader>fz" = {
              action = "current_buffer_fuzzy_find";
              options.desc = "Fuzzy current buffer";
            };
            "<leader>ma" = {
              action = "marks";
              options.desc = "Find marks";
            };
            "<leader>cm" = {
              action = "git_commits";
              options.desc = "Git commits";
            };
            "<leader>gt" = {
              action = "git_status";
              options.desc = "Git status";
            };
          };
        };

        nvim-tree = {
          enable = true;
          settings = {
            disable_netrw = true;
            hijack_cursor = true;
            sync_root_with_cwd = true;
            update_focused_file = {
              enable = true;
              update_root = false;
            };
            view = {
              width = 30;
              preserve_window_proportions = true;
            };
            renderer = {
              root_folder_label = false;
              highlight_git = true;
              indent_markers.enable = true;
              icons = {
                glyphs = {
                  default = "󰈚";
                  folder = {
                    default = "";
                    empty = "";
                    empty_open = "";
                    open = "";
                    symlink = "";
                  };
                  git = {
                    unmerged = "";
                  };
                };
              };
            };
            filters = {
              dotfiles = false;
            };
          };
        };

        web-devicons.enable = true;

        colorizer = {
          enable = true;
          settings = {
            user_default_options = {
              RGB = true;
              RRGGBB = true;
              names = false;
              RRGGBBAA = true;
              rgb_fn = true;
              hsl_fn = true;
              css = true;
              css_fn = true;
              mode = "background";
            };
          };
        };

        bufferline = {
          enable = true;
          settings.options = {
            mode = "buffers";
            themable = true;
            buffer_close_icon = "󰅖";
            modified_icon = "";
            close_icon = "󰅖";
            left_trunc_marker = "";
            right_trunc_marker = "";
            max_name_length = 14;
            max_prefix_length = 13;
            tab_size = 20;
            offsets = [
              {
                filetype = "NvimTree";
                text = "";
                text_align = "center";
                separator = true;
              }
            ];
            show_buffer_icons = true;
            show_buffer_close_icons = true;
            show_close_icon = false;
            show_tab_indicators = true;
            separator_style = "thin";
            enforce_regular_tabs = false;
            always_show_bufferline = true;
            indicator = {
              style = "icon";
              icon = "▎";
            };
          };
        };

        lualine = {
          enable = true;
          settings = {
            options = {
              theme = "auto";
              globalstatus = true;
              component_separators = {
                left = "";
                right = "";
              };
              section_separators = {
                left = "";
                right = "";
              };
            };
            sections = {
              lualine_a = [
                {
                  __unkeyed-1 = "mode";
                  separator = {
                    left = "";
                    right = "";
                  };
                }
              ];
              lualine_b = [
                {
                  __unkeyed-1 = "filetype";
                  icon_only = true;
                  separator = "";
                  padding = {
                    left = 1;
                    right = 0;
                  };
                }
                {
                  __unkeyed-1 = "filename";
                  path = 0;
                  symbols = {
                    modified = "";
                    readonly = "󰌾";
                    unnamed = "[No Name]";
                  };
                  separator = {
                    right = "";
                  };
                }
              ];
              lualine_c = [
                {
                  __unkeyed-1 = "branch";
                  icon = "";
                }
                {
                  __unkeyed-1 = "diff";
                  symbols = {
                    added = " ";
                    modified = " ";
                    removed = " ";
                  };
                }
              ];
              lualine_x = [
                {
                  __unkeyed-1 = "diagnostics";
                  sources = [ "nvim_lsp" ];
                  symbols = {
                    error = " ";
                    warn = " ";
                    hint = "󰛩 ";
                    info = " ";
                  };
                }
                {
                  __unkeyed-1.__raw = ''
                    function()
                      local clients = vim.lsp.get_clients({ bufnr = 0 })
                      if #clients == 0 then return "" end
                      local names = {}
                      for _, client in ipairs(clients) do
                        table.insert(names, client.name)
                      end
                      return " " .. table.concat(names, ", ")
                    end
                  '';
                }
              ];
              lualine_y = [
                {
                  __unkeyed-1.__raw = ''
                    function()
                      if vim.o.columns > 85 then
                        return "󰉖 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                      end
                      return ""
                    end
                  '';
                  separator = {
                    left = "";
                  };
                }
              ];
              lualine_z = [
                {
                  __unkeyed-1.__raw = ''
                    function()
                      return "Ln %l, Col %v"
                    end
                  '';
                  separator = {
                    left = "";
                    right = "";
                  };
                }
              ];
            };
          };
        };

        indent-blankline = {
          enable = true;
          settings = {
            indent = {
              char = "│";
              highlight = "IblIndent";
            };
            scope = {
              enabled = true;
              show_start = false;
              show_end = false;
              highlight = "IblScope";
            };
          };
        };

        toggleterm = {
          enable = true;
          settings = {
            size.__raw = ''
              function(term)
                if term.direction == "horizontal" then
                  return 15
                elseif term.direction == "vertical" then
                  return vim.o.columns * 0.4
                end
              end
            '';
            hide_numbers = true;
            shade_terminals = false;
            start_in_insert = true;
            insert_mappings = true;
            terminal_mappings = true;
            persist_size = true;
            direction = "float";
            close_on_exit = true;
            float_opts = {
              border = "curved";
              winblend = 0;
            };
          };
        };

        which-key.enable = true;
        luasnip = {
          enable = true;
          fromVscode = [ { } ];
        };
        friendly-snippets.enable = true;

        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            completion = {
              completeopt = "menu,menuone";
            };
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "buffer"; }
              { name = "nvim_lua"; }
              { name = "path"; }
            ];
            mapping = {
              "<C-p>" = "cmp.mapping.select_prev_item()";
              "<C-n>" = "cmp.mapping.select_next_item()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.close()";
              "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
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

        conform-nvim = {
          enable = true;
          settings = {
            format_on_save = {
              timeout_ms = 500;
              lsp_fallback = true;
            };
          };
        };

        gitsigns = {
          enable = true;
          settings = {
            signs = {
              delete = {
                text = "󰍵";
              };
              changedelete = {
                text = "󱕖";
              };
            };
          };
        };
      };

      extraConfigLua = ''
        local Terminal = require("toggleterm.terminal").Terminal

        local float_term = Terminal:new({ direction = "float", hidden = true })
        local horizontal_term = Terminal:new({ direction = "horizontal", hidden = true })
        local vertical_term = Terminal:new({ direction = "vertical", hidden = true })

        vim.keymap.set({ "n", "t" }, "<A-i>", function()
          float_term:toggle()
        end, { desc = "Toggle floating terminal" })

        vim.keymap.set({ "n", "t" }, "<A-h>", function()
          horizontal_term:toggle()
        end, { desc = "Toggle horizontal terminal" })

        vim.keymap.set({ "n", "t" }, "<A-v>", function()
          vertical_term:toggle()
        end, { desc = "Toggle vertical terminal" })
      '';
    };
  };
}
