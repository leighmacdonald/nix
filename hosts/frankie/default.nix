{
  pkgs,
  inputs,
  username,
  ...
}:
{
  imports = [
    #    inputs.impermanence.nixosModules.impermanence
    ./boot.nix
    ./audio.nix
    ./disko.nix
    ./network.nix
    ./cpu.nix
    ./programs.nix
    ./persistence.nix

    ../../nix.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../env/no-sudo-pass.nix

    ../../users/leigh.nix

    ../../fs/nfs-mounts.nix

    ../../modules/documentation.nix
    ../../modules/fonts.nix
    ../../modules/nvidia.nix
    ../../modules/stylix.nix
    ../../modules/secrets.nix
    # ../../modules/zram.nix

    ../../services/docker.nix
    ../../services/node_exporter.nix
    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];

  home-manager.backupFileExtension = "backup";

  hardware = {
    bluetooth.enable = false;
    enableAllFirmware = true;
    nvidia-container-toolkit.enable = true;
  };

  stylix = {
    enable = true;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
  };

  sops.secrets = {
    listenbrainz_token = {
      owner = username;
    };
  };
  # xdg.configFile."fish/config.fish" = {
  #   force = true;
  # };

  #  systemd.targets."mnt-storage.mount" = {
  #    wants = [ "network.target" ];
  #  };

  systemd.user.services."mpd" = {
    wants = [ "mnt-storage.mount.target" ];
    bindsTo = [ "mnt-storage.mount.target" ];
  };

  # systemd.user.services.vicinae.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    steam = {
      enable = true;
      # extraCompatPckages = with pkgs; [
      #   proton-ge-bin
      # ];
      extraPackages = with pkgs; [
        gamescope
      ];
      extest.enable = true;
      gamescopeSession = {
        enable = true;
      };
      #protontricks.enable = true;
      #remotePlay.openFirewall= true;
    };
    uwsm = {
      enable = true;
    };
  };
}
