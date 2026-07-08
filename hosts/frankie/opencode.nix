{
  pkgsUnstable,
  config,
  ...
}: {
  stylix.targets.opencode.enable = false;

  xdg.configFile = {
    "opencode/plugins/opencode-review.ts".source =
      config.lib.file.mkOutOfStoreSymlink "/projects/opencode-review/src/index.ts";
    "opencode/themes/ayu-dark.json".source =
      config.lib.file.mkOutOfStoreSymlink "/projects/opencode-ayu-theme/.opencode/themes/ayu-dark.json";
  };

  programs.opencode = {
    tui = {
      theme = "ayu-dark";
    };
    enable = true;
    enableMcpIntegration = true;
    extraPackages = with pkgsUnstable; [
      uv
      shfmt
      ripgrep
      biome
      rustfmt
      clang-tools
      nixfmt
      direnv
    ];
    package = pkgsUnstable.opencode;
    web = {
      enable = true;
    };
    settings = {
      plugin = ["opencode-review" "@simonwjackson/opencode-direnv"];

      formatter = true;
      permission = {
        "*" = "allow";
        # edit = "allow";
        # bash = "allow";
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
            };
            "Qwen3.6-27B-UD-Q5_K_XL" = {
              name = "Qwen3.6-27B-UD-Q5_K_XL";
              limit = {
                context = 128000;
                output = 65536;
              };
            };
            "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP-thinking" = {
              name = "Qwen3.6-35B-A3B-UD-Q4_K_XL-MTP-thinking";
              limit = {
                context = 128000;
                output = 65536;
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
