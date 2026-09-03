{
  pkgsUnstable,
  config,
  ...
}: {
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
      environmentFile = "/etc/llama-swap/envfile";
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
      protoc-gen-go
      protoc-gen-connect-go
      oapi-codegen
      sql-formatter
      protoc-gen-es
      protobuf-language-server
      rcon-cli
      govulncheck
      pgcli
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
    skills = {
      golang-concurrency = "./skills/golang-concurrency";
      golang-context = "./skills/golang-context";
      golang-design-patterns = "./skills/golang-design-patterns";
      golang-error-handling = "./skills/golang-error-handling";
      golang-gopls = "./skills/golang-gopls";
      golang-performance = "./skills/golang-performance";
      golang-testing = "./skills/golang-testing";
      sourcemod = "./skills/sourcemod";
    };
    settings = {
      plugin = [
        "opencode-skills"
        "@simonwjackson/opencode-direnv"
        # "@plannotator/opencode@latest"
      ];
      default_agent = "plan";
      share = "disabled";
      formatter = true;
      autoupdate = false;
      #      lsp = {
      #        command = ["${pkgsUnstable.sourcepawn-studio}/bin/sourcepawn-studio"];
      #        initialization = {
      #          hover_actions_debug_enable = true;
      #          hover_actions_enable = true;
      #          hover_actions_gotoTypeDef_enable = true;
      #          hover_actions_implementations_enable = true;
      #          hover_actions_references_enable = true;
      #          hover_actions_run_enable = true;
      #          eventsGameName = "Team Fortress 2";
      #          includeDirectories = [
      #            "${homeDir}/.sm-pkg/sdks/current/addons/sourcemod/scripting/include"
      #          ];
      #          compiler = {
      #            path = "${homeDir}/.sm-pkg/sdks/current/addons/sourcemod/scripting/spcomp64";
      #          };
      #        };
      #      };
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
            apiKey = "{file:~/.config/opencode/apikey}";
          };
          models = {
            "Qwen3.8-27B-UD-Q4_K_XL" = {
              name = "Qwen3.8-27B-UD-Q4_K_XL";
              limit = {
                context = 200000;
                output = 65536;
              };
              "reasoning" = true;
              "options" = {
                "reasoningEffort" = "xhigh";
              };
              modalities = {
                input = [
                  "text"
                ];
                output = [
                  "text"
                ];
              };
            };

            "Qwen3.8-27B-UD-Q4_K_M" = {
              name = "Qwen3.8-27B-UD-Q4_K_M";
              limit = {
                context = 128000;
                output = 65536;
              };
              "reasoning" = true;
              "options" = {
                "reasoningEffort" = "xhigh";
              };
              modalities = {
                input = [
                  "text"
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
}
