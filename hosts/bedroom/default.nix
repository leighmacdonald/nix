{
  pkgs,
  config,
  username,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../fs/cifs.nix

    ../../nix.nix
  ];
  # an overlay to enable raspberrypi support in libcec, and thus cec-client
  nixpkgs.overlays = [
    (self: super: { libcec = super.libcec.override { withLibraspberrypi = true; }; })
  ];

  hardware = {
    enableRedistributableFirmware = true;
    raspberry-pi."4".fkms-3d.enable = true;
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      overlays = [
        {
          name = "disable-bt";
          filter = "*rpi-4-b*";
          dtsText = ''
            /dts-v1/;
            /plugin/;
            /{
                compatible = "raspberrypi,4-model-b";
                fragment@0 {
                    target = <&bt>;
                    __overlay__ {
                        status = "disabled";
                    };
                };
            };
          '';
        }
        {
          name = "disable-eth-leds";
          filter = "*rpi-4-b*";
          dtsText = ''
            /dts-v1/;
            /plugin/;
            /{
               compatible = "raspberrypi,4-model-b";
               fragment@0 {
                    target = <&phy1>;
                    __overlay__ {
                        led-modes = <0x04 0x04>;
                    };
                };
            };
          '';
        }
      ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible = {
        enable = true;
        configurationLimit = 3;
      };
    };
    # Enable audio devices
    kernelParams = [
      "snd_bcm2835.enable_hdmi=1"
      "snd_bcm2835.enable_headphones=1"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  networking = {
    hostName = "bedroom";
    wireless = {
      enable = true;
      secretsFile = "/run/secrets/wireless.conf";
      networks = {
        badjackie = {
          priority = 1;
          pskRaw = "ext:psk_badjackie";
        };
      };
      interfaces = [ "wlan0" ];
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      # allowedUDPPorts = [ ... ];
    };

    #networkmanager.enable = true;
    #networkmanager.wifi.powersave = false;
  };

  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    enable = false;
    font = "Lat2-Terminus16";
    keyMap = "us";
    useXkbConfig = true;
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      xkb.layout = "us";
    };
    printing.enable = false;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    libinput.enable = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = false;
    groups = {
      lusers.gid = 2000;
    };
    users."${username}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPasswordFile = config.sops.secrets.password.path;
      uid = 2000;
      group = "lusers";
      createHome = true;
      shell = pkgs.fish;
      #packages = with pkgs; [
      #
      #];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAyvIW5JmPEviReir7aTLGDlXPX2yaI/P3/2244OC/vdEglpmsMbrXQqxkBXUd7Oh1/4f6xF0BvKGUWuqVg5ctuf9S7DZRBBYrXz66zYKiSi6uhuVdBfOCB8+4AVGCVspeapzZ0JB0H6yy/LVrmG69Z7PZKerPw+9KLAIcX4I4COrmmkbeOfShV6Nu+MeP6P6wWXzj2UcI4qcCoHJMR9iX3o63ml1PRI/CO5ZuDnTrOY/iEcg4+pvJaqBSKo3UejzikwQ35gEKOy7WHQFj1YfTbFa7Lp91Ee+6SVhJag5zLyGqNiK/vhLjGCQ4yb+0140wtUiwOZT5ELhsycA3cICmsw=="
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      wget
      libraspberrypi
      libcec
      raspberrypi-eeprom
      home-manager
      cifs-utils
    ];
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = false;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    thunar = {
      enable = true;
    };
    appimage = {
      enable = true;
      binfmt = true;
    };
    fish = {
      enable = true;
    };
  };

  services = {
    openssh = {
      enable = true;
    };

    displayManager = {
      defaultSession = "hyprland-uwsm";
      sddm.enable = true;
      sddm.wayland.enable = true;
      autoLogin.enable = true;
      autoLogin.user = username;
    };

    udev.extraRules = ''
      KERNEL=="vchiq", GROUP="video", MODE="0660", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/vchiq"
    '';
  };
  systemd = {
    sockets."cec-client" = {
      after = [ "dev-vchiq.device" ];
      bindsTo = [ "dev-vchiq.device" ];
      wantedBy = [ "sockets.target" ];
      socketConfig = {
        ListenFIFO = "/run/cec.fifo";
        SocketGroup = "video";
        SocketMode = "0660";
      };
    };
    services."cec-client" = {
      after = [ "dev-vchiq.device" ];
      bindsTo = [ "dev-vchiq.device" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = ''${pkgs.libcec}/bin/cec-client -d 1'';
        ExecStop = ''/bin/sh -c "echo q > /run/cec.fifo"'';
        StandardInput = "socket";
        StandardOutput = "journal";
        Restart = "no";
      };
    };
  };
  system = {
    stateVersion = "26.05";
    copySystemConfiguration = false;
  };
}
