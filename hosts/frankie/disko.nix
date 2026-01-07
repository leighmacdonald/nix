{ ... }:
{

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "boot";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              label = "luks";
              content = {
                type = "luks";
                name = "cryptroot";

                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];

                # disable settings.keyFile if you want to use interactive password entry
                #passwordFile = "/tmp/secret.key"; # Interactive
                #settings = {
                #  allowDiscards = true;
                #  keyFile = "/tmp/secret.key";
                #};
                #additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "nixos"
                    "-f"
                  ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "subvol=root"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "subvol=home"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    #            "/persist" = {
                    #              mountpoint = "/persist";
                    #              mountOptions = [
                    #                "subvol=persist"
                    #                "compress=zstd"
                    #                "noatime"
                    #              ];
                    #            };
                    #    "/log" = {
                    #      mountpoint = "/var/log";
                    #      mountOptions = [
                    #        "subvol=log"
                    #        "compress=zstd"
                    #        "noatime"
                    #      ];
                    #    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "subvol=nix"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "32G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  #  fileSystems."/" = {
  #	device = "none";
  #	fsType = "tmpfs";
  #	options = [
  #		"size=3G"
  #	  	"mode=755"
  #	];
  #  };
  #
  #  fileSystems."/persist".neededForBoot = true;

  #  environment.persistence."/persist" = {
  #	enable = true;
  #	hideMounts = true;
  #	directories = [
  #		"/var/log"
  #		"/var/lib/nixos"
  #		"/var/lib/systemd/coredump"
  #	];
  #	files = [
  #		"/etc/machine-id"
  #		"/etc/enc.key"
  #		"/etc/sops/age/keys.txt"
  #	];
  #	users.${username} = {
  #		directories = [
  #			"nix"
  #			"projects"
  #			".local/share/direnv"
  #			#{ directory = ".ssh"; mode = "0700"; }
  #			{ directory = ".gnupg"; mode = "0700"; }
  #			{ directory = ".local/share/keyrings"; mode = "0700";}
  #			#{ directory = ".local/share/Steam"; method = "symlink";}
  #
  #		];
  #
  #  	};
  #};
}
