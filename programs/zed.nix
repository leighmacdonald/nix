{ pkgsUnstable, ... }:
{
  stylix.targets.zed = {
    colors.enable = false;
  };
  programs.zed-editor = {
    # Use FHS wrapper variant so we can compile extensions/grammars/etc properly.
    package = pkgsUnstable.zed-editor-fhs;
    enable = true;
    extensions = [
      "ansible"
      "askama"
      "biome"
      "caddyfile"
      "cargotom"
      "color-highlight"
      "csharp"
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
      "jinja2"
      "justfile"
      "make"
      "meson"
      "neocmake"
      "nix"
      "postgres-language-server"
      "postgres-context-server"
      "proto"
      "sql"
      "templ"
      "toml"
      "vhs"
      "zig"
    ];

    userSettings = {
      language_models = {
        openai_compatible = {
          # Using Together AI as an example
          local-supergemma4 = {
            api_url = "http://localhost:8080/v1";
            available_models = [
              {
                name = "qwen3-coder";
                max_tokens = 256000;
                max_output_tokens = 64000;
                max_completion_tokens = 64000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "qwen3-coder-1M";
                max_tokens = 1000000;
                max_output_tokens = 64000;
                max_completion_tokens = 64000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "supergemma4-26b";
                max_tokens = 200000;
                max_output_tokens = 64000;
                max_completion_tokens = 200000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "qwen36-35B-claude-4.6";
                max_tokens = 200000;
                max_output_tokens = 64000;
                max_completion_tokens = 200000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "qwen36-27B-Q5_k_XL";
                max_tokens = 200000;
                max_output_tokens = 64000;
                max_completion_tokens = 32768;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "qwen36-27B-Q5_k_XL-thinking";
                max_tokens = 200000;
                max_output_tokens = 64000;
                max_completion_tokens = 200000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "deepseek-r1-distoll-quen-14b";
                max_tokens = 200000;
                max_output_tokens = 64000;
                max_completion_tokens = 200000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }

              {
                name = "gemma-4-it-obliterated";
                max_tokens = 200000;
                max_output_tokens = 64000;
                max_completion_tokens = 200000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
            ];
          };
        };
      };
      theme = "Ayu Dark";
      icon_theme = "Catppuccin Mocha";
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
      file_types = {
        "Askama" = [ "jinja2" ];
      };
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
      show_signature_help_after_edits = false;
      auto_signature_help = true;
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
          enabled = true;
          settings = {
            database_url = "postgresql://gbans:gbans@localhost:5432/gbans";
          };
        };
      };
      languages = {
        CSS = {
          "formatter" = {
            "language_server" = {
              "name" = "biome";
            };
          };
        };
        HTML = {
          "formatter" = {
            "language_server" = {
              "name" = "biome";
            };
          };
        };
        JSON = {
          "formatter" = {
            "language_server" = {
              "name" = "biome";
            };
          };
        };
        JSONC = {
          "formatter" = {
            "language_server" = {
              "name" = "biome";
            };
          };
        };

        JavaScript = {
          "formatter" = {
            "language_server" = {
              "name" = "biome";
            };
          };
          "code_actions_on_format" = {
            "source.fixAll.biome" = true;
            "source.organizeImports.biome" = true;
          };
        };
        TypeScript = {
          "formatter" = {
            "language_server" = {
              "name" = "biome";
            };
          };
          "code_actions_on_format" = {
            "source.fixAll.biome" = true;
            "source.organizeImports.biome" = true;
          };
        };
        TSX = {
          "formatter" = {
            "language_server" = {
              "name" = "biome";
            };
          };
          "code_actions_on_format" = {
            "source.fixAll.biome" = true;
            "source.organizeImports.biome" = true;
          };
        };
        Proto = {
          language_servers = [
            "buf"
            "!protobuf-language-server"
            "!protols"
          ];
        };
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
