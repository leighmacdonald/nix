{ pkgs, ... }:

{
  stylix.targets.firefox.profileNames = [
    "frankie"
  ];
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.keepassxc ];

    profiles = {
      frankie = {
        isDefault = true;
        name = "frankie";
        settings = {
          "webgl.disabled" = false;
          "privacy.resistFingerprinting" = false;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "network.cookie.lifetimePolicy" = 0;
          #"browser.cache.disk.enable" = false;
          #"browser.cache.memory.capacity" = -1;
          #"browser.cache.memory.enable" = true;
        };
        extensions = {
          force = true;
        };
      };
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      ExtensionSettings = {
        "dev@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "team@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc_browser/latest.xpi";
          installation_mode = "force_installed";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-ZAdIEUB7XOzOJw@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
