{ username, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Libvirt
  services.spice-webdavd.enable = true;
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ username ];
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];
  };
}
