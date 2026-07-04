{ pkgsUnstable, ... }: {
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    package = pkgsUnstable.opencode;
    web = {
      enable = true;
    };
    settings = {
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
      mcp = {
        postgres = {
          type = "local";
          enabled = true;
          command = [
            "docker"
            "run"
            "-i"
            "--rm"
            "-e"
            "DATABASE_URI"
            "crystaldba/postgres-mcp"
            "--access-mode=unrestricted"
          ];
          env = {
            "DATABASE_URI" = "postgresql://gbans:gbans@localhost:5432/gbans";
          };
        };

        chrome = {
          enabled = true;
          type = "local";
          command = [
            "npx"
            "-y"
            "chrome-devtools-mcp@latest"
            "--auto-connect"
            "--browser-url=http://127.0.0.1:9222"
          ];
        };
      };
    };
  };
}
