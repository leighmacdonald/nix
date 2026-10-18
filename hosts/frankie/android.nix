{
  pkgs,
  ...
}:
{
  # Required to build the SDK (accepts android-sdk-license).
  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    # Full SDK composition (platforms, build-tools, cmdline-tools).
    # Also exposes adb/fastboot in bin/. Device access is handled by
    # systemd uaccess rules, no extra group needed.
    androidenv.androidPkgs.androidsdk
  ];
}
