{
  pkgs,
  lib,
  ...
}:
let
  rtk = pkgs.llm-agents.rtk;

  # rtk-proxy is a separate crate in the rtk source tree with its own lockfile;
  # the llm-agents flake only packages the CLI. Build the daemon from the exact
  # same source revision so the two stay in sync.
  rtk-proxy = pkgs.rustPlatform.buildRustPackage {
    pname = "rtk-proxy";
    inherit (rtk) version src;

    cargoRoot = "proxy";
    buildAndTestSubdir = "proxy";
    cargoLock = {
      lockFile = "${rtk.src}/proxy/Cargo.lock";
      outputHashes = {
        "icm-core-0.10.34" = "sha256-ihiVf3ghIeK3ivW+mxTQrJDSVu2vlM8YHWoLokvlaag=";
        "icm-store-0.10.34" = "sha256-ihiVf3ghIeK3ivW+mxTQrJDSVu2vlM8YHWoLokvlaag=";
      };
    };

    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = [ pkgs.sqlite ];
    env.LIBSQLITE3_SYS_USE_PKG_CONFIG = "1";
    doCheck = false;

    meta = {
      description = "Local LLM proxy that compresses context before forwarding it upstream";
      homepage = "https://github.com/rtk-ai/rtk";
      license = lib.licenses.bsl11;
      mainProgram = "rtk-proxy";
    };
  };

  # llama-swap keeps the backend port; clients keep using the old port 8080,
  # which is now served by rtk-proxy and forwarded to llama-swap.
  llamaSwapPort = 8081;
  proxyPort = 8080;
in
{
  environment.systemPackages = [
    rtk
    rtk-proxy
  ];

  users.groups.rtk-proxy = { };
  users.users.rtk-proxy = {
    isSystemUser = true;
    group = "rtk-proxy";
  };

  systemd.services.rtk-proxy = {
    description = "RTK proxy in front of llama-swap";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network.target"
      "llama-swap.service"
    ];
    serviceConfig = {
      ExecStart = "${rtk-proxy}/bin/rtk-proxy start";
      User = "rtk-proxy";
      Group = "rtk-proxy";
      StateDirectory = "rtk-proxy";
      Restart = "on-failure";
      RestartSec = 2;
    };
    environment = {
      RTK_PROXY_BIND = "0.0.0.0:${toString proxyPort}";
      RTK_PROXY_OPENAI_UPSTREAM = "http://127.0.0.1:${toString llamaSwapPort}";
      # Point the Anthropic dialect at the local backend too, so a stray
      # /v1/messages request never leaks its key to api.anthropic.com.
      RTK_PROXY_ANTHROPIC_UPSTREAM = "http://127.0.0.1:${toString llamaSwapPort}";
      RTK_PROXY_DB = "/var/lib/rtk-proxy/rtk-proxy.db";
      RTK_PROXY_ICM_DB = "/var/lib/rtk-proxy/rtk-proxy-memory.db";
    };
  };

  networking.firewall.allowedTCPPorts = [ proxyPort ];
}
