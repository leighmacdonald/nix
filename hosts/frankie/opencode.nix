{
  pkgsUnstable,
  config,
  ...
}:
{
  stylix.targets.opencode.enable = false;

  xdg.configFile = {
    "opencode/themes/ayu-dark.json".source =
      config.lib.file.mkOutOfStoreSymlink "/projects/opencode-ayu-theme/.opencode/themes/ayu-dark.json";
  };

  programs.opencode = {
    tui = {
      theme = "ayu-dark";
      scroll_speed = 3;
      scroll_acceleration = {
        enabled = true;
      };
      diff_style = "auto";
      mouse = true;
      attention = {
        enabled = true;
        notifications = true;
        sound = true;
        volume = 0.4;
      };
    };
    web = {
      enable = true;
      extraArgs = [
        "--hostname"
        "0.0.0.0"
        "--port"
        "8090"
        "--mdns"
      ];
      #environmentFile = "/etc/opencode/envfile";
    };
    enable = true;
    enableMcpIntegration = false; # prefer per project configs
    extraPackages = with pkgsUnstable; [
      uv
      nodejs
      shfmt
      ripgrep
      biome
      rustfmt
      clang-tools
      nixfmt
      direnv
      ansible-lint
      git
      nil
      nixd
      nvd
      nixpkgs-fmt
      nixfmt
      statix
      deadnix
      just
      just-lsp
      lua-language-server
      gcc
      go
      golangci-lint
      nilaway
      pnpm_11
      buf
      delve
      markdownlint-cli2
      sourcepawn-studio
      buf
      protoc-gen-go
      protoc-gen-connect-go
      oapi-codegen
      sql-formatter
      protoc-gen-es
      protobuf-language-server
      rcon-cli
      clang-tools
      govulncheck
      pgcli
      biome
      netcat-gnu
    ];
    package = pkgsUnstable.opencode;
    agents = {
      code-reviewer = ''
        # Code Reviewer Agent

        You are a senior software engineer specializing in code reviews.
        Focus on code quality, security, and maintainability.

        ## Guidelines
        - Review for potential bugs and edge cases
        - Check for security vulnerabilities
        - Ensure code follows best practices
        - Suggest improvements for readability and performance
      '';
    };
    settings = {
      plugin = [
        "opencode-review"
        "@simonwjackson/opencode-direnv"
        "@plannotator/opencode@latest"
      ];
      default_agent = "plan";
      share = "disabled";
      formatter = true;
      autoupdate = false;
      lsp = true;
      compaction = {
        auto = true;
        prune = true;
        reserved = 10000;
      };
      permission = {
        "*" = "allow";
        # edit = "allow";
        # bash = "allow";
      };
      watcher = {
        ignore = [
          "node_modules/**"
          "dist/**"
          ".git/**"
          ".direnv/**"
        ];
      };
      attachment = {
        image = {
          auto_resize = true;
          max_width = 2000;
          max_height = 2000;
          max_base64_bytes = 5242880;
        };
      };
      provider = {
        custom-local = {
          npm = "@ai-sdk/openai-compatible";
          name = "local";
          options = {
            baseURL = "https://llm.roto.lol/v1";
            apiKey = "xxx";
          };
          models = {
            "North-Mini-Code-1.0-UD-Q4_K_M" = {
              name = "North-Mini-Code-1.0-UD-Q4_K_M";
              limit = {
                context = 256000;
                output = 65536;
              };
              "reasoning" = true;
              "options" = {
                "reasoningEffort" = "high";
              };
            };

            "gemma-4-26B-A4B-it-UD-Q4_K_XL-thinking" = {
              name = "gemma-4-26B-A4B-it-UD-Q4_K_XL-thinking";
              limit = {
                context = 256000;
                output = 65536;
              };
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [
                  "text"
                ];
              };

              "reasoning" = true;
              "options" = {
                "reasoningEffort" = "high";
              };
            };

            "gemma-4-26B-A4B-it-qat-UD-Q4_K_XL" = {
              name = "gemma-4-26B-A4B-it-qat-UD-Q4_K_XL";
              limit = {
                context = 256000;
                output = 65536;
              };
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [
                  "text"
                ];
              };
            };

            "gemma-4-31B-it-qat-UD-Q4_K_XL" = {
              name = "gemma-4-31B-it-qat-UD-Q4_K_XL";
              limit = {
                context = 256000;
                output = 65536;
              };
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [
                  "text"
                ];
              };
            };

            "Qwen3.6-27B-Q4_K_M-MTP" = {
              name = "Qwen3.6-27B-Q4_K_M-MTP";
              limit = {
                context = 128000;
                output = 65536;
              };
              "reasoning" = true;
              "options" = {
                "reasoningEffort" = "high";
              };
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [
                  "text"
                ];
              };
            };

            "Qwopus3.6-27B-Coder-MTP-Q4_K_M" = {
              name = "Qwopus3.6-27B-Coder-MTP-Q4_K_M";
              limit = {
                context = 128000;
                output = 65536;
              };
              reasoning = false;
              modalities = {
                input = [
                  "text"
                ];
                output = [
                  "text"
                ];
              };
            };

            "Qwopus3.6-27B-Coder-MTP-Q4_K_M-think" = {
              name = "Qwopus3.6-27B-Coder-MTP-Q4_K_M-think";
              limit = {
                context = 128000;
                output = 65536;
              };
              reasoning = true;
              modalities = {
                input = [
                  "text"
                ];
                output = [
                  "text"
                ];
              };
              options = {
                reasoningEffort = "high";
              };
            };
            "Qwopus3.6-27B-Coder-MTP-Q5_K_M" = {
              name = "Qwopus3.6-27B-Coder-MTP-Q5_K_M";
              limit = {
                context = 128000;
                output = 65536;
              };
              reasoning = false;
              modalities = {
                input = [
                  "text"
                ];
                output = [
                  "text"
                ];
              };
            };
            "Qwopus3.6-27B-Coder-MTP-Q5_K_M-think" = {
              name = "Qwopus3.6-27B-Coder-MTP-Q5_K_M-think";
              limit = {
                context = 128000;
                output = 65536;
              };
              reasoning = true;
              options = {
                reasoningEffort = "high";
              };
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [
                  "text"
                ];
              };
            };
            "Qwen3.6-27B-UD-Q5_K_XL" = {
              name = "Qwen3.6-27B-UD-Q5_K_XL";
              limit = {
                context = 128000;
                output = 65536;
              };
              "reasoning" = true;
              "options" = {
                "reasoningEffort" = "high";
              };
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [
                  "text"
                ];
              };
            };
            "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP-thinking" = {
              name = "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP-thinking";
              limit = {
                context = 128000;
                output = 65536;
              };
              "reasoning" = true;
              "options" = {
                "reasoningEffort" = "high";
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };
            };
            "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP" = {
              name = "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP";
              limit = {
                context = 128000;
                output = 65536;
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
