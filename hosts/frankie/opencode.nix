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
      environmentFile = "/etc/opencode/envfile";
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
            baseURL = "http://localhost:8080/v1";
            apiKey = "xxx";
          };
          models = {
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
              };
            };
            "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP" = {
              name = "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP";
              limit = {
                context = 128000;
                output = 65536;
              };
            };
          };
        };
      };
    };
  };
}
