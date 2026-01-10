{
  environment.etc = {
    "nix/upload-to-cache.sh" = {
      text = ''
        #!/bin/sh

        set -eu
        set -f # disable globbing
        export IFS=' '
        echo "Uploading paths" $OUT_PATHS
        exec nix copy --to "ssh://nix-ssh@cache.roto.lol" $OUT_PATHS || true"
        echo "Uploading paths" $DRV_PATH
        exec nix copy --to "ssh://nix-ssh@cache.roto.lol" $DRV_PATH || true"
      '';
      mode = "0777";
    };
  };
}
