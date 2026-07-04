{
  programs.mcp = {
    enable = true;
    servers = {
      postgres = {
        command = "docker";
        args = [
          "run"
          "-i"
          "--rm"
          "-e"
          "DATABASE_URI"
          "crystaldba/postgres-mcp"
          "--access-mode=unrestricted"
        ];
      };
      chrome = {
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
