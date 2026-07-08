{ pkgsUnstable, lib, ... }:
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
      "cargotoml"
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
      edit_predictions = {
        provider = "open_ai_compatible_api";
        "open_ai_compatible_api" = {
          prompt_format = "infer";
          max_output_tokens = 512;
          model = "sweep-next-edit-1.5b.q8_0.v2";
          api_url = "http://localhost:8081/v1/completions";
        };
      };
      agent = {
        sidebar_side = "right";
        enable_feedback = false;
        show_turn_stats = true;
        default_profile = "ask";
        default_model = {
          provider = "mtp-llama";
          model = "Qwen3.6-27B-UD-Q5_K_XL";
          enable_thinking = false;
        };
        inline_alternatives = [
          {
            provider = "mtp-llama";
            model = "Qwen3.6-27B-Q4_K_M-MTP";
            enable_thinking = true;
          }
          {
            provider = "mtp-llama";
            model = "Qwen3.6-27B-UD-Q5_K_XL";
            enable_thinking = true;
          }
          {
            provider = "mtp-llama";
            model = "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP";
            enable_thinking = false;
          }
          {
            provider = "mtp-llama";
            model = "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP-thinking";
            enable_thinking = true;
          }
          {
            provider = "mtp-llama";
            model = "Nemotron-3-Nano-Omni-30B";
            enable_thinking = false;
          }
          {
            provider = "mtp-llama";
            model = "gemma-4-26B-A4B-it-UD-Q4_K_XL";
            enable_thinking = false;
          }
          {
            provider = "mtp-llama";
            model = "gemma-4-26B-A4B-it-UD-Q4_K_XL-thinking";
            enable_thinking = true;
          }
        ];
        favorite_models = [ ];
        model_parameters = [ ];
        tool_permissions = {
          default = "allow";
          tools = {
            fetch = {
              default = "allow";
            };
            terminal = {
              default = "allow";
              # always_allow = [
              #   { pattern = "^cargo\\s+(build|test|check)"; }
              #   { pattern = "^npm\\s+(install|test|run)"; }
              # ];
              always_confirm = [ { pattern = "sudo\\s+/"; } ];
              always_deny = [
                { pattern = "^/storage"; }
                { pattern = "^/etc"; }
                { pattern = "\\.env"; }
                { pattern = "secrets?/"; }
                { pattern = "\\.(pem|key)$"; }
              ];
            };
          };
        };
      };
      language_models = {
        openai_compatible = {
          mtp-llama = {
            api_url = "http://localhost:8080/v1";
            available_models = [
              {
                name = "Qwen3.6-27B-Q4_K_M-MTP";
                max_tokens = 200000;
                max_output_tokens = 200000;
                max_completion_tokens = 8192;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }

              {
                name = "Qwen3.6-27B-Q4_K_M-MTP";
                max_tokens = 200000;
                max_output_tokens = 200000;
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
                name = "Qwen3.6-27B-UD-Q5_K_XL";
                max_tokens = 200000;
                max_output_tokens = 200000;
                max_completion_tokens = 128000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP";
                max_tokens = 200000;
                max_output_tokens = 200000;
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
                name = "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP-thinking";
                max_tokens = 200000;
                max_output_tokens = 200000;
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
                name = "Nemotron-3-Nano-Omni-30B";
                max_tokens = 200000;
                max_output_tokens = 200000;
                max_completion_tokens = 64000;
                capabilities = {
                  tools = true;
                  images = true;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "gemma-4-31B-it-UD-Q5_K_XL-thinking";
                max_tokens = 200000;
                max_output_tokens = 200000;
                max_completion_tokens = 64000;
                capabilities = {
                  tools = true;
                  images = true;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "gemma-4-26B-A4B-it-UD-Q4_K_XL-thinking";
                max_tokens = 200000;
                max_output_tokens = 200000;
                max_completion_tokens = 64000;
                capabilities = {
                  tools = true;
                  images = true;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
              {
                name = "gemma-4-26B-A4B-it-UD-Q4_K_XL";
                max_tokens = 200000;
                max_output_tokens = 200000;
                max_completion_tokens = 64000;
                capabilities = {
                  tools = true;
                  images = true;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
            ];
          };
        };
      };
      #theme = "Catppuccin Mocha";
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
        dock = "left";
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
      auto_signature_help = false;
      base_keymap = "JetBrains";
      buffer_font_family = lib.mkForce "TX-02";
      ui_font_family = lib.mkForce "TX-02";
      lsp = {
        golangci-lint = {
          initialization_options = {
            command = [
              "golangci-lint"
              "run"
              "--output.json.path"
              "stdout"
              "--show-stats=false"
              "--output.text.path="
            ];
          };
        };
        sourcepawn-studio = {
          initialization_options = {
            hover_actions_debug_enable = true;
            hover_actions_enable = true;
            hover_actions_gotoTypeDef_enable = true;
            hover_actions_implementations_enable = true;
            hover_actions_references_enable = true;
            hover_actions_run_enable = true;
            eventsGameName = "Team Fortress 2";
            includeDirectories = [
              "/home/leigh/.sm-pkg/sdks/current/addons/sourcemod/scripting/include"
            ];
            compiler = {
              path = "/home/leigh/.sm-pkg/sdks/current/addons/sourcemod/scripting/spcomp64";
            };
          };
        };
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
        Go = {
          language_servers = [
            "gopls"
            "golangci-lint"
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
