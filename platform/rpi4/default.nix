{
  config,
  lib,
  ...
}:
{
  imports = [
    ./audio.nix
    ./boot.nix
    ./cec.nix
    # ./disk.nix
    ./filesystem.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./network.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../env/no-sudo-pass.nix

    ../../users/root.nix
    ../../users/leigh.nix

    ../../modules/wifi.nix

    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];

  # Both RPi hosts must stay on the nixos-hardware linux-rpi kernel
  # (raspberrypi/linux stable, provided via the nixos-hardware
  # raspberry-pi-4 module imported in flake.nix for each host). This
  # follows the upstream recommendation: nixpkgs' pkgs.linuxPackages_rpi4
  # is deprecated and will be removed. Do NOT switch to it: it is older
  # (6.12 vs 6.18), and its output is not in any configured binary cache
  # either, so it would still compile from source under emulation.
  assertions = [
    {
      assertion = config.boot.kernelPackages.kernel.pname == "linux-rpi";
      message = "RPi hosts must use the stock linux-rpi kernel, got: ${config.boot.kernelPackages.kernel.pname}";
    }
  ];
}
