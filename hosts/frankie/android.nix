{
  pkgs,
  username,
  ...
}:
{
  # Required to build the SDK (accepts android-sdk-license).
  nixpkgs.config.android_sdk.accept_license = true;

  # adb udev rules + adbusers group.
  programs.adb.enable = true;
  users.users.${username}.extraGroups = [ "adbusers" ];

  environment.systemPackages = with pkgs; [
    androidenv.androidPkgs.androidsdk
    androidenv.androidPkgs.platform-tools
  ];
}
