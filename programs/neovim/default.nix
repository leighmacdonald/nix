{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default

    ./keys.nix
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        syntaxHighlighting = true;
        lsp = {
          enable = true;
          lspkind.enable = true;
          trouble.enable = true;
          null-ls = {
            enable = true;
          };
          nvim-docs-view = {
            enable = true;
          };
          otter-nvim = {
            enable = true;
            setupOpts.handle_leading_whitespace = true;
          };

        };
        options = {
          tabstop = 4;
          shiftwidth = 4;
          splitright = true;
        };
        binds = {
          whichKey.enable = true;
        };
        spellcheck = {
          enable = true;
          programmingWordlist.enable = true;
          vim-dirtytalk.enable = true;
        };
        mini.icons.enable = true;
        dashboard.dashboard-nvim.enable = true;
        undoFile.enable = true;
        # projects = {
        #   projects-nvim = {
        #     enable = true;
        #   };
        # };
        languages = {
          json = {
            enable = true;
            format.enable = true;
          };
          html = {
            enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
          };
          enableTreesitter = true;
          nix = {
            enable = true;
            extraDiagnostics = {
              enable = true;
            };
            format = {
              enable = true;
            };
            treesitter.enable = true;
          };
          markdown = {
            enable = true;
          };
          sql = {
            enable = true;
            lsp = {
              enable = true;
            };
          };
          go = {
            enable = true;
            dap.enable = true;
            format.enable = true;
            lsp = {
              enable = true;
            };
            treesitter.enable = true;
          };
          yaml = {
            enable = true;
            lsp.enable = true;
          };
          ts = {
            enable = true;
            format = {
              enable = true;
            };
            lsp = {
              enable = true;
            };
            treesitter.enable = true;
          };
        };
        tabline = {
          nvimBufferline.enable = true;
        };

        visuals = {
          nvim-cursorline.enable = true;
          nvim-web-devicons.enable = true;
        };
        utility = {
          direnv.enable = true;
          icon-picker.enable = true;
          surround.enable = true;
          snacks-nvim = {
            enable = true;
            setupOpts = {
              bigfile = {
                enabled = true;
              };
              dashboard = {
                enabled = true;
              };
              explorer = {
                enabled = true;
              };
              indent = {
                enabled = true;
              };
              input = {
                enabled = true;
              };
              notifier = {
                enabled = true;
                timeout = 3000;
              };
              picker = {
                enabled = true;
              };
              quickfile = {
                enabled = true;
              };
              scope = {
                enabled = true;
              };
              scroll = {
                enabled = true;
              };
              statuscolumn = {
                enabled = true;
              };
              words = {
                enabled = true;
              };
              styles = {
                notification = {
                  #-- wo = { wrap = true } -- Wrap notifications
                };
              };
            };

          };
          images.image-nvim = {
            enable = true;
            setupOpts = {
              backend = "kitty";
              integrations.markdown = {
                enable = true;
                clearInInsertMode = true;
              };
            };
          };
        };
        treesitter = {
          highlight = {
            additionalVimRegexHighlighting = true;
            # disable = ```lua
            # -- Disable slow treesitter highlight for large files
            # function(lang, buf)
            #   local max_filesize = 1000 * 1024 -- 1MB
            #   local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            #   if ok and stats and stats.size > max_filesize then
            #       return true
            #   end
            # end
            # ```;
          };
          textobjects.enable = true;
          context = {
            enable = true;
          };
        };
        extraPackages = [
          pkgs.fzf
          pkgs.ripgrep
        ];
        fzf-lua = {
          enable = true;
        };
        formatter = {
          conform-nvim = {
            enable = true;
          };
        };
        debugger = {
          nvim-dap = {
            enable = true;
            ui = {
              enable = true;
            };
          };
        };
        telescope.enable = true;
        enableLuaLoader = true;
        # extraPlugins = with pkgs.vimPlugins; [
        #   snacks-nvim
        # ];
        viAlias = true;
        vimAlias = true;

        autocomplete = {
          enableSharedCmpSources = true;
          blink-cmp.enable = true;
          blink-cmp.friendly-snippets.enable = true;
        };
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
        };
        diagnostics = {
          enable = true;
          nvim-lint = {
            enable = true;
          };
        };
        statusline = {
          lualine.enable = true;
        };
      };
    };
  };
}
