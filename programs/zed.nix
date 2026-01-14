{ pkgs, ... }:
{
  programs.zed-editor = {
    # Use FHS wrapper variant so we can compile extensions/grammars/etc properly.
    package = pkgs.zed-editor-fhs;
    enable = true;
    extensions = [
      "ansible"
      "biome"
      "caddyfile"
      "color-highlight"
      "dockerfile"
      "docker-compose"
      "env"
      "fish"
      "git-firefly"
      "github-actions"
      "golangci-lint"
      "gosum"
      "gotmpl"
      "haskell"
      "make"
      "meson"
      "neocmake"
      "nix"
      "postgres-language-server"
      "postgres-context-server"
      "sql"
      "templ"
      "vhs"
      "zig"
    ];

    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      tabs = {
        show_diagnostics = "all";
        git_status = true;
        file_icons = true;
      };

      project_panel = {
        hide_hidden = false;
        hide_root = true;
        auto_reveal_entries = false;
        indent_size = 10.0;
        file_icons = true;
        entry_spacing = "standard";
        hide_gitignore = false;
      };
      window_decorations = "server";
      use_system_window_tabs = false;
      bottom_dock_layout = "full";

      collaboration_panel = {
        button = false;
      };
      close_on_file_delete = true;
      use_smartcase_search = true;
      when_closing_with_no_tabs = "keep_window_open";
      git = {
        branch_picker = {
          show_author_name = false;
        };
        blame = {
          show_avatar = false;
        };
        inline_blame = {
          enabled = false;
        };
      };
      title_bar = {
        show_sign_in = false;
        show_user_picture = false;
        show_menus = false;
        show_branch_icon = true;
      };
      search = {
        button = true;
      };
      status_bar = {
        cursor_position_button = true;
      };
      inlay_hints = {
        edit_debounce_ms = 695;
      };
      indent_guides = {
        enabled = false;
        background_coloring = "indent_aware";
        coloring = "indent_aware";
      };
      soft_wrap = "prefer_line";
      preferred_line_length = 121;
      minimap = {
        show = "never";
      };
      scrollbar = {
        show = "always";
      };
      relative_line_numbers = "disabled";
      hover_popover_delay = 200;
      show_signature_help_after_edits = true;
      auto_signature_help = true;
      #icon_theme = "";
      unstable.ui_density = "compact";
      base_keymap = "JetBrains";
      lsp = {
        hls = {
          initialization_options = {
            haskell = {
              formattingProvider = "fourmolu";
            };
          };
        };
      };
      context_servers = {
        postgres-context-server = {
          source = "extension";
          enabled = true;
          settings = {
            database_url = "postgresql://gbans:gbans@localhost:5432/gbans";
          };
        };
      };
      languages = {
        SQL = {
          formatter = {
            external = {
              command = "sql-formatter";
              arguments = [
                "--language"
                "postgresql"
              ];
            };
          };
        };
      };
    };
  };
}
