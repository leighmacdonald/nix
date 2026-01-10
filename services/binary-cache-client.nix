{
  environment.etc = {
    "nix/update-to-cache.sh" = {
      text = ''
        #!/bin/sh
              set -eu
              set -f # disable globbing
              export IFS=' '
              echo "Uploading paths" $OUT_PATHS
              exec nix copy --to "https://cache.roto.lol" $OUT_PATHS || exit 0"
      '';
      mode = "0777";
    };
  };
}
