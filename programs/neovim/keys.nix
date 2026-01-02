{
  programs.nvf = {
    settings = {
      vim = {
        keymaps = [
          #-- Top Pickers & Explorer
          {
            key = "<leader><space>";
            action = "function() Snacks.picker.smart() end";
            desc = "Smart Find Files";
            mode = "n";
          }
          {
            key = "<leader>,";
            action = "function() Snacks.picker.buffers() end";
            desc = "Buffers";
            mode = "n";
          }
          {
            key = "<leader>/";
            action = "function() Snacks.picker.grep() end";
            desc = "Grep";
            mode = "n";
          }
          {
            key = "<leader>:";
            action = "function() Snacks.picker.command_history() end";
            desc = "Command History";
            mode = "n";
          }
          {
            key = "<leader>n";
            action = "function() Snacks.picker.notifications() end";
            desc = "Notification History";
            mode = "n";
          }
          {
            key = "<leader>e";
            action = "function() Snacks.explorer() end";
            desc = "File Explorer";
            mode = "n";
          }
          #-- find
          {
            key = "<leader>fb";
            action = "function() Snacks.picker.buffers() end";
            desc = "Buffers";
            mode = "n";
          }
          {
            key = "<leader>fc";
            action = ''function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end'';
            desc = "Find Config File";
            mode = "n";
          }
          {
            key = "<leader>ff";
            action = "function() Snacks.picker.files() end";
            desc = "Find Files";
            mode = "n";
          }
          {
            key = "<leader>fg";
            action = "function() Snacks.picker.git_files() end";
            desc = "Find Git Files";
            mode = "n";
          }
          {
            key = "<leader>fp";
            action = "function() Snacks.picker.projects() end";
            desc = "Projects";
            mode = "n";
          }
          {
            key = "<leader>fr";
            action = "function() Snacks.picker.recent() end";
            desc = "Recent";
            mode = "n";
          }
          #-- git
          {
            key = "<leader>gb";
            action = "function() Snacks.picker.git_branches() end";
            desc = "Git Branches";
            mode = "n";
          }
          {
            key = "<leader>gl";
            action = "function() Snacks.picker.git_log() end";
            desc = "Git Log";
            mode = "n";
          }
          {
            key = "<leader>gL";
            action = "function() Snacks.picker.git_log_line() end";
            desc = "Git Log Line";
            mode = "n";
          }
          {
            key = "<leader>gs";
            action = "function() Snacks.picker.git_status() end";
            desc = "Git Status";
            mode = "n";
          }
          {
            key = "<leader>gS";
            action = "function() Snacks.picker.git_stash() end";
            desc = "Git Stash";
            mode = "n";
          }
          {
            key = "<leader>gd";
            action = "function() Snacks.picker.git_diff() end";
            desc = "Git Diff (Hunks)";
            mode = "n";
          }
          {
            key = "<leader>gf";
            action = "function() Snacks.picker.git_log_file() end";
            desc = "Git Log File";
            mode = "n";
          }
          #-- gh
          {
            key = "<leader>gi";
            action = "function() Snacks.picker.gh_issue() end";
            desc = "GitHub Issues (open)";
            mode = "n";
          }
          {
            key = "<leader>gI";
            action = ''function() Snacks.picker.gh_issue({ state = "all" }) end'';
            desc = "GitHub Issues (all)";
            mode = "n";
          }
          {
            key = "<leader>gp";
            action = "function() Snacks.picker.gh_pr() end";
            desc = "GitHub Pull Requests (open)";
            mode = "n";
          }
          {
            key = "<leader>gP";
            action = ''function() Snacks.picker.gh_pr({ state = "all" }) end'';
            desc = "GitHub Pull Requests (all)";
            mode = "n";
          }
          #-- Grep
          {
            key = "<leader>sb";
            action = "function() Snacks.picker.lines() end";
            desc = "Buffer Lines";
            mode = "n";
          }
          {
            key = "<leader>sB";
            action = "function() Snacks.picker.grep_buffers() end";
            desc = "Grep Open Buffers";
            mode = "n";
          }
          {
            key = "<leader>sg";
            action = "function() Snacks.picker.grep() end";
            desc = "Grep";
            mode = "n";
          }
          {
            key = "<leader>sw";
            action = "function() Snacks.picker.grep_word() end";
            desc = "Visual selection or word";
            mode = [
              "n"
              "x"
            ];
          }
          #-- search
          {
            key = ''<leader>s"'';
            action = "function() Snacks.picker.registers() end";
            desc = "Registers";
            mode = "n";
          }
          {
            key = "<leader>s/'";
            action = "function() Snacks.picker.search_history() end";
            desc = "Search History";
            mode = "n";
          }
          {
            key = "<leader>sa";
            action = "function() Snacks.picker.autocmds() end";
            desc = "Autocmds";
            mode = "n";
          }
          {
            key = "<leader>sb";
            action = "function() Snacks.picker.lines() end";
            desc = "Buffer Lines";
            mode = "n";
          }
          {
            key = "<leader>sc";
            action = "function() Snacks.picker.command_history() end";
            desc = "Command History";
            mode = "n";
          }
          {
            key = "<leader>sC";
            action = "function() Snacks.picker.commands() end";
            desc = "Commands";
            mode = "n";
          }
          {
            key = "<leader>sd";
            action = "function() Snacks.picker.diagnostics() end";
            desc = "Diagnostics";
            mode = "n";
          }
          {
            key = "<leader>sD";
            action = "function() Snacks.picker.diagnostics_buffer() end";
            desc = "Buffer Diagnostics";
            mode = "n";
          }
          {
            key = "<leader>sh";
            action = "function() Snacks.picker.help() end";
            desc = "Help Pages";
            mode = "n";
          }
          {
            key = "<leader>sH";
            action = "function() Snacks.picker.highlights() end";
            desc = "Highlights";
            mode = "n";
          }
          {
            key = "<leader>si";
            action = "function() Snacks.picker.icons() end";
            desc = "Icons";
            mode = "n";
          }
          {
            key = "<leader>sj";
            action = "function() Snacks.picker.jumps() end";
            desc = "Jumps";
            mode = "n";
          }
          {
            key = "<leader>sk";
            action = "function() Snacks.picker.keymaps() end";
            desc = "Keymaps";
            mode = "n";
          }
          {
            key = "<leader>sl";
            action = "function() Snacks.picker.loclist() end";
            desc = "Location List";
            mode = "n";
          }
          {
            key = "<leader>sm";
            action = "function() Snacks.picker.marks() end";
            desc = "Marks";
            mode = "n";
          }
          {
            key = "<leader>sM";
            action = "function() Snacks.picker.man() end";
            desc = "Man Pages";
            mode = "n";
          }
          {
            key = "<leader>sp";
            action = "function() Snacks.picker.lazy() end";
            desc = "Search for Plugin Spec";
            mode = "n";
          }
          {
            key = "<leader>sq";
            action = "function() Snacks.picker.qflist() end";
            desc = "Quickfix List";
            mode = "n";
          }
          {
            key = "<leader>sR";
            action = "function() Snacks.picker.resume() end";
            desc = "Resume";
            mode = "n";
          }
          {
            key = "<leader>su";
            action = "function() Snacks.picker.undo() end";
            desc = "Undo History";
            mode = "n";
          }
          {
            key = "<leader>uC";
            action = "function() Snacks.picker.colorschemes() end";
            desc = "Colorschemes";
            mode = "n";
          }
          #-- LSP
          {
            key = "gd";
            action = "function() Snacks.picker.lsp_definitions() end";
            desc = "Goto Definition";
            mode = "n";
          }
          {
            key = "gD";
            action = "function() Snacks.picker.lsp_declarations() end";
            desc = "Goto Declaration";
            mode = "n";
          }
          {
            key = "gr";
            action = "function() Snacks.picker.lsp_references() end";
            nowait = true;
            desc = "References";
            mode = "n";
          }
          {
            key = "gI";
            action = "function() Snacks.picker.lsp_implementations() end";
            desc = "Goto Implementation";
            mode = "n";
          }
          {
            key = "gy";
            action = "function() Snacks.picker.lsp_type_definitions() end";
            desc = "Goto T[y]pe Definition";
            mode = "n";
          }
          {
            key = "gai";
            action = "function() Snacks.picker.lsp_incoming_calls() end";
            desc = "C[a]lls Incoming";
            mode = "n";
          }
          {
            key = "gao";
            action = "function() Snacks.picker.lsp_outgoing_calls() end";
            desc = "C[a]lls Outgoing";
            mode = "n";
          }
          {
            key = "<leader>ss";
            action = "function() Snacks.picker.lsp_symbols() end";
            desc = "LSP Symbols";
            mode = "n";
          }
          {
            key = "<leader>sS";
            action = "function() Snacks.picker.lsp_workspace_symbols() end";
            desc = "LSP Workspace Symbols";
            mode = "n";
          }
          #-- Othe
          {
            key = "<leader>z";
            action = "function() Snacks.zen() end";
            desc = "Toggle Zen Mode";
            mode = "n";
          }
          {
            key = "<leader>Z";
            action = "function() Snacks.zen.zoom() end";
            desc = "Toggle Zoom";
            mode = "n";
          }
          {
            key = "<leader>.";
            action = "function() Snacks.scratch() end";
            desc = "Toggle Scratch Buffer";
            mode = "n";
          }
          {
            key = "<leader>S";
            action = "function() Snacks.scratch.select() end";
            desc = "Select Scratch Buffer";
            mode = "n";
          }
          {
            key = "<leader>n";
            action = "function() Snacks.notifier.show_history() end";
            desc = "Notification History";
            mode = "n";
          }
          {
            key = "<leader>bd";
            action = "function() Snacks.bufdelete() end";
            desc = "Delete Buffer";
            mode = "n";
          }
          {
            key = "<leader>cR";
            action = "function() Snacks.rename.rename_file() end";
            desc = "Rename File";
            mode = "n";
          }
          {
            key = "<leader>gB";
            action = "function() Snacks.gitbrowse() end";
            desc = "Git Browse";
            mode = [
              "n"
              "v"
            ];
          }
          {
            key = "<leader>gg";
            action = "function() Snacks.lazygit() end";
            desc = "Lazygit";
            mode = "n";
          }
          {
            key = "<leader>un";
            action = "function() Snacks.notifier.hide() end";
            desc = "Dismiss All Notifications";
            mode = "n";
          }
          {
            key = "<c-/>";
            action = "function() Snacks.terminal() end";
            desc = "Toggle Terminal";
            mode = "n";
          }
          {
            key = "<c-_>";
            action = "function() Snacks.terminal() end";
            desc = "which_key_ignore";
            mode = "n";
          }
          {
            key = "]]";
            action = "function() Snacks.words.jump(vim.v.count1) end";
            desc = "Next Reference";
            mode = [
              "n"
              "t"
            ];
          }
          {
            key = "[[";
            action = "function() Snacks.words.jump(-vim.v.count1) end";
            desc = "Prev Reference";
            mode = [
              "n"
              "t"
            ];
          }
        ];
      };
    };
  };
}
