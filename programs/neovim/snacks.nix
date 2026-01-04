{ pkgs, ... }:

{
  programs.nvf.settings.vim = {

    extraPlugins = with pkgs.vimPlugins; {
      snacks-nvim = {
        package = snacks-nvim;
      };
    };
    maps.normal = {
      #-- Top Pickers & Explorer
      "<leader><space>" = {
        action = "function() Snacks.picker.smart() end";
        desc = "Smart Find Files";
      };
      "<leader>," = {
        action = "function() Snacks.picker.buffers() end";
        desc = "Buffers";
      };
      "<leader>/" = {
        action = "function() Snacks.picker.grep() end";
        desc = "Grep";
      };
      "<leader>:" = {
        action = "function() Snacks.picker.command_history() end";
        desc = "Command History";
      };
      "<leader>n" = {
        action = "function() Snacks.picker.notifications() end";
        desc = "Notification History";
      };
      "<leader>e" = {
        action = "function() Snacks.explorer() end";
        desc = "File Explorer";
      };
      #-- find
      "<leader>fb" = {
        action = "function() Snacks.picker.buffers() end";
        desc = "Buffers";
      };
      "<leader>fc" = {
        action = ''function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end'';
        desc = "Find Config File";
      };
      "<leader>ff" = {
        action = "function() Snacks.picker.files() end";
        desc = "Find Files";
      };
      "<leader>fg" = {
        action = "function() Snacks.picker.git_files() end";
        desc = "Find Git Files";
      };
      "<leader>fp" = {
        action = "function() Snacks.picker.projects() end";
        desc = "Projects";
      };
      "<leader>fr" = {
        action = "function() Snacks.picker.recent() end";
        desc = "Recent";
      };
      #-- git
      "<leader>gb" = {
        action = "function() Snacks.picker.git_branches() end";
        desc = "Git Branches";
      };
      "<leader>gl" = {
        action = "function() Snacks.picker.git_log() end";
        desc = "Git Log";
      };
      "<leader>gL" = {
        action = "function() Snacks.picker.git_log_line() end";
        desc = "Git Log Line";
      };
      "<leader>gs" = {
        action = "function() Snacks.picker.git_status() end";
        desc = "Git Status";
      };
      "<leader>gS" = {
        action = "function() Snacks.picker.git_stash() end";
        desc = "Git Stash";
      };
      "<leader>gd" = {
        action = "function() Snacks.picker.git_diff() end";
        desc = "Git Diff (Hunks)";
      };
      "<leader>gf" = {
        action = "function() Snacks.picker.git_log_file() end";
        desc = "Git Log File";
      };
      #-- gh
      "<leader>gi" = {
        action = "function() Snacks.picker.gh_issue() end";
        desc = "GitHub Issues (open)";
      };
      "<leader>gI" = {
        action = ''function() Snacks.picker.gh_issue({ state = "all" }) end'';
        desc = "GitHub Issues (all)";
      };
      "<leader>gp" = {
        action = "function() Snacks.picker.gh_pr() end";
        desc = "GitHub Pull Requests (open)";
      };
      "<leader>gP" = {
        action = ''function() Snacks.picker.gh_pr({ state = "all" }) end'';
        desc = "GitHub Pull Requests (all)";
      };
      #-- Grep
      "<leader>sB" = {
        action = "function() Snacks.picker.grep_buffers() end";
        desc = "Grep Open Buffers";
      };
      "<leader>sg" = {
        action = "function() Snacks.picker.grep() end";
        desc = "Grep";
      };
      # {
      #   key = "<leader>sw";
      #   action = "function() Snacks.picker.grep_word() end";
      #   desc = "Visual selection or word";
      #   mode = [
      #     "n"
      #     "x"
      #   ];
      # }
      #-- search
      "<leader>s\"" = {
        action = "function() Snacks.picker.registers() end";
        desc = "Registers";
      };
      "<leader>s/'" = {
        action = "function() Snacks.picker.search_history() end";
        desc = "Search History";
      };
      "<leader>sa" = {
        action = "function() Snacks.picker.autocmds() end";
        desc = "Autocmds";
      };
      "<leader>sb" = {
        action = "function() Snacks.picker.lines() end";
        desc = "Buffer Lines";
      };
      "<leader>sc" = {
        action = "function() Snacks.picker.command_history() end";
        desc = "Command History";
      };
      "<leader>sC" = {
        action = "function() Snacks.picker.commands() end";
        desc = "Commands";
      };
      "<leader>sd" = {
        action = "function() Snacks.picker.diagnostics() end";
        desc = "Diagnostics";
      };
      "<leader>sD" = {
        action = "function() Snacks.picker.diagnostics_buffer() end";
        desc = "Buffer Diagnostics";
      };
      "<leader>sh" = {
        action = "function() Snacks.picker.help() end";
        desc = "Help Pages";
      };
      "<leader>sH" = {
        action = "function() Snacks.picker.highlights() end";
        desc = "Highlights";
      };
      "<leader>si" = {
        action = "function() Snacks.picker.icons() end";
        desc = "Icons";
      };
      "<leader>sj" = {
        action = "function() Snacks.picker.jumps() end";
        desc = "Jumps";
      };
      "<leader>sk" = {
        action = "function() Snacks.picker.keymaps() end";
        desc = "Keymaps";
      };
      "<leader>sl" = {
        action = "function() Snacks.picker.loclist() end";
        desc = "Location List";
      };
      "<leader>sm" = {
        action = "function() Snacks.picker.marks() end";
        desc = "Marks";
      };
      "<leader>sM" = {
        action = "function() Snacks.picker.man() end";
        desc = "Man Pages";
      };
      "<leader>sp" = {
        action = "function() Snacks.picker.lazy() end";
        desc = "Search for Plugin Spec";
      };
      "<leader>sq" = {
        action = "function() Snacks.picker.qflist() end";
        desc = "Quickfix List";
      };
      "<leader>sR" = {
        action = "function() Snacks.picker.resume() end";
        desc = "Resume";
      };
      "<leader>su" = {
        action = "function() Snacks.picker.undo() end";
        desc = "Undo History";
      };
      "<leader>uC" = {
        action = "function() Snacks.picker.colorschemes() end";
        desc = "Colorschemes";
      };
      #-- LSP
      "gd" = {
        action = "function() Snacks.picker.lsp_definitions() end";
        desc = "Goto Definition";
      };
      "gD" = {
        action = "function() Snacks.picker.lsp_declarations() end";
        desc = "Goto Declaration";
      };
      "gr" = {
        action = "function() Snacks.picker.lsp_references() end";
        nowait = true;
        desc = "References";
      };
      "gI" = {
        action = "function() Snacks.picker.lsp_implementations() end";
        desc = "Goto Implementation";
      };
      "gy" = {
        action = "function() Snacks.picker.lsp_type_definitions() end";
        desc = "Goto T[y]pe Definition";
      };
      "gai" = {
        action = "function() Snacks.picker.lsp_incoming_calls() end";
        desc = "C[a]lls Incoming";
      };
      "gao" = {
        action = "function() Snacks.picker.lsp_outgoing_calls() end";
        desc = "C[a]lls Outgoing";
      };
      "<leader>ss" = {
        action = "function() Snacks.picker.lsp_symbols() end";
        desc = "LSP Symbols";
      };
      "<leader>sS" = {
        action = "function() Snacks.picker.lsp_workspace_symbols() end";
        desc = "LSP Workspace Symbols";
      };
      #-- Othe
      "<leader>z" = {
        action = "function() Snacks.zen() end";
        desc = "Toggle Zen Mode";
      };
      "<leader>Z" = {
        action = "function() Snacks.zen.zoom() end";
        desc = "Toggle Zoom";
      };
      "<leader>." = {
        action = "function() Snacks.scratch() end";
        desc = "Toggle Scratch Buffer";
      };
      "<leader>S" = {
        action = "function() Snacks.scratch.select() end";
        desc = "Select Scratch Buffer";
      };
      # "<leader>n" = {
      #   action = "function() Snacks.notifier.show_history() end";
      #   desc = "Notification History";
      # };
      "<leader>bd" = {
        action = "function() Snacks.bufdelete() end";
        desc = "Delete Buffer";
      };
      "<leader>cR" = {
        action = "function() Snacks.rename.rename_file() end";
        desc = "Rename File";
      };
      # {
      #   key = "<leader>gB";
      #   action = "function() Snacks.gitbrowse() end";
      #   desc = "Git Browse";
      #   mode = [
      #     "n"
      #     "v"
      #   ];
      # }
      "<leader>gg" = {
        action = "function() Snacks.lazygit() end";
        desc = "Lazygit";
      };
      "<leader>un" = {
        action = "function() Snacks.notifier.hide() end";
        desc = "Dismiss All Notifications";
      };
      "<c-/>" = {
        action = "function() Snacks.terminal() end";
        desc = "Toggle Terminal";
      };
      "<c-_>" = {
        action = "function() Snacks.terminal() end";
        desc = "which_key_ignore";
      };
      # {
      #   key = "]]";
      #   action = "function() Snacks.words.jump(vim.v.count1) end";
      #   desc = "Next Reference";
      #   mode = [
      #     "n"
      #     "t"
      #   ];
      # }
      #   {
      #     key = "[[";
      #     action = "function() Snacks.words.jump(-vim.v.count1) end";
      #     desc = "Prev Reference";
      #     mode = [
      #       "n"
      #       "t"
      #     ];
      #   }
      # ];
    };
    utility.snacks-nvim = {
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
  };
}
