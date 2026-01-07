nix build ".#nixosConfigurations.${1}.config.system.build.sdImage" -o sdcard_${1}.img
