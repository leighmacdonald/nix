{
  programs.mcp = {
    enable = true;
    servers = {
      postgres = {
        enabled = true;
        command = "uvx";
        args = [
          "postgres-mcp"
          "--access-mode=unrestricted"
        ];
        env = {
          DATABASE_URI = "postgresql://gbans:gbans@localhost:5432/gbans";
        };
      };
      chrome = {
        enabled = true;
        command = "npx";
        args = [
          "-y"
          "chrome-devtools-mcp@latest"
          "--auto-connect"
          "--browser-url=http://127.0.0.1:9222"
        ];
      };
    };
  };
}
