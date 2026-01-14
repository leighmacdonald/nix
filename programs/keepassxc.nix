{
  programs = {
    git-credential-keepassxc = {
      enable = true;
      groups = [ "SSH" ];
    };
    # https://github.com/keepassxreboot/keepassxc/blob/647272e9c5542297d3fcf6502e6173c96f12a9a0/src/core/Config.cpp#L49-L223
    keepassxc = {
      enable = true;
      #autostart = true;
      settings = {
        General = {
          AutoGeneratePasswordForNewEntries = true;
          ConfigVersion = 2;
          MinimizeAfterUnlock = true;
        };
        SSHAgent = {
          Enabled = true;
          # UseOpenSSH = true;
          # AuthSockOverride
          # SecurityKeyProviderOverride
        };
        Browser = {
          Enabled = true;
          UpdateBiaryPath = false;
        };
        GUI = {
          ApplicationTheme = "classic";
          CompactMode = true;
          MinimizeOnClose = true;
          MinimizeToTray = true;
          ShowTrayIcon = true;

          TrayIconAppearance = "monochrome-light";
        };

        PasswordGenerator = {
          Length = 20;
        };

        Security = {
          ClearClipboard = false;
          IconDownloadFallback = true;
          LockDatabaseIdle = false;
        };

        FdoSecrets = {
          Enabled = true;
        };
      };
    };
  };
}
