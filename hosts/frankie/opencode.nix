{ pkgsUnstable, ... }: {
  programs.opencode = {
    enable = true;
    package = pkgsUnstable.opencode;
    web = {
      enable = true;
    };
    settings = {
      mcp = {
        postgres = {
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
          ];
        };
      };
    };
  };
}
