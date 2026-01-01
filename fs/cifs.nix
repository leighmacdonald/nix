{ config, username, ... }:
{
  fileSystems = {
    "/mnt/storage" = {
      device = "//192.168.0.201/storage";
      fsType = "cifs";
      options =
        let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        in
        [
          "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${
            toString config.users.users.${username}.uid
          },gid=${toString config.users.groups.lusers.gid}"
        ];
    };
    "/mnt/backup" = {
      device = "//192.168.0.201/leigh";
      fsType = "cifs";
      options =
        let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        in
        [
          "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${
            toString config.users.users.${username}.uid
          },gid=${toString config.users.groups.lusers.gid}"
        ];
    };
  };
}
