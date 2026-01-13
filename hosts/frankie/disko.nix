{ inputs, ... }:
{
  imports = [ inputs.disko.nixosModules.disko ];
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S6B0NJ0RB14281T";
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
                mountpoint = "/boot/efi";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
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
                    #"/root" = {
                    #  mountpoint = "/";
                    #  mountOptions = [
                    #    "subvol=root"
                    #    "compress=zstd"
                    #    "noatime"
                    #  ];
                    #};
                    "/etc/sops" = {
                      mountpoint = "/etc/sops";
                      mountOptions = [
                        "subvol=sops"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "subvol=persist"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "subvol=nix"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    # "/projects" = {
                    #   mountpoint = "/projects";
                    #   mountOptions = [
                    #     "subvol=projects"
                    #     "compress=zstd"
                    #     "noatime"
                    #   ];
                    # };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "32G";
                      #options = [ "noauto" ];
                    };
                  };
                };
              };
            };
          };
        };
      };

      # projects = {
      #   type = "disk";
      #   device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_1TB_S5P2NG0R404138D";
      #   content = {
      #     type = "gpt";
      #     partitions = {
      #       luks = {
      #         size = "100%";
      #         content = {
      #           type = "luks";
      #           name = "cryptproj";

      #           extraOpenArgs = [
      #             "--allow-discards"
      #             "--perf-no_read_workqueue"
      #             "--perf-no_write_workqueue"
      #           ];

      #           content = {
      #             type = "btrfs";
      #             extraArgs = [
      #               "-L"
      #               "projects"
      #               "-f"
      #             ];
      #             subvolumes = {
      #               "/projects" = {
      #                 mountpoint = "/projects";
      #                 mountOptions = [
      #                   "subvol=projects"
      #                   "compress=zstd"
      #                   "noatime"
      #                 ];
      #               };
      #             };
      #           };
      #         };
      #       };
      #     };
      #   };
      # };
    };
  };
}
