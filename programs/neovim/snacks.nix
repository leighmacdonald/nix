{pkgs, ...}: {
  programs.nvf.settings.vim = {
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        bigfile = {
          enabled = true;
        };
        dashboard = {
          enabled = false;
        };
        explorer = {
          enabled = true;
        };
        gh = {enabled = true;};
        image = {
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
          # win = {
          #      input = {
          #        keys = {
          #          "<a-a>" = { "opencode_send", mode = { "n", "i" } },
          #        },
          #      },
          #    },
          #    actions = {
          #      opencode_send = function(picker) ---@param picker snacks.Picker
          #        local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
          #          return item.file
          #            and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
          #            or item.text
          #        end, picker:selected({ fallback = true }))

          #        require("opencode").prompt(table.concat(items, ", ") .. " ")
          #      end,
          #    };
        };
        quickfile = {
          enabled = true;
        };
        scope = {
          enabled = true;
        };
        scratch = {
          enabled = true;
        };
        scroll = {
          enabled = false;
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
    extraPlugins = with pkgs.vimPlugins; {
      snacks-nvim = {
        package = snacks-nvim;
      };
    };
    keymaps = [
      #-- Top Pickers & Explorer
      {
        mode = "n";
        key = "<leader><space>";
        action = "<cmd>lua Snacks.picker.smart()<CR>";
        desc = "Smart Find Files";
      }
      {
        mode = "n";
        key = "<leader>,";
        action = "<cmd>lua Snacks.picker.buffers()<CR>";
        desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>lua Snacks.picker.grep()<CR>";
        desc = "Grep";
      }
      {
        mode = "n";
        key = "<leader>:";
        action = "<cmd>lua Snacks.picker.command_history()<CR>";
        desc = "Command History";
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>lua Snacks.picker.notifications() <CR>";
        desc = "Notification History";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua Snacks.explorer() <CR>";
        desc = "File Explorer";
      }
      #-- find
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>lua Snacks.picker.buffers() <CR>";
        desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = ''<cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) <CR>'';
        desc = "Find Config File";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua Snacks.picker.files() <CR>";
        desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>lua Snacks.picker.git_files() <CR>";
        desc = "Find Git Files";
      }
      {
        mode = "n";
        key = "<leader>fp";
        action = "<cmd>lua Snacks.picker.projects() <CR>";
        desc = "Projects";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>lua Snacks.picker.recent() <CR>";
        desc = "Recent";
      }
      #-- git
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>lua Snacks.picker.git_branches() <CR>";
        desc = "Git Branches";
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>lua Snacks.picker.git_log() <CR>";
        desc = "Git Log";
      }
      {
        mode = "n";
        key = "<leader>gL";
        action = "<cmd>lua Snacks.picker.git_log_line() <CR>";
        desc = "Git Log Line";
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>lua Snacks.picker.git_status() <CR>";
        desc = "Git Status";
      }
      {
        mode = "n";
        key = "<leader>gS";
        action = "<cmd>lua Snacks.picker.git_stash() <CR>";
        desc = "Git Stash";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>lua Snacks.picker.git_diff() <CR>";
        desc = "Git Diff (Hunks)";
      }
      {
        mode = "n";
        key = "<leader>gf";
        action = "<cmd>lua Snacks.picker.git_log_file() <CR>";
        desc = "Git Log File";
      }
      #-- gh
      {
        mode = "n";
        key = "<leader>gi";
        action = "<cmd>lua Snacks.picker.gh_issue() <CR>";
        desc = "GitHub Issues (open)";
      }
      {
        mode = "n";
        key = "<leader>gI";
        action = ''<cmd>lua Snacks.picker.gh_issue({ state = "all" }) <CR>'';
        desc = "GitHub Issues (all)";
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>lua Snacks.picker.gh_pr() <CR>";
        desc = "GitHub Pull Requests (open)";
      }
      {
        mode = "n";
        key = "<leader>gP";
        action = ''<cmd>lua Snacks.picker.gh_pr({ state = "all" }) <CR>'';
        desc = "GitHub Pull Requests (all)";
      }
      #-- Grep
      {
        mode = "n";
        key = "<leader>sB";
        action = "<cmd>lua Snacks.picker.grep_buffers() <CR>";
        desc = "Grep Open Buffers";
      }
      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>lua Snacks.picker.grep() <CR>";
        desc = "Grep";
      }
      #-- search
      {
        mode = "n";
        key = "<leader>s\"";
        action = "<cmd>lua Snacks.picker.registers() <CR>";
        desc = "Registers";
      }
      {
        mode = "n";
        key = "<leader>s/'";
        action = "<cmd>lua Snacks.picker.search_history() <CR>";
        desc = "Search History";
      }
      {
        mode = "n";
        key = "<leader>sa";
        action = "<cmd>lua Snacks.picker.autocmds() <CR>";
        desc = "Autocmds";
      }
      {
        mode = "n";
        key = "<leader>sb";
        action = "<cmd>lua Snacks.picker.lines() <CR>";
        desc = "Buffer Lines";
      }
      {
        mode = "n";
        key = "<leader>sc";
        action = "<cmd>lua Snacks.picker.command_history() <CR>";
        desc = "Command History";
      }
      {
        mode = "n";
        key = "<leader>sC";
        action = "<cmd>lua Snacks.picker.commands() <CR>";
        desc = "Commands";
      }
      {
        mode = "n";
        key = "<leader>sd";
        action = "<cmd>lua Snacks.picker.diagnostics() <CR>";
        desc = "Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>sD";
        action = "<cmd>lua Snacks.picker.diagnostics_buffer() <CR>";
        desc = "Buffer Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>lua Snacks.picker.help() <CR>";
        desc = "Help Pages";
      }
      {
        mode = "n";
        key = "<leader>sH";
        action = "<cmd>lua Snacks.picker.highlights() <CR>";
        desc = "Highlights";
      }
      {
        mode = "n";
        key = "<leader>si";
        action = "<cmd>lua Snacks.picker.icons() <CR>";
        desc = "Icons";
      }
      {
        mode = "n";
        key = "<leader>sj";
        action = "<cmd>lua Snacks.picker.jumps() <CR>";
        desc = "Jumps";
      }
      {
        mode = "n";
        key = "<leader>sk";
        action = "<cmd>lua Snacks.picker.keymaps() <CR>";
        desc = "Keymaps";
      }
      {
        mode = "n";
        key = "<leader>sl";
        action = "<cmd>lua Snacks.picker.loclist() <CR>";
        desc = "Location List";
      }
      {
        mode = "n";
        key = "<leader>sm";
        action = "<cmd>lua Snacks.picker.marks() <CR>";
        desc = "Marks";
      }
      {
        mode = "n";
        key = "<leader>sM";
        action = "<cmd>lua Snacks.picker.man() <CR>";
        desc = "Man Pages";
      }
      {
        mode = "n";
        key = "<leader>sp";
        action = "<cmd>lua Snacks.picker.lazy() <CR>";
        desc = "Search for Plugin Spec";
      }
      {
        mode = "n";
        key = "<leader>sq";
        action = "<cmd>lua  Snacks.picker.qflist() <CR>";
        desc = "Quickfix List";
      }
      {
        mode = "n";
        key = "<leader>sR";
        action = "<cmd>lua  Snacks.picker.resume() <CR>";
        desc = "Resume";
      }
      {
        mode = "n";
        key = "<leader>su";
        action = "<cmd>lua  Snacks.picker.undo() <CR>";
        desc = "Undo History";
      }
      {
        mode = "n";
        key = "<leader>uC";
        action = "<cmd>lua Snacks.picker.colorschemes() <CR>";
        desc = "Colorschemes";
      }
      #-- LSP
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua Snacks.picker.lsp_definitions() <CR>";
        desc = "Goto Definition";
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>lua Snacks.picker.lsp_declarations() <CR>";
        desc = "Goto Declaration";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua Snacks.picker.lsp_references() <CR>";
        nowait = true;
        desc = "References";
      }
      {
        mode = "n";
        key = "gI";
        action = "<cmd>lua Snacks.picker.lsp_implementations() <CR>";
        desc = "Goto Implementation";
      }
      {
        mode = "n";
        key = "gy";
        action = "<cmd>lua  Snacks.picker.lsp_type_definitions() <CR>";
        desc = "Goto T[y]pe Definition";
      }
      {
        mode = "n";
        key = "gai";
        action = "<cmd>lua  Snacks.picker.lsp_incoming_calls() <CR>";
        desc = "C[a]lls Incoming";
      }
      {
        mode = "n";
        key = "gao";
        action = "<cmd>lua Snacks.picker.lsp_outgoing_calls() <CR>";
        desc = "C[a]lls Outgoing";
      }
      {
        mode = "n";
        key = "<leader>ss";
        action = "<cmd>lua Snacks.picker.lsp_symbols() <CR>";
        desc = "LSP Symbols";
      }
      {
        mode = "n";
        key = "<leader>sS";
        action = "<cmd>lua Snacks.picker.lsp_workspace_symbols() <CR>";
        desc = "LSP Workspace Symbols";
      }
      #-- Other
      {
        mode = "n";
        key = "<leader>z";
        action = "<cmd>lua Snacks.zen() <CR>";
        desc = "Toggle Zen Mode";
      }
      {
        mode = "n";
        key = "<leader>Z";
        action = "<cmd>lua Snacks.zen.zoom() <CR>";
        desc = "Toggle Zoom";
      }
      {
        mode = "n";
        key = "<leader>.";
        action = "<cmd>lua Snacks.scratch() <CR>";
        desc = "Toggle Scratch Buffer";
      }
      {
        mode = "n";
        key = "<leader>S";
        action = "<cmd>lua Snacks.scratch.select() <CR>";
        desc = "Select Scratch Buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>lua Snacks.bufdelete() <CR>";
        desc = "Delete Buffer";
      }
      {
        mode = "n";
        key = "<leader>cR";
        action = "<cmd>lua Snacks.rename.rename_file() <CR>";
        desc = "Rename File";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>lua Snacks.lazygit() <CR>";
        desc = "Lazygit";
      }
      {
        mode = "n";
        key = "<leader>un";
        action = "<cmd>lua Snacks.notifier.hide() <CR>";
        desc = "Dismiss All Notifications";
      }
      {
        mode = "n";
        key = "<c-/>";
        action = "<cmd>lua Snacks.terminal() <CR>";
        desc = "Toggle Terminal";
      }
      {
        mode = "n";
        key = "<c-_>";
        action = "<cmd>lua Snacks.terminal()<CR>";
        desc = "which_key_ignore";
      }
    ];
  };
}
